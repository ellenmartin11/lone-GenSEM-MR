###While this is a shell script, it was executed using the terminal within RStudio. 

# some useful commands
cd PATHxxx # go to working directory xxx
cd
cd # go to your home directory
cd .. # go to one level up
cp OLDFILE NEWFILE # copy file
mv OLDFILE NEWFILE # move file
qsub JOB.sh # submit job
qstat # check job status
jobhist # check finished job

#========================================================================================#
#  ======== CONNECT TO CLUSTER  =========================================================#
#========================================================================================#
set DISPLAY= #for some, this is necessary to allow users to SSH
#ssh here

# =======Define Home directory ================
HOME="/lustre/scratch/scratch/zcjtejm"
# ======= Define local directory ==============
LOCAL="D:/GSEM/processed GSEM data/GSEMcleansumstats"
# ======= Pathname where all gwas sumstats are stored  ==============
gwasDir="/lustre/scratch/scratch/zcjtejm/data/processed"



# =========== LOAD REQUIRED SOFTWARES ================
# load R    
module unload -f compilers mpi gcc-libs
module load beta-modules
module load r/r-4.0.2_bc-3.11
# Load plink and python
module load plink/1.90b3.40
module load java/1.8.0_92


#========================================================================================#
#  ======== PREPARE R LIBRARIES =========================================================#
#========================================================================================#

# Create script containing required libraries and directories
cat > $HOME/analysis/input.R <<EOF
gwasDir='$gwasDir'
HOME='$HOME'
LOCAL='$LOCAL'
R_libPaths='$HOME/programs/R'
.libPaths(R_libPaths)
load.lib=c('devtools', 'dplyr','GenomicSEM', 'rdrop2', 'data.table','R.utils', 'parallel', 'phenoscanner',  'biomaRt', 'gprofiler2', 'VariantAnnotation', 'plyr', 'CMplot', 'openxlsx', 'BiocManager', 'Qtlizer', 'purrr')
sapply(load.lib,require,character=TRUE)
EOF

R
source("/lustre/scratch/scratch/zcjtejm/analysis/input.R")
.libPaths(R_libPaths)
update.packages(ask=FALSE, checkBuilt=TRUE) # Update packages after installing new version of R
# Check if all required packages are installed
install.lib <-load.lib[!load.lib %in% rownames(installed.packages())]

# Install missing packages
for(lib in install.lib) {
    install.packages(lib,dependencies=TRUE, lib=R_libPaths)
  }

# Load all packages
sapply(load.lib,require,character=TRUE)

packageVersion("lavaan")
install_version("lavaan", version = "0.6.7", repos = "http://cran.us.r-project.org", lib ="/lustre/scratch/scratch/zcjtejm/programs/R")
q(save="no")
#==========================================================================================#
#============== GENOMIC SEM SUMSTATS ======================================================#
#==========================================================================================#

setwd(gwasDir)
#computing sumstats for the 11 traits and storing them on the cluster 

GenSEM_sumstats <- sumstats(files=c("DemontisADHD_clean","SchumannALC_clean","OtowaANX_clean","GroveASD_clean","StahlBIP_clean","JohnsonCAN_clean","HowardMDD_clean","NievergeltPTSD_clean","PardinasSCZ_clean","WoottonSMK_clean","DayLONE_clean"),
                            ref= "reference.1000G.maf.0.005.txt.gz",
                            trait.names=c("ADHD","ALC","ANX","ASD","BIP","CAN","MDD","PTSD","SCZ","SMK","LONELINESS"),
                            se.logit=c(T,T,T,T,T,T,T,T,T,T,T),
                            info.filter=.6,
                            maf.filter=0.01)
#saving the GenSEM_sumstats 
save(GenSEM_sumstats, file = "/lustre/scratch/scratch/zcjtejm/data/processed/GenSEM_sumstats.RData")
summary(GenSEM_sumstats)


# ===== Save datasets with subsets of SNPs to reduce processing demands
# Split in subsets of SNPs
baseModel="GenSEMmodel"

n_chunks=500000
n_rows <- nrow(GenSEM_sumstats)
r  <- rep(1:ceiling(n_rows/n_chunks),each=n_chunks)[1:n_rows]
GenSEM_sumstats_list <- split(GenSEM_sumstats,r)
n_splits=seq(1:length(GenSEM_sumstats_list)) # Number of subsets:4
names(GenSEM_sumstats_list)=paste0("GenSem_sub_par", n_splits, "_", baseModel)

# Save output on cluster
sapply(names(GenSEM_sumstats_list), function(x) 
  write.table(GenSEM_sumstats_list[[x]], file=paste0(HOME, "/output/gwa_input/", x), 
              col.names=T, row.names=F, quote=F, sep="\t") )

# Create list for loop
gwa_input_name=names(GenSEM_sumstats_list)
write.table(gwa_input_name, 
            file=paste0(HOME, "/output/gwa_input/gwa_input_", baseModel),
            col.names=F, 
            row.names=F, 
            quote=F, 
            sep=" " )

#========================================================================================#
#  ======== RUN GWAS ====================================================================#
#========================================================================================#


#formatting LDSC for GenSEMrun()
load("/lustre/scratch/scratch/zcjtejm/output/rds/LDSCoutput/combined_covstruc.RData") 
data.frame(pheno = colnames(combined_covstruc$S_Stand),
           intercept = diag(combined_covstruc$I)) 

# Export and save
modelName="GenSEMmodel"
saveRDS(combined_covstruc, paste0(HOME,"/output/rds/LDSCoutput_", modelName, "_GenSEM.rds"))

###Running the GSEM model through the cluster 

#########################################


GenSEMrun () {

echo "use $nCores cores"
echo "create script for GenSEM when testing model: $model"

cd $HOME/output/batchlogs
for input in $(sort -u $HOME/output/gwa_input/gwa_input_${model})
do
echo Start $input
echo "save output file as $output"


cat > $HOME/output/batchlogs/${input}_${output}.R <<EOF
#!/usr/bin/env Rscript

HOME="${HOME}"
# Load libraries
source(paste0(HOME, "/analysis/input.R"))
libfolder=paste0(HOME,"/programs/R")
.libPaths(libfolder)
sapply(load.lib,require,character=TRUE)
library(GenomicSEM)


# Function to write log file

writeOut=function(line){
    write(line,
    file=paste0(HOME, "/output/batchlogs/${input}_${output}", "_GenSEMlog.txt"),
    append=TRUE)
    }
    
writeOut("load ldsc regression output")
print(paste0("Filename for rds file: ",HOME,"/output/rds/LDSCoutput_${model}_GenSEM.rds"))
writeOut("Check if correct file is loaded")
LDSCoutput_GenSEM=readRDS(paste0(HOME,"/output/rds/LDSCoutput_${model}_GenSEM.rds"))


dir(paste0(HOME, "/output/gwa_input/"))
writeOut("Select subset of SNPs")
inputPath=paste0(HOME, "/output/gwa_input/$input")
Model_D_SS_trunc=read.table(inputPath, header = TRUE)

writeOut(paste0("Number of SNPs included for this batch job: ", length(Model_D_SS_trunc[["SNP"]])))


GenSEMpar=function(SNPdata){
.libPaths(libfolder)

writeOut(paste0("Number of SNPs included: ", length(SNPdata[["SNP"]])))
writeOut("Define SEM model")

source(paste0(HOME, "/output/batchlogs/model_${model}_${output}.R"))
print(model)


start_time = Sys.time()
writeOut(paste0("Start time user GWAS: ",  start_time))


con <- file("$input.${output}.console.userGWA.log")
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")

# Run the model
results = userGWAS(covstruc=LDSCoutput_GenSEM,
                   SNPs=SNPdata,
                   estimation = ${estimation}, #"DWLS"
                   model = model,
                   printwarn = TRUE,
                   toler = 1e-200,
                   parallel = FALSE,
                   SNPSE = 0.0005,
                   sub=${extract},
                   GC="none")
print(str(results))


# Restore output to console
sink()
sink(type="message")


results=as.data.frame(results)


writeOut("I'm done with the model!")
writeOut(paste0("End time user model: ",  Sys.time()))


writeOut("Finished analysis for subset SNPs - return output")

return(results)

}
library(parallel)

writeOut("Setup parallel processing")
int <- $nCores
cl <- makeCluster(int)

print("Display info about each process in the cluster")
print(clusterCall(cl, function() Sys.info()))

writeOut(paste0("Create ", int, " subsets"))
Model_D_SS_trunc_list=split(Model_D_SS_trunc, sample(1:int, nrow(Model_D_SS_trunc), replace=T))
writeOut(paste0("Length of list: ", length(Model_D_SS_trunc_list), " subsets"))

nSNPsIteration <- do.call("rbind", lapply(Model_D_SS_trunc_list , function(x) length(x[["SNP"]])))
writeOut("Number of SNPs per subset included in clusterApply")
writeOut( nSNPsIteration)


writeOut("Export functions")
writeOut("Export packages")
clusterExport(cl, varlist=c("GenSEMpar", "libfolder", "HOME", "writeOut", "LDSCoutput_GenSEM"))
clusterEvalQ(cl, libfolder )
clusterEvalQ(cl, .libPaths(libfolder) )
clusterEvalQ(cl, library(GenomicSEM) )
clusterEvalQ(cl, c("GenSEMpar", "libfolder", "HOME", "writeOut", "LDSCoutput_GenSEM", library(GenomicSEM) ))


writeOut("Run genomicSEM for $input")
resultList=parLapply(cl, Model_D_SS_trunc_list,function(x) GenSEMpar(SNPdata=x))


writeOut("Finished genomicSEM for $input")


writeOut("bind output together")
results <- do.call("rbind", resultList)


writeOut("Save output on the cluster")
write.csv(results, file= paste0(HOME, "/output/csv/${input}_${output}", ".csv"))
writeOut("All output is saved on the cluster")

EOF


cat > $HOME/output/batchlogs/${input}_${output}.sh <<EOF
#!/bin/bash -l

#$ -l h_rt=$time:00:0
#$ -l mem=0.5G
#$ -N ${input}_${output}.sh
#$ -wd $HOME/output/batchlogs
#$ -pe smp $nCores
#$ -l tmpfs=15G

# Load packages
module unload -f compilers mpi gcc-libs
module load beta-modules
module load r/r-4.0.2_bc-3.11

export R_LIBS=$HOME/programs/R:$R_LIBS

R --no-save < $HOME/output/batchlogs/${input}_${output}.R > $HOME/output/batchlogs/${input}_${output}.batch.log

EOF

echo "Submit ${input}_${output} as batch job"

qsub $HOME/output/batchlogs/${input}_${output}.sh

done

}




# ======= Run function =======
# GenSEMmodel with constraints and loneliness as a latent indicator
# currently running
model="GenSEMmodel"
output="constr_corRes"
estimation='"DWLS"'
extract='c("F1~SNP")'
cat > $HOME/output/batchlogs/model_${model}_${output}.R <<EOF
model <- '
#CFA structure
      F1 =~ ADHD + ANX + ASD + PTSD + MDD
      F2 =~ ALC + CAN + SMK
      F3 =~ BIP + SCZ
#loneliness
      LONE =~ LONELINESS
      LONE~~1*LONE
      LONELINESS~~0*LONELINESS
      LONE ~ F1 + 0*F2 + 0*F3
#correlations between Factors
      F1 ~~ F2 + F3
      F2 ~~ F3
#F1 SNP effects
      F1 ~ SNP
#constraining resids to be > .001
      ADHD ~~ a*ADHD
      ANX ~~ c*ANX
      ASD ~~ d*ASD
      PTSD ~~ e*PTSD
      MDD ~~ f*MDD
      ALC ~~ g*ALC
      CAN ~~ h*CAN
      SMK ~~ i*SMK
      BIP ~~ j*BIP
      SCZ ~~ k*SCZ
      
      a > .001
      c > .001
      d > .001
      e > .001
      f > .001
      g > .001
      h > .001
      i > .001
      j > .001
      k > .001
#SNPs
      ADHD ~ 0*SNP
      ANX ~ 0*SNP
      ASD ~ 0*SNP
      PTSD ~ 0*SNP
      MDD ~ 0*SNP
      ALC ~ 0*SNP
      CAN ~ 0*SNP
      SMK ~ 0*SNP
      BIP ~ 0*SNP
      SCZ ~ 0*SNP'
EOF
nCores=16 # define number of cors
time=47 # running time in hours
GenSEMrun "nCores" "model" "output" "estimation" "extract" "time"

#Common factor model (heterogeneity test)
model="GenSEMmodel"
output="constr_corRes_HT"
estimation='"DWLS"'
extract='c("F1~~F1")'
cat > $HOME/output/batchlogs/model_${model}_${output}.R <<EOF
model <- '
#CFA structure
      F1 =~ ADHD + ANX + ASD + PTSD + MDD
      F2 =~ ALC + CAN + SMK
      F3 =~ BIP + SCZ
#loneliness
      LONE =~ LONELINESS
      LONE~~1*LONE
      LONELINESS~~0*LONELINESS
      LONE ~ F1 + 0*F2 + 0*F3
#correlations between Factors
      F1 ~~ F2 + F3
      F2 ~~ F3
#constraining resids to be > .001
      ADHD ~~ a*ADHD
      ANX ~~ c*ANX
      ASD ~~ d*ASD
      PTSD ~~ e*PTSD
      MDD ~~ f*MDD
      ALC ~~ g*ALC
      CAN ~~ h*CAN
      SMK ~~ i*SMK
      BIP ~~ j*BIP
      SCZ ~~ k*SCZ
      
      a > .001
      c > .001
      d > .001
      e > .001
      f > .001
      g > .001
      h > .001
      i > .001
      j > .001
      k > .001
      ADHD + ANX + ASD + PTSD + MDD + ALC + CAN + SMK + BIP + SCZ ~ SNP'
EOF
nCores=16 # define number of cors
time=47 # running time in hours
GenSEMrun "nCores" "model" "output" "estimation" "extract" "time"


qstat # check job status
jobhist

### unconstr model - to be run only if requested for sensitivity analysis
model="GenSEMmodel"
output="unconstr_corRes"
estimation='"DWLS"'
extract='c("F1~SNP")'
cat > $HOME/output/batchlogs/model_${model}_${output}.R <<EOF
model <- '
#CFA structure
      F1 =~ ADHD + ANX + ASD + PTSD + MDD
      F2 =~ ALC + CAN + SMK
      F3 =~ BIP + SCZ
#loneliness
      LONE =~ LONELINESS
      LONE~~1*LONE
      LONELINESS~~0*LONELINESS
      LONE ~ F1 + F2 + F3
#correlations between Factors
      F1 ~~ F2 + F3
      F2 ~~ F3
#F1 SNP effects
      F1 ~ SNP
#constraining resids to be > .001
      ADHD ~~ a*ADHD
      ANX ~~ c*ANX
      ASD ~~ d*ASD
      PTSD ~~ e*PTSD
      MDD ~~ f*MDD
      ALC ~~ g*ALC
      CAN ~~ h*CAN
      SMK ~~ i*SMK
      BIP ~~ j*BIP
      SCZ ~~ k*SCZ
      
      a > .001
      c > .001
      d > .001
      e > .001
      f > .001
      g > .001
      h > .001
      i > .001
      j > .001
      k > .001
#SNPs
      ADHD ~ 0*SNP
      ANX ~ 0*SNP
      ASD ~ 0*SNP
      PTSD ~ 0*SNP
      MDD ~ 0*SNP
      ALC ~ 0*SNP
      CAN ~ 0*SNP
      SMK ~ 0*SNP
      BIP ~ 0*SNP
      SCZ ~ 0*SNP'
EOF
nCores=16 # define number of cors
time=47 # running time in hours
GenSEMrun "nCores" "model" "output" "estimation" "extract" "time"


#========================================================================================#
#  ======== PROCESS GWAS OUTPUT =========================================================#
#========================================================================================#

#this is dependent on the Rscript processingMultiGWA.R
modelName="GenSEMmodel_constr_corRes"
cat > $HOME/analysis/processingMultiGWA.sh <<EOF
#!/bin/bash -l

#$ -l h_rt=3:30:0
#$ -l mem=1G
#$ -N processingMultiGWA.sh
#$ -wd $HOME/output/processingMultiGWA
#$ -pe smp 10
#$ -l tmpfs=15G

# Load packages
module unload -f compilers mpi gcc-libs
module load beta-modules
module load r/r-4.0.2_bc-3.11

R --no-save < $HOME/analysis/processingMultiGWA.R --args $HOME $modelName > $HOME/output/processingMultiGWA/processingMultiGWA.log
EOF
qsub $HOME/analysis/processingMultiGWA.sh
tail $HOME/output/processingMultiGWA/processingMultiGWA.log
qstat # check job status


##################################################################
# === Read in results  ===========================================
##################################################################

#ssh here 

# =======Define Home directory ==============
HOME="/lustre/scratch/scratch/zcjtejm"
# ======= Define local directory ==============
LOCAL="D:/GSEM/processed GSEM data/GSEMcleansumstats"
# ======= Pathname where all gwas sumstats are stored  ==============
gwasDir="/lustre/scratch/scratch/zcjtejm/data/processed"

# =========== LOAD REQUIRED SOFTWARES ================
# load R    
module unload -f compilers mpi gcc-libs
module load beta-modules
module load r/r-4.0.2_bc-3.11
# Load plink and python
module load plink/1.90b3.40
module load java/1.8.0_92

R
source("/lustre/scratch/scratch/zcjtejm/analysis/input.R")
.libPaths(R_libPaths)


##################################################################
# === Read in results  ===========================================
##################################################################


# Function to Merge as rbind
mergeLongFormat=function(list, label, cleanLabel){
  dataframe = mapply(`[<-`, list, 'Label', value = label, SIMPLIFY = FALSE)
  dataframeOut=dplyr::bind_rows(dataframe)
  if (cleanLabel==TRUE) {
    dataframeOut$Label=ifelse(duplicated(dataframeOut$Label)==FALSE, as.character(dataframeOut$Label), " ")
    return(dataframeOut)
  } else {
    return(dataframeOut)
  }
}


# Derive function to relabel, only do this for F1 and loneliness
recodeName=function(data){
  data=revalue(data, c("GenSEMmodel"="F1",
                       "F1"="F1",
                       "DayLONE" = "Loneliness"
                       ))
  return(data)
}

recodeNameBreak=function(data){
  data=revalue(data, c("GenSEMmodel"="F1",
                       "F1"="F1"))
                    
  return(data)
}


# Rename label (add line breaks)
swr = function(string, nwrap) {
  paste(strwrap(string, width=nwrap), collapse="\n")
}
swr = Vectorize(swr)


# Check of order makes sense
orderLabels=function(variable){
  variableOut <- factor(variable,
                        levels = c("GenSEMmodel",
                                   "DayLONE"))
  return(variableOut)
}


# Filter SNPs based on Q-statistic
filterQtest=function(df, name){
  print(paste0("Iteration: for ",name))
  if (name=="GenSEMmodel") {
    print("F1")
    df=subset(df,   Q_chisq_pval >= 5e-8)
  } else {
    print("other phenotypes")
    df=subset(df,   Q_chisq_pval < 5e-8)
  }
  return(df)
}

# Select top SNPs according to p-value
topSNPs=function(data, NtopSNPs, P=P){
  data=data %>% top_n(NtopSNPs, -(as.numeric(P)))
  return(data)
}



# Function to format p-values and number with many decimals
formatNum=function(vecP=NULL, vecNum=NULL, decimal=3, df){

  if(length(vecP)!=0){

    for (i in 1:length(vecP)) {
      print(paste0("Format ",vecP[i]))
      df[[vecP[i]]]=formatC(df[[vecP[i]]], digits=decimal) # Format p-values
    }
  }
  if(length(vecNum)!=0){
    for (i in 1:length(vecNum)) {
      print(paste0("Round ",vecNum[i]))
      df[[vecNum[i]]]=round( df[[vecNum[i]]], decimal)
    }
  }
  return(df)
}


# Order list according to phenotype list
reorderPheno=function(listIn, listOut=list()){
  for(i in 1:length(phenoNames)){
    print(phenoNames[i])
    listOut[[i]] = listIn[[phenoNames[i]]]
  }
  names(listOut)=phenoNames
  return(listOut)
}


filterGenesEQTL=function(df){
  # Remove duplicates (eQTLs are linked to different tissues, but do not need to include here)
  df_out=subset(df,   duplicated(paste0(df$query_term, "_", df$gene))==FALSE)
  return(df_out)
}



##################################################################
# === Read in results =======================================
##################################################################


# +++++++++ Process output  +++++++++
strucmodel="GenSEMmodel_constr_corRes"
GWASsumStats=readRDS(paste0(HOME,"/output/rds/", strucmodel, "_Sumstats.rds"))
GWASsumStats=GWASsumStats[c(1,8)] #selecting only loneliness and F1
str(GWASsumStats)
postGWA=list()
clumpedSNPsList=list()
clumpedSNP_eQTLList=list()
phenoNames=names(GWASsumStats)


# Identify phenotype corresponding to the lowest p-value
# Standardize beta
standardBeta=function(df){
  print("Derive standardized beta")
  zscore = df$BETA / df$SE
  N=df$Neff
  df$BETA_STD = zscore / sqrt(N)  # Use effective sample size
  df$BETA_STD_pos=sqrt((df$BETA_STD)^2) # make all beta estimates positive
  print("Get standard error")
  VAR_STD = 1/N
  df$SE_STD = sqrt(VAR_STD)
  return(df)
}
GWASsumStats=lapply(GWASsumStats, function(x) standardBeta(x))
str(GWASsumStats)


# ================ Process GWAS input
for(i in 1:length(phenoNames)){
  print(paste0("***START PROCESSING:  ", phenoNames[i], "****"))
  sumStats=GWASsumStats[[phenoNames[i]]]

  print("Select GWA significant SNPs")
  clump_input=subset(sumStats, P<5e-8)

  if(NROW(clump_input)==0){
    print("No significant SNPs in GWAS")
    clumpedSNPsSelected=clump_input
    SNPs_sig_clumped=NROW(clumpedSNPsSelected)
  } else {
    write.table(clump_input,
                file= paste0(HOME, "/data/clump/",phenoNames[i], ".pvalsfile"),
                sep="\t",
                row.names = FALSE,
                col.names=T,
                quote=F)

    system(paste0(HOME, "/data/clump/plink --bfile ", HOME, "/data/clump/g1000_eur --clump ", HOME, "/data/clump/",  phenoNames[i], ".pvalsfile --clump-snp-field SNP --clump-field P --out ", HOME, "/data/clump/", phenoNames[i], ".pvalsfile --clump-kb 250 --clump-r2 0.1 --clump-p1 1"))
    print("Remove SNP file")
    clumped=NULL
    clumped=read.table(paste0(HOME, "/data/clump/", phenoNames[i], ".pvalsfile.clumped"), header = TRUE)
    system(paste0("rm ",HOME, "/data/clump/",phenoNames[i], ".pvalsfile"))

    clumpedSNPsSelected=subset(sumStats, SNP %in% unique(  clumped$SNP))
    print(paste0("Numbr of SNPs included after clumping ", NROW(clumped) ) )
    SNPs_sig_clumped=NROW(clumped)
  }

  if((NROW(clumpedSNPsSelected)==0)){
    clumpedSNPsSelectedTEMP <- data.frame(matrix(ncol = length(sumStats), nrow = 1))
    colnames(clumpedSNPsSelectedTEMP) <- colnames(sumStats)
    clumpedSNPsSelected=clumpedSNPsSelectedTEMP

  }
  SNPs_tot=NROW(sumStats)
  SNPs_sig_tot=NROW(subset(sumStats, P<5e-8)) # get total number of significant SNPs (before clumping)
  Ntotal=round(mean(sumStats$N, is.na=T), 0)

  # ==== eQTL Mapping
  print("eQTL mapping")
  #) Qtlizer to map genes to eQTL
  clumpedSNP_eQTL_query= get_qtls(clumpedSNPsSelected$SNP, corr = NA, max_terms = 5, ld_method = "r2",
                                  ref_version = "hg19", return_obj = "dataframe")

  if((length(clumpedSNP_eQTL_query$query_type)>0)) {
    if((clumpedSNP_eQTL_query$query_term[1]=='na')) {
      clumpedSNP_eQTL_query=subset(clumpedSNP_eQTL_query, query_term!='na')
    }
  }

  if((length(clumpedSNP_eQTL_query$query_type)==0)  ){
    print("no significant eQTLs identified")
    namesDF=colnames(get_qtls("rs62325470", corr = NA, max_terms = 5, ld_method = "r2",
                              ref_version = "hg19", return_obj = "dataframe"))
    clumpedSNP_eQTL_query <- data.frame(matrix(ncol = length(namesDF), nrow = 1))
    colnames(clumpedSNP_eQTL_query) <- namesDF
  }
  if((length(clumpedSNP_eQTL_query$query_type)>0)){
    print("significant eQTLs identified")
    # Note: Distance = distnace between index/proxy variant and gene in kilobases
    # 1 Mb (megabase) =  threshold for cis-effects
    # 1 MB = 1000 KB
    clumpedSNP_eQTL_query=subset(clumpedSNP_eQTL_query, distance<=1000)
    clumpedSNP_eQTL_query=subset(clumpedSNP_eQTL_query, sign_info=="FDR<5%" | sign_info=="FWER<5%" ) # selecg cis variants and those significant after FDR correction [eQTL mapping will map SNPs to genes which likely affect expression of those genes up to 1 Mb (cis-eQTL).FUMA: only eQTLs with FDR ??? 0.05 will be used.]
  }

  # Merge clumped with eQTL
  clumpedSNP_eQTL= merge(clumpedSNP_eQTL_query, clumpedSNPsSelected, by.x="query_term",by.y="SNP", all.y=TRUE, suffixes = c("", "y"))

  print("add gene description")
  if( (NROW(na.omit(clumpedSNP_eQTL_query)))==0){ # if no eQTLs, create empty dataframe
    clumpedSNP_eQTL_desc=as.data.frame(matrix(ncol=2, nrow=1))
    colnames(clumpedSNP_eQTL_desc)=c("description", "input")
  } else {
    # Add gene description
    description =gconvert(query = unique(clumpedSNP_eQTL$gene) , organism = "hsapiens",
                          target="ENSG", mthreshold = Inf, filter_na = TRUE)

    clumpedSNP_eQTL_desc=subset(description, select = c(input, description))
  }

  clumpedSNP_eQTL=merge(clumpedSNP_eQTL, clumpedSNP_eQTL_desc, by.x="gene", by.y="input",all.x=TRUE, suffixes = c("", "y"))
  clumpedSNP_eQTL$p_eqtl=clumpedSNP_eQTL$p
  clumpedSNP_eQTL$p=NULL
  # Do not include p-value as this corresponds to expression in specific tissue (results are not included)

  # ===== GProfiler/Phenoscanner: Add description for genes
  print("Gene annotation using gprofiler2") # CHECK TUTORIAL: https://cran.r-project.org/web/packages/gprofiler2/vignettes/gprofiler2.html

  # Phenoscanner
  print("Run phenoscanner")
  phenoQuery=clumpedSNPsSelected$SNP

  if( is.na(phenoQuery)==TRUE){
    print("Skip phenoscanner (no significant hits)")
    phenoQuery="rs62325470"
    pheno <- phenoscanner(snpquery=phenoQuery, build=37, catalogue=c("GWAS"))$snps
    phenoComplete=as.data.frame(matrix(ncol=length(colnames(pheno)), nrow=1))
    colnames(phenoComplete)=colnames(pheno)
    pheno=phenoComplete
    geneEnsembl=data.frame(target=NA, name=NA, description=NA)

  } else {
    pheno <- phenoscanner(snpquery=phenoQuery, build=37, catalogue=c("GWAS"))$snps

    pheno$hgnc=revalue(pheno$hgnc, c("-" = NA) )
    print("Add Ensembl ID and description")
    phenoComplete <- data.frame(hgnc=na.omit(pheno$hgnc)) # remove gene rows with missing values
    # Add description
    geneEnsembl=gconvert(query = phenoComplete$hgnc, organism = "hsapiens",
                         target="ENSG", mthreshold = Inf,
                         filter_na = TRUE)[c("target", "name", "description")]  %>% distinct(name, .keep_all = TRUE)
  }

  # Merge pheno and gprofiler results
  geneEnsemblPheno=merge(pheno, geneEnsembl, by.x = "hgnc", by.y = "name", all.x = T, suffixes = c("", ".y"))

  # Add to first dataframe
  clumpedSNPs=merge(clumpedSNPsSelected, geneEnsemblPheno, by.x = "SNP", by.y = "snp", all.x = TRUE, suffixes = c("", "y"))
  clumpedSNPs$P_logp = -log10(clumpedSNPs$P)
  print(paste0("Number of included SNPs after clumping: ", NROW(na.omit(clumpedSNPs)) ))


  print("Add info for Qsnp statistics")
  clumpedSNPs$chi_dich=ifelse(as.numeric(clumpedSNPs$Q_chisq_pval) < 5e-8, "Q_sig", "Q_ns" )
  clumpedSNPs$SNPs_tot=SNPs_tot
  clumpedSNPs$SNPs_sig_tot=SNPs_sig_tot
  clumpedSNPs$SNPs_sig_clumped=SNPs_sig_clumped
  clumpedSNPs$N=Ntotal

  clumpedSNP_eQTL$chi_dich=ifelse(as.numeric(clumpedSNP_eQTL$Q_chisq_pval) < 5e-8, "Q_sig", "Q_ns" )
  clumpedSNP_eQTL$SNPs_tot=SNPs_tot
  clumpedSNP_eQTL$SNPs_sig_tot=SNPs_sig_tot
  clumpedSNP_eQTL$SNPs_sig_clumped=SNPs_sig_clumped
  clumpedSNP_eQTL$N=Ntotal

  # Combine all datasets (not filtered)
  listOut=list(sumStats, clumpedSNPs, clumpedSNP_eQTL)
  names(listOut)=c("sumStats", "clumpedSNPs", 'clumpedSNP_eQTL')

  # Save loop estimates in list
  postGWA[[i]]=listOut

}
names(postGWA)=phenoNames

# Extract sumstats file
sumStatsList=lapply(postGWA, `[[`, "sumStats")
names(sumStatsList)=phenoNames
head(sumStatsList)

##################################################################
# === Quick summary table of GWA results =========================
##################################################################

# Function to select only unique SNPs
processSNPs=function(df){
  # Remove SNPs that exist multiple times (eg when linking to different genes)
  df$ID_GENE=paste0(df$SNP, " (", df$hgnc, ")")
  df_out=subset(df, duplicated(ID_GENE)==FALSE, select = c("SNP" ,"A1","A2" ,"BETA", "SE", "BETA_STD_pos", "BETA_STD", "SE_STD","P_logp", "P", "Q_chisq_pval", "chi_dich","hgnc","target" ,"ID_GENE", "consequence", "pos_hg19", "description","SNPs_tot" ,"SNPs_sig_tot", "SNPs_sig_clumped", "N") )
  print(paste0("Number SNPs included following gene annotation: ",   length(df_out$SNP)))
  print(paste0("Number of clumped SNPs: ", df$SNPs_sig_clumped[1]))
  return(df_out)
}

# FUNCTION: Get number of significant hits (shared vs non-shared)
numberShared=function(df){
  df$shared_snps=NROW(subset(df, chi_dich=="Q_ns"))
  df$non_shared_snps=NROW(subset(df, chi_dich=="Q_sig"))
  df$minP=formatC(min(df$P, na.rm = TRUE), digits=2)
  df$GWAS=NA
  df_out= subset( df[1,], select=c(GWAS,
                                   N,
                                   SNPs_tot,
                                   SNPs_sig_clumped,
                                   minP,
                                   shared_snps,
                                   non_shared_snps))
  return(df_out)
}

# Get results for clumped data
postGWA_clump=lapply(postGWA, `[[`, "clumpedSNPs") # Select only results from clumping
postGWA_clump=lapply(postGWA_clump, function(x) processSNPs(x))
GWA_shortSumList=lapply(postGWA_clump, function(x) numberShared(x)) # Check number of shared vs non-shared SNPs
GWA_shortSum=do.call(rbind, reorderPheno(GWA_shortSumList))
GWA_shortSum$GWAS=recodeName(names(postGWA_clump))
GWA_shortSum$minP=ifelse(GWA_shortSum$minP=="Inf", NA, GWA_shortSum$minP)
colnames(GWA_shortSum)=c("GWAS", "N (sample)", "included SNPs", "number of LD-independent genome-wide SNPs", "smallest p-value", "SNPs (shared)", "SNPs (non-shared)")
head(GWA_shortSum)

##################################################################
# === PhenoScanner ===============================================
##################################################################

runPheno=function(data, listDF=list(), nTopSNPsPheno){
  SNPs=levels(as.factor(data$SNP))

  if((length(SNPs)==0)){
    print("No significant hits - skip phenoscanner")
    phenoName=c("SNP", "BETA", "P", "ID_GENE", "trait", "P_pheno")
    pheno_out <- data.frame(matrix(ncol = length(phenoName), nrow = 1))
    colnames(pheno_out) <- phenoName
  }

  if((length(SNPs)>0)){
    print("Run phenoscanner")
    for (i in 1:length(SNPs)) {
      print(paste0("Read in ", SNPs[i]))
      data_sub <-  subset(data, SNP==SNPs[i] )
      pheno=phenoscanner(data_sub$SNP, build=37, catalogue=c("GWAS"))$results
      # If no phenoscanner results
      if((length(pheno)==0)){
        phenoName=c("rsID", "trait", "P_pheno")
        pheno <- data.frame(matrix(ncol = length(phenoName), nrow = 1))
        colnames(pheno) <- phenoName
        pheno$rsID=data_sub$rsID
      } else {
        # Select only trait column
        pheno=subset(pheno, select = c(snp, trait, p))
        # Select according to highest p value estimate
        pheno=pheno %>% top_n(nTopSNPsPheno, -(as.numeric(p)))
        colnames(pheno)=c("rsID", "trait", "P_pheno")
      }
      pheno$snp
      listDF[[i]]=merge(data_sub, pheno, by.x="SNP", by.y="rsID", all.x = TRUE)
    }

    # Combine list
    pheno_out=do.call("rbind", listDF)
    pheno_out=subset(pheno_out, select = c("SNP", "BETA", "P", "ID_GENE", "trait", "P_pheno"))
  }

  return(pheno_out)
}

# Select eqtl data
postGWA_eQTL=lapply(postGWA, `[[`, "clumpedSNP_eQTL") # Select results from clumping
names(postGWA_eQTL)=phenoNames
postGWA_eQTL=lapply(postGWA_eQTL, function(x) filterGenesEQTL(x)) # filter out only genes (ignore tissues)

# Filter SNPs (QNSP)
postGWA_clump_Qfilter=imap(postGWA_clump, function(x, y) filterQtest(x,y))
postGWA_eQTL_Qfilter=imap(postGWA_eQTL, function(x, y) filterQtest(x,y))

# Select only top SNPs
topNGWA=20
postGWA_clump_Qfilter_topSNP=lapply(postGWA_clump_Qfilter, function(x) topSNPs(x, NtopSNPs=topNGWA))
# Run phenoscanner on top SNPs
nTopSNPsPheno=5
postGWA_clumpTopPheno=lapply(postGWA_clump_Qfilter_topSNP, function(x) runPheno(x, nTopSNPsPheno=nTopSNPsPheno))
names(postGWA_clumpTopPheno)=phenoNames
postGWA_clumpPhenoDF=mergeLongFormat(postGWA_clumpTopPheno, label=recodeName(phenoNames), cleanLabel = TRUE)

##################################################################
# === Manhattan plot =============================================
##################################################################

# Function to prepare data for manhattan plot
dataManHplot=function(nameGWA){

  plotDF=data.frame(
    SNP=postGWA[[nameGWA]]$sumStats$SNP,
    Chromosome = postGWA[[nameGWA]]$sumStats$CHR,
    Position = postGWA[[nameGWA]]$sumStats$BP,
    outName = postGWA[[nameGWA]]$sumStats$P)

  colnames(plotDF)[4] = recodeName(nameGWA)

  manHplotInput=postGWA_clump[[nameGWA]]
  # Add row break in resID/gene name variable
  SNPsComFacText=as.character(paste0(manHplotInput$SNP, "\n(" ,manHplotInput$hgnc, ")"))
  # Derive colour scheme for mediated vs non-mediated SNPs
  SNPsComFac=postGWA_clump[[nameGWA]]$SNP
  SNPsComFacCol=SNPsComFac
  SNPsComFacCol[manHplotInput$Q_chisq_pval < 5e-8] = "red4"
  SNPsComFacCol[manHplotInput$Q_chisq_pval >= 5e-8 ] = "navy"
  # Save in list
  listGWA_manhattanOut=list(plotDF=plotDF, SNPs=SNPsComFac, SNPsText=SNPsComFacText, SNPsCol=as.character(SNPsComFacCol))
  return(listGWA_manhattanOut)
}

# Function to plot manhattan plot
ManHplot=function(list, width, height, type, ylimit=NULL){
  plotOut=CMplot(list[["plotDF"]],
                 type="p",
                 plot.type=type,
                 LOG10=TRUE,
                 file="jpg",
                 dpi=300,
                 main="",
                 cex=0.5, # size of the points (all)
                 amplify=TRUE,
                 signal.cex=0.5, # size of the points (significant)
                 threshold=c(5e-8),
                 threshold.col=c("black","grey"),
                 highlight=unlist(list[["SNPs"]]),
                 highlight.text=unlist(list[["SNPsText"]]),
                 highlight.text.cex=0.7,
                 highlight.text.col=unlist(list[["SNPsCol"]]),
                 highlight.col= "black",
                 col=c("grey87","grey60"),
                 ylab=expression(-log[10](italic(p))),
                 highlight.text.font=3,
                 file.output=FALSE,
                 width=width,
                 ylim=ylimit,
                 height=height)
  return(plotOut)
}

height=18
width=37
# Set parameters
ManHplot_width=37
ManHplot_height=18

# Margins
top=2
left=6
right=2
bottom=4

#max(-log10(postGWA[["commonLiability"]]$sumStats$P))

# y lim for main manuscript
ylimit=NULL
i=1
# y lim for supplement
ylimit=c(0,100)

# manhattan plot
for(i in 1:length(phenoNames)){
  # Prepare data
  dataManHplot_com=dataManHplot(phenoNames[i])
  # plot output
  jpeg(file=paste0(HOME,"/results/figures/ManHplot_",phenoNames[i], ".jpeg"),  width=ManHplot_width,height=ManHplot_height, units = "cm", res=1000)
  par(mar = c(bottom, left, top, right))
  dataManHplot_comOut=ManHplot(dataManHplot_com, width=ManHplot_width, height=ManHplot_height, type="m", ylimit=ylimit)
  dev.off()
}

# QQplot
QQplot_width=40
QQplot_height=30
for(i in 1:length(phenoNames)){
  dataQQplot_com=dataManHplot(phenoNames[i])
  jpeg(file=paste0(HOME,"/results/figures/QQplot_",phenoNames[i], ".jpeg"),  width=QQplot_width,height=QQplot_height, units = "cm", res=1000)
  par(mar = c(6, 6, 6, 6))
  QQplot_comOut=ManHplot(dataQQplot_com, width=QQplot_width, height=QQplot_height, type="q", ylimit= c(0,20))
  dev.off()
}

##################################################################
# === Shared and non-shared genetic variants =====================
##################################################################

# Arrange according to standardized beta
bindTogether_clump=lapply(postGWA_clump, function(x) arrange(x, -BETA_STD_pos))
str(bindTogether_clump)

# Bind as dataframe
postGWA_clumpDF=do.call(rbind, bindTogether_clump)

# Match relvant SNPs to estimates from GWAS output
sumStatsRaw=lapply(postGWA, `[[`, "sumStats") # Select raw sumstats files
names(sumStatsRaw)=phenoNames
postGWA_clumpGenes=list()


for(i in 1:length(phenoNames)){
  print(paste0("Start processing of ", phenoNames[[i]]))

  print("Select original files")
  df1=sumStatsRaw[[phenoNames[[i]]]]
  df1$chi_dich[df1$Q_chisq_pval < 5e-8] = "Q_sig"
  df1$chi_dich[df1$Q_chisq_pval >= 5e-8] = "Q_ns"
  df1$P_logp = -log10(df1$P)
  print("Select mapped genes")
  postGWA_clumpDF=subset(postGWA_clumpDF, is.na(SNP)!=T & is.na(hgnc)!=T )
  postGWA_clumpDF$ID_GENE=paste0(postGWA_clumpDF$SNP, " (", postGWA_clumpDF$hgnc, ")")
  postGWA_clumpDF_clean=subset(postGWA_clumpDF, duplicated(ID_GENE)==FALSE)

  print("Merge with original files")
  df1_selected = subset(df1, SNP %in% unique(postGWA_clumpDF$SNP), select=c("SNP","BETA","Q_chisq_pval", "chi_dich", "P_logp", "P", "BETA_STD", "BETA_STD_pos", "SE_STD") )
  df1_selected=merge(df1_selected, postGWA_clumpDF_clean, by="SNP", all.y = T, suffixes = c("", ".y"))
  df1_selected=subset(df1_selected, select= c(SNP, BETA, Q_chisq_pval,chi_dich,  P_logp, P,ID_GENE, hgnc, BETA_STD, BETA_STD_pos, SE_STD))

  # Extract lead SNPs and label in dataframe
  df2_clump=postGWA_clump[[phenoNames[[i]]]]
  df1_selected$leadSNP= ifelse(df1_selected$SNP %in% df2_clump$SNP , "*", "")
  postGWA_clumpGenes[[i]]=df1_selected
}


# Combine in one dataframe
bindTogether = mapply(`[<-`, postGWA_clumpGenes, 'Label', value = names(postGWA_clump), SIMPLIFY = FALSE)
postGWA_clump_genesDF=do.call(rbind, bindTogether)

# Order according to phenotype
postGWA_clump_genesDF=postGWA_clump_genesDF[order(match(postGWA_clump_genesDF$ID_GENE, postGWA_clumpDF$ID_GENE)), ]
postGWA_clump_genesDF$order=seq(1:length(postGWA_clump_genesDF$SNP))

# Add row breaks
postGWA_clump_genesDF$Label_clean=as.factor(recodeName(orderLabels(as.factor(postGWA_clump_genesDF$Label))))

# Get confidence interval
postGWA_clump_genesDF$beta_upper_CI=postGWA_clump_genesDF$BETA_STD_pos + 1.96 * postGWA_clump_genesDF$SE_STD
postGWA_clump_genesDF$beta_lower_CI=postGWA_clump_genesDF$BETA_STD_pos - 1.96 * postGWA_clump_genesDF$SE_STD


# FUNCTION FOR PLOT
comparativePlot=function(df, colGroup){
  plot=ggplot(df, aes(x = reorder(ID_GENE, -order), y = BETA_STD_pos,  group = colGroup, fill =colGroup )) +
    geom_bar(stat = "identity") + coord_flip() +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
          axis.text.y = element_text(size=6),
          legend.position="none",
          plot.caption = element_text(hjust = 0))  +
    geom_text(mapping = aes(x=reorder(ID_GENE, -order), y=BETA_STD_pos, label = leadSNP),  size = 3, colour = "black") +
    facet_wrap(~ as.factor(Label_clean),   ncol = length(levels(as.factor(df$Label_clean))), nrow = NULL) +
    geom_linerange(aes(x = ID_GENE, ymin = beta_lower_CI, ymax = beta_upper_CI),
                   lwd = 0.1, position = position_dodge(width = 1/2), colour = "black") +
    scale_y_continuous(limits=c(round(min(postGWA_clump_genesDF$beta_lower_CI),2)-0.01, round(max(postGWA_clump_genesDF$beta_upper_CI),2),
                                breaks=c(0, 0.04, round(max(postGWA_clump_genesDF$beta_upper_CI),2) ), n.breaks = 3 )) +
    labs(y=expression((italic(beta)[std])), x="SNP (annotated gene)")
  return(plot)
}


# Add row breaks
postGWA_clump_genesDF$labelOrdered=orderLabels(postGWA_clump_genesDF$Label)
postGWA_clump_genesDF$Label_clean=as.factor(recodeNameBreak(orderLabels(as.factor(postGWA_clump_genesDF$labelOrdered))))

library(ggplot2)
postGWA_clump_genesDF$chi_dich[postGWA_clump_genesDF$P >= 5e-8 ] = "ns"

#colourScheme=c("aquamarine4","tomato" ,"tomato", "red4","navy", "darkgreen", "grey")
colourScheme=c( "grey","navy", "red4")
clumpedMediatedPlottopPheno = comparativePlot(postGWA_clump_genesDF, colGroup=postGWA_clump_genesDF$chi_dich) +
  scale_fill_manual(name="", values = colourScheme)

print(clumpedMediatedPlottopPheno)


# Export
clumpedMediatedPlot_width=27
clumpedMediatedPlot_height=40
ggsave(paste0(HOME,"/results/figures/clumpedMediatedPlot.pdf"), clumpedMediatedPlottopPheno,  width = clumpedMediatedPlot_width, height = clumpedMediatedPlot_height, units = "cm", limitsize = TRUE)


# combine positional with eQTL
postGWA_pos_eqtl=list()
for(i in 1:length(phenoNames)){
  print(paste0("Merge positional and eQTL mapping for ", phenoNames[i]))
  df_clump=subset(postGWA_clump[[phenoNames[i]]], select=c(SNP, hgnc, target, description, consequence))
  colnames(df_clump)=c("SNP","gene_pos", "ens_pos", "desc_pos", "consequence_pos")
  df_eqtl=subset(postGWA_eQTL[[phenoNames[i]]], select=c(query_term, gene, distance , ensgid, description, P, Q_chisq_pval, chi_dich))
  colnames(df_eqtl)=c("SNP", "gene_eqtl", "distance","ens_eqtl", "desc_eqtl", "P_GWAS", "Q_chisq_pval", "chi_dich")
  postGWA_pos_eqtl[[i]]=merge(df_clump, df_eqtl, by="SNP", all = T)
}
str(postGWA_pos_eqtl)
names(postGWA_pos_eqtl)=phenoNames



################################################################
# ====================== Create output tables ==================
################################################################

ColStart=2
RowHeader=2
RowSubheaderStart=3
RowSubheaderEnds=6
RowTable=7

# Create info text
createInfo=function(dataInfoPath){
  datOut=read.csv(dataInfoPath,header=T)
  datOut$X=NULL
  datOut_merged=paste0(datOut[,1],": " ,datOut[,2])
  return(datOut_merged)
}

# define style
hs1 <- createStyle(halign = "CENTER", textDecoration = "Bold",
                   border = "Bottom", fontColour = "black", fgFill = "white")

h_info <- createStyle(halign = "left", textDecoration = "Bold",
                      border = "Bottom", fontColour = "black", fgFill = "white")

addTable=function(sheet, table){
  writeDataTable(wb, sheet, table, headerStyle=hs1, tableStyle = "TableStyleLight1",
                 startRow = RowTable, startCol = ColStart)
  setColWidths(wb, sheet, cols=2:10, widths = 15)
}

# HEADER
headerFunc=function(TITLE, sheet){
  writeData(wb, sheet = sheet, TITLE,
            colNames = FALSE, rowNames = FALSE,
            startCol = ColStart, startRow = RowHeader)
}
# INFO ROW
InfoFunc=function(TITLE, sheet){
  writeData(wb, sheet = sheet, TITLE,
            colNames = FALSE, rowNames = FALSE,
            startCol = ColStart, startRow = RowSubheaderStart)
}

# Create new workbook
setwd(paste0(HOME,"/results/tables/"))
wb <- openxlsx::createWorkbook()
# ================================ TABLE 5 ================================ #
GWA_shortSum$GWAS=recodeName(phenoNames)
# Create new sheet
GWA_short="sTable 5"
addWorksheet(wb, GWA_short)
GWA_short_info=paste0("SNP = single nucleotide polymorphism. The effective sample size of the F1 Neurodevelopmental and Mood  genome-wide association study (GWAS) was calculated using the formula described in the sMethods (Supplement). SNPs (shared) represent SNPs that operate via F1 (i.e., with Qsnp p>5×10???8) versus SNPs (non-shared) that show heterogeneous effects across the individual  phenotyes (i.e., Qsnp p<5×10???8)")
# Add parameters
title_name="sTable 5. Overview of the results from the multi- and univariate genome-wide association analyses"
sheet=GWA_short
table=GWA_shortSum
Info_text=GWA_short_info
# Run functions
addTable(sheet, table)
headerFunc(title_name, sheet)
InfoFunc(Info_text, sheet)

# Store as list
listT5=list(data=as.data.frame(GWA_shortSum),
            description=GWA_short_info,
            title=title_name)

# ================================ TABLE 6 ================================ #
# Format as Table
postGWA_clumpOrdered=lapply(postGWA_clump, function(x) arrange(x, P)) # Arrange according to p-value
clumpResTable=mergeLongFormat(postGWA_clumpOrdered, recodeName(phenoNames), cleanLabel = TRUE)

# Format decimals
clumpResTable=formatNum(vecP=c("Q_chisq_pval"," P"), vecNum=c("BETA", "SE", "P_logp"), df=clumpResTable)
clumpResTable=subset(clumpResTable, select=c(Label, ID_GENE, A1, A2, BETA, SE, P, Q_chisq_pval, chi_dich, consequence, description))
colnames(clumpResTable)=c("GWA data","SNP (annotated gene)", "A1", "A2", "BETA", "SE", "P (GWA)", "P (chi-square)", "P (chi-square, dichotomized)","consequence", "description")

# Create new sheet
GWA_clump="sTable 6"
addWorksheet(wb, GWA_clump)
GWA_clump_info="Shown are only lead single nucleotide polymorphisms (SNPs), defined as LD-independent genome-wide significant variants. The columns 'P (chi-square, dichotomized)' indicates whether the genetic variant is likely to operate via the common liability (Q_ns = Qsnp p>5×10???8) or shows heterogeneous effects across the individual phenotyes (Q_sig = Qsnp p<5×10???8)"
# Add parameters
title_name="sTable 6. Summary of lead genetic variants associated with the F1 Factor"
sheet=GWA_clump
table=clumpResTable
Info_text=GWA_clump_info
# Run functions
addTable(sheet, table)
headerFunc(title_name, sheet)
InfoFunc(Info_text, sheet)

# Store as list
listT6=list(data=as.data.frame(clumpResTable),
            description=GWA_clump_info,
            title=title_name)

# ================================ TABLE 7 ================================ #
postGWA_clump_genesDF$Label=recodeName(postGWA_clump_genesDF$Label)
postGWA_clump_genes_select=subset(postGWA_clump_genesDF, select = c(SNP, BETA, P, Q_chisq_pval, ID_GENE, Label))

# Create new sheet
GWA_clump_long="sTable 7"
addWorksheet(wb, GWA_clump_long)
GWA_clump_long_info="Table of the results"
# Add parameters
title_name="sTable 7. Associations of genetic variants with the F1 factor and the individual phenotypes"
sheet=GWA_clump_long
table=postGWA_clump_genes_select
Info_text=GWA_clump_long_info
# Run functions
addTable(sheet, table)
headerFunc(title_name, sheet)
InfoFunc(Info_text, sheet)

# Store as list
listT7=list(data=as.data.frame(postGWA_clump_genes_select),
            description=GWA_clump_long_info,
            title=title_name)


################################################################
# ====================== Export table ==================
################################################################

listAll=list(listT5, listT6, listT7)
saveRDS(listAll, paste0(HOME,"/results/tables/TableSum.rds"))


# Create new styles
s <- createStyle(fgFill = "#FFFFFF")
h_info <- createStyle(halign = "left",
                      border = "BOTTOM", fontColour = "black", fgFill = "white", fontSize=16, textDecoration = "Bold", numFmt="TEXT", borderColour = "black")
info_info <- createStyle(halign = "left",
                         border = NULL, fontColour = "black", fgFill = "white", fontSize=14, textDecoration = NULL, numFmt="TEXT", wrapText=TRUE)
# Run loop
for(curr_sheet in names(wb)){
  addStyle(wb,sheet = curr_sheet, s, cols=1:40, rows=1:2000, gridExpand = TRUE)
  setColWidths(wb, sheet = curr_sheet, cols=1:40, widths = 20)
  addStyle(wb,sheet = curr_sheet, h_info, cols=ColStart:20, rows=RowHeader, gridExpand = TRUE)
  addStyle(wb,sheet = curr_sheet, info_info, cols=ColStart:5, rows=RowSubheaderStart, gridExpand = TRUE)
  mergeCells(wb,sheet = curr_sheet, cols = 2:8, rows = RowSubheaderStart:RowSubheaderEnds)
}

library( openxlsx)
openxlsx::saveWorkbook(wb, paste0(HOME,"/results/tables/F1GenomicSEM_Tables.xlsx"), overwrite = TRUE)
# Open File
openXL(wb)
