
#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
print(args[1])
HOME=args[1]
print(HOME)

modelName=args[2]
print(modelName)

source(paste0(HOME, "/analysis/input.R"))

## ======== PREPARE GenomicSEM output files ========
# Set working directory
setwd(paste0(HOME,"/output/csv"))


# Read in csv files (common liability GWA)
readIn=function(df){
  print(paste0("read in ", df))
  dfIn=fread(paste0(HOME,"/output/csv/", df))
  print("number of rows")
  print(NROW(dfIn))
  print("number of duplicates")
  print(table(duplicated(dfIn$SNP)))
  return(dfIn)
}

print(" Read in GWA on common factor")
GWASoutCommon <- dir(recursive=TRUE, full.names=FALSE, pattern=paste0("*_",modelName, ".csv"))
print(GWASoutCommon)
GWASoutCommonList=lapply(GWASoutCommon, function(x) readIn(x)) # for common factor
GWASoutCommonDF=rbindlist(GWASoutCommonList)

print("Read in GWA results for heterogeneity test")
GWASoutHT <- dir(recursive=TRUE, full.names=FALSE, pattern=paste0("*_",modelName, "_HT.csv"))
GWASoutHTList=lapply(GWASoutHT, function(x) readIn(x)) # for common factor
GWASoutHTDF=rbindlist(GWASoutHTList)
NROW(GWASoutCommonDF)-NROW(GWASoutHTDF) # check if 0
GWASoutHTDFsel=subset(GWASoutHTDF, select=c(SNP, chisq, chisq_df))

print("Merge both GWA results")
GWASout=merge(GWASoutCommonDF, GWASoutHTDFsel, by="SNP", all.x=T, suffixes=c("", "_HT"))
head(GWASout)

print("Convert to numeric")
GWASout$est=as.numeric(GWASout$est)
GWASout$SE=as.numeric(GWASout$SE)
GWASout$Pval_Estimate=as.numeric(GWASout$Pval_Estimate)

print("Check for errors and warnings")
table(GWASout$error)
table(GWASout$warning)
table(duplicated(GWASout$SNP))
table(is.na(GWASout$est))

## ++++++++++++++++ Add columns containing results from heterogeneity test ++++++++++++++++

# ==== Get q-statsitic estimates
# Step 1: Estimate the model and be sure to request model chi-square.
# Step 2: Estimate a follow-up model in which the SNP effect operates entirely through independent pathways, and no common pathways, but the same factor structure is specified from Step 1.
# - That is, the SNP should predict only the genetic indicators, and not the common factors. Be sure to also request model chi-square for this model.
# Step 3: Subtract the model chi-square from the Step 2 model from the model chi-square from the Step 1 model.
# - This is a chi-square distributed test statistic with degrees of freedom equal to: df(Step 1 Model) - df(Step 2 Model).

print("Step 1: Calculate the chi-square difference for each SNP")
GWASout$Q_chisq = GWASout$chisq - GWASout$chisq_HT
print("Step 2 Calculate the df associated with this chi-square diff statistic")
GWASout$Q_chisq_df <-GWASout$chisq_df[1] - GWASout$chisq_df_HT[1]
print("Step 3: Calculate the p-value associated with the Q-statistic, using the relevant degrees of freedom")
GWASout$Q_chisq_pval<-pchisq(GWASout$Q_chisq, GWASout$Q_chisq_df,lower.tail=FALSE)
summary(GWASout$Q_chisq) # check if all Qsnp estimated could be computed (0 NAs)

print("Extract the columns for the common liability")
GenSEMmodel = GWASout[,c("CHR","BP","SNP", "A1", "A2", "est", "SE", "Pval_Estimate", "Q_chisq", "Q_chisq_df", "Q_chisq_pval", "MAF")]
listUserGWAIn=list(GenSEMmodel)


print("Add effective N (sensitivity analysis)")
addEffectiveN=function(df){
  print("Estimate effective N")
  dfOutAll=df
  dfOut<-subset(df, df$MAF <= .4 & df$MAF >= .1)
  dfOut$Z_Estimate=dfOut$est/dfOut$SE
  Effective_N_MAF <-(mean(((dfOut$Z_Estimate/dfOut$est)^2)/(2*dfOut$MAF*(1-dfOut$MAF)), na.rm=TRUE ) )
  print(Effective_N_MAF)
  dfOutAll$N=  round(Effective_N_MAF,0)
  dfOutAll$Neff=  round(Effective_N_MAF,0)
  
  return(dfOutAll)
}
listUserGWA=lapply(listUserGWAIn, function(x) addEffectiveN(x))
names(listUserGWA) <- c("GenSEMmodel")
str(listUserGWA)


listUserGWA=lapply(listUserGWA, "colnames<-", c("CHR","BP","SNP", "A1", "A2", "BETA", "SE", "P", "Q_chisq", "Q_chisq_df", "Q_chisq_pval", "MAF", "N", "Neff") )
head(listUserGWA)
names(listUserGWA)

print("Save R object (common liability GWA")
saveRDS(listUserGWA, paste0(HOME,"/output/rds/",modelName, "_GenSEMmodelSumstats.rds"))


## ========== IMPORT ORIGINAL SUMSTATS FILES ==========
print("Import original GWA data")
gwasSumStast=read.xlsx(paste0(HOME,"/analysis/GenSEM_GWAS_EM.xlsx"), na.strings="NA")

# Read in data
GWA_original_all=lapply(paste0(HOME,"/data/processed/", gwasSumStast$label, "_clean"), fread)
names(GWA_original_all) <- gwasSumStast$label

print("Check of all GWA have identical colnames")
lapply(GWA_original_all, function(x) colnames(x) )
print("check if there are duplicates")
lapply(GWA_original_all, function(x) table(duplicated(x$SNP) ) )

print("Match SNPs from original GWA to commob liability SNPs")
MergedGWA=list()

for ( i in 1:length(GWA_original_all) ) {
  a=subset(listUserGWA[["GenSEMmodel"]], select=c("CHR","BP","SNP", "Q_chisq", "Q_chisq_df", "Q_chisq_pval","MAF")) # Select SNP and SNP info from one GenSEM GWA file for merging
  print(paste0("Processing of ", names(GWA_original_all)[i], " GWAS" ))
  b=GWA_original_all[[i]]
  b$Neff=b$N
  
  if(is.na(gwasSumStast$sample.prev[i])==FALSE){
    print("Binary outcome: get effective sample size")
    NCases=gwasSumStast$sample.prev[i]*b$N
    NControls=b$N-NCases
    b$Neff=2/(1/NCases + 1/NControls)
  }
  # create new list
  list_ab <- list(a, b)
  # Merge lists
  MergedGWA[[i]] <- Reduce(function(x,y) merge(x,y, by="SNP", all.x=TRUE), list_ab)
}

MergedGWA_clean=lapply(MergedGWA, subset, select=c("SNP", "A1", "A2", "BETA", "SE", "P", "Q_chisq", "Q_chisq_df", "Q_chisq_pval", "N", "Neff")) # Reorder so the order of the columns is the same as in GenSEM output
names(MergedGWA_clean)=names(GWA_original_all)

print("Merge common liability and original GWA lists")
userGWA_Original_merged=append(listUserGWA, MergedGWA_clean)
userGWA_Original_names=names(userGWA_Original_merged)
str(userGWA_Original_merged)
names(userGWA_Original_merged)=userGWA_Original_names

print("Check if p-values are in decimal format")
# (e.g. if p-value is rounded to p=0.000, the format has to be changed)
#       - Check what the minimum p=value is
#       - If p-values are not reported with decimal numbers, use beta/SE estimates (for continuous) to derive z-score and convert to p-values. Estimation is different if effect size is OR
phenotype_name_all=names(userGWA_Original_merged)
pvalCheck=matrix(ncol=2, nrow=length(phenotype_name_all))
colnames(pvalCheck)=c("Sumstats", "Pvalue_min")
for ( i in 1:length(phenotype_name_all) ) {
  check=userGWA_Original_merged[[i]]
  pvalCheck[i,1]=phenotype_name_all[i]
  pvalCheck[i,2]=as.numeric(min(check$P, na.rm = TRUE))
  print(pvalCheck)
}
# Interpretation: No problematic cases
paste0("Save R object as: ",HOME, "/output/rds/", modelName, "_Sumstats.rds")
saveRDS(userGWA_Original_merged, paste0(HOME, "/output/rds/", modelName, "_Sumstats.rds"))
