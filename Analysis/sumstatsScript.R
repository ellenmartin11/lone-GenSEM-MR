#!/usr/bin/env Rscript

arge = commandArgs(trailingOnly=TRUE)
print(arges[1])
HOME = args[1]
print(HOME)

source(paste0(HOME, "/analysis/input.R"))

setwd(gwasDir)
#computing sumstats for the 11 traits and storing them on the cluster 

GenSEM_sumstats <- sumstats(files=c("DemontisADHD_clean","SchumannALC_clean","OtowaANX_clean","GroveASD_clean","StahlBIP_clean","JohnsonCAN_clean","HowardMDD_clean","NievergeltPTSD_clean","PardinasSCZ_clean","WoottonSMK_clean","DayLONE_clean"),
                            ref= "reference.1000G.maf.0.005.txt.gz",
                            trait.names=c("ADHD","ALC","ANX","ASD","BIP","CAN","MDD","PTSD","SCZ","SMK","LONELINESS"),
                            se.logit=c(T,T,T,T,T,T,T,T,T,T,T),
                            info.filter=.6,
                            maf.filter=0.01)

save(GenSEM_sumstats, paste0(HOME, "/data/processed/GenSEM_sumstats.RData"))

# ===== Save datasets with subsets of SNPs to reduce processing demands
# Split in subsets of SNPs
baseModel="GenSEMmodel"

n_chunks=500000
n_rows <- nrow(GenSEM_sumstats)
r  <- rep(1:ceiling(n_rows/n_chunks),each=n_chunks)[1:n_rows]
GenSEM_sumstats_list <- split(GenSEM_sumstats,r)
n_splits=seq(1:length(GenSEM_sumstats_list)) # Number of subsets:75
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


     

