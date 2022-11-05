##install packages
#install.packages("remotes")
#remotes::install_github("MRCIEU/TwoSampleMR")
library(TwoSampleMR)
library(ieugwasr)
library(data.table)

##processing outcome data
outcome_F1 <- read_outcome_data(
  snps = NULL,                            # Keep 'snps=NULL' so that all SNPs are uploaded
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\F1_GWAS",    # This is the filename of the summary statistics file for your outcome
  sep = " ",                           # Specify whether the file is a tab delimited file ("\t") or a space delimited file ("")
  snp_col = "SNP",# Insert the name of column that includes the SNP ID's
  chr_col = "CHR",
  pos_col = "BP",
  beta_col = "BETA",                      # Insert the name of column with effect sizes
  se_col = "SE",                          # Insert the name of column with standard errors
  effect_allele_col = "A1",    # Insert the name of column with the effect allele
  other_allele_col = "A2",      # Insert the name of column with the non-effect allele
  pval_col = "P", # Insert the name of column with p-value
  eaf_col="MAF",
  samplesize_col = "N")    # Insert the name of column with effect allele frequency
# Note: A few columns are not present in the sum stat file so cannot be read directly but can be added
outcome_F1$outcome <- "F1" # Provide a name for the outcome
# Add the number of participants included as cases (i.e. the number of participants with the disease)    # Derive the total sample size, this should be N=184305
# Inspect your uploaded file:
head(outcome_F1)
length(outcome_F1$SNP) 
# Number of SNPs included  = 1968630

#processing exposure data

exposure_loneliness <- read_exposure_data(
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\LONE", # This is the filename of the summary statistics file for your exposure
  sep = "\t",# Specify whether the file is a tab delimited file ("\t") or a space delimited file ("")
  snp_col = "SNP",           # Insert the name of column that includes the SNP ID's
  beta_col = "BETA",         # Insert the name of column with effect sizes
  chr_col = "CHR",
  pos_col = "BP",
  se_col = "SE",        # Insert the ame of column with standard errors
  effect_allele_col = "A1",  # Insert the name of column with the effect allele
  other_allele_col = "A2",   # Insert the name of column with the non-effect allele
  pval_col = "P",  # Insert the name of column with p-value
  eaf_col="MAF", # The effect allele frequency
  samplesize_col = "N") # Add sample size when availabe, as this is useful for steiger
exposure_loneliness$exposure <- "loneliness"
length(exposure_loneliness$SNP) 
#  7723212 Markers   

#QC
# Select genome-wide significant snps
exposure_loneliness5e8 <- subset(exposure_loneliness, pval.exposure < 5e-8)
length(exposure_loneliness5e8$SNP) #1146



#######Harmonizing all first#########
DataMR_lonelinesstoF1 <- harmonise_data(exposure_dat = exposure_loneliness5e8, outcome_dat = outcome_F1, action=2) #e-8
table(DataMR_lonelinesstoF1$mr_keep) # This columns tells you which SNPs will be kept for the main analysis: All rows that are set to TRUE will be included in the MR analysis. 
# N=412=> Number of SNPs kept for MR analysis after harmonisation
attr(DataMR_lonelinesstoF1, "log") # Detailed summary of what was done and reasons for excluding SNPs 
length(DataMR_lonelinesstoF1$SNP) 

# clumping
exposure_loneliness5e8_clumped <- clump_data(DataMR_lonelinesstoF1, clump_r2 = 0.001, clump_p1 = 1, clump_p2 = 1, clump_kb = 10000)
length(exposure_loneliness5e8_clumped$SNP) # N included = 11

# Run MR 
(MR_lonelinesstoF1 <- mr(exposure_loneliness5e8_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median","mr_egger_regression_bootstrap")))
knitr::kable(as.data.frame(MR_lonelinesstoF1), "markdown") 

#Cochran Q statistics
Results_lonelinesstoF1_heterogeneity <- mr_heterogeneity(exposure_loneliness5e8_clumped)
Results_lonelinesstoF1_heterogeneity 
knitr::kable(as.data.frame(Results_lonelinesstoF1_heterogeneity))
#not significant, so no can assume homogeneity and use IVW

## Pleiotropy test
Results_lonelinesstoF1_pleiotropy <- mr_pleiotropy_test(exposure_loneliness5e8_clumped)
Results_lonelinesstoF1_pleiotropy 
knitr::kable(as.data.frame(Results_lonelinesstoF1_pleiotropy ), "markdown")
#not significant, so can assume no horizontal pleiotropy

# Leave-one-out analysis
DataMR_lonelinesstoF1_leaveOut_ivw <- mr_leaveoneout(exposure_loneliness5e8_clumped) # Default: ivw method
DataMR_lonelinesstoF1_leaveOut_egger <- mr_leaveoneout(exposure_loneliness5e8_clumped, method = mr_egger_regression)
DataMR_lonelinesstoF1_leaveOut_egger_boot <- mr_leaveoneout(exposure_loneliness5e8_clumped, method = mr_egger_regression_bootstrap)

knitr::kable(as.data.frame(DataMR_lonelinesstoF1_leaveOut_ivw), "markdown")
knitr::kable(as.data.frame(DataMR_lonelinesstoF1_leaveOut_egger), "markdown")
knitr::kable(as.data.frame(DataMR_lonelinesstoF1_leaveOut_egger_boot), "markdown")

# MR Egger Sensitivity Analysis
# Calculate baselines estimates on this new dataset with weaker instruments
# Preliminary step: take only variants with smallest absolute effect sizes, if not (we have I2 >99%) and no correction needed

# First, select variants with the weaker betas
DataMR_lonelinesstoF1k <- DataMR_lonelinesstoF1[abs(exposure_loneliness5e8_clumped$beta.exposure) < quantile(abs(exposure_loneliness5e8_clumped$beta.exposure), 0.20), ] 
# Second, take out instruments excluded in  TwoSampleMR
DataMR_lonelinesstoF1k_keep <- DataMR_lonelinesstoF1k[DataMR_lonelinesstoF1k$mr_keep == "TRUE", ] 
length(DataMR_lonelinesstoF1k_keep$SNP) # 77 variants selected. Note that a very small number for MR Egger (e.g. 8) yield completely unstable estimates.

# Calculate baselines estimates on this new dataset with weaker instruments
(MR_lonelinesstoF1 <- mr(DataMR_lonelinesstoF1k_keep, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median","mr_egger_regression_bootstrap")))
knitr::kable(as.data.frame(MR_lonelinesstoF1), "markdown")

#Function to calculate I2
Isq <- function(y,s){
  k = length(y)
  w = 1/s^2; sum.w = sum(w)
  mu.hat = sum(y*w)/sum.w
  Q = sum(w*(y - mu.hat)^2)
  Isq = (Q - (k - 1))/Q
  Isq = max(0, Isq)
  return(Isq)
}

# If BetaXG and seBetaXG represent the vector of SNP-exposure estimates and standard errors, and BetaYG and seBetaYG represent the vector of SNP-exposure estimates and standard errors. We calculate the I 2
# Then do: Isq(BetaXG,seBetaXG)
# For MR regression weighted: Isq(BetaXG/seBetaYG,seBetaXG/seBetaYG)

# 1. Calculate I2 (I squared) - include all instruments
(isqldl <- Isq(y = DataMR_lonelinesstoF1k$beta.exposure, s = DataMR_lonelinesstoF1k$se.exposure))
#ISQ = .972 (which is very high)

# 2. I2 with weaker instruments
(isqldl_w <- Isq(DataMR_lonelinesstoF1k$beta.exposure/DataMR_lonelinesstoF1k$se.outcome, DataMR_lonelinesstoF1k$se.exposure/DataMR_lonelinesstoF1k$se.outcome))
# the ISQ is very similar (.972)

#therefore no correction is needed




## MR Steiger
#     - TwoSampleMR relies on package psych, r.test(n = mean(n_exp), n2 = mean(n_out), r12 = r_exp, r34 = r_out)
#     -  n and n2 are the average N for exposure and outcome, r12 the r of the correlation with exposure and r34 with outcome (the 12 and 34 are there two show that variables are not the same)

# 2) Run MR-Steiger
DataMR_lonelinesstoF1_Steiger <- directionality_test(exposure_loneliness5e8_clumped)
DataMR_lonelinesstoF1_Steiger
knitr::kable(as.data.frame(DataMR_lonelinesstoF1_Steiger), "markdown") #TRUE causal direction

# apply the test on one SNP
DataMR_lonelinesstoF1_Steiger <- directionality_test(exposure_loneliness5e8_clumped[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome (although both of them are very small as this is just one SNP)
DataMR_lonelinesstoF1_Steiger$snp_r2.exposure/DataMR_lonelinesstoF1_Steiger$snp_r2.outcome # effect on the exposure 2.6 times bigger

#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(exposure_loneliness5e8_clumped)[1], ncol = 8) 
for (i in 1:dim(exposure_loneliness5e8_clumped)[1]){
  temp  <- directionality_test(exposure_loneliness5e8_clumped[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_lonelinesstoF1_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")

exposure_loneliness5e8_clumped$correct_causal_direction <- SteigerSNPs$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_lonelinesstoF1_Steigerfiltered <- exposure_loneliness5e8_clumped[exposure_loneliness5e8_clumped$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_lonelinesstoF1_Steigerfiltered ) #check that number of rows matches - all 18 are in the correct direction

(MR_lonelinesstoF1_Steigerfiltered <- mr(DataMR_lonelinesstoF1_Steigerfiltered))
knitr::kable(MR_lonelinesstoF1_Steigerfiltered, "markdown")


# Create forest plot
# Pick the different methods that you want to compare
MR_lonelinesstoF1_Egger_single <- mr_singlesnp(exposure_loneliness5e8_clumped, all_method = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_lonelinesstoF1_forest <- mr_forest_plot(MR_lonelinesstoF1_Egger_single)
MR_lonelinesstoF1_forest[[1]]

# Create scatter plot
MR_LONEtoF1_IVW_Egger <- mr(exposure_loneliness5e8_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_LONEtoF1_IVW_Egger_scatter <- mr_scatter_plot(MR_LONEtoF1_IVW_Egger, exposure_loneliness5e8_clumped)
MR_LONEtoF1_IVW_Egger_scatter[[1]]

#####################

### F1(Qsnp) to Loneliness

##processing outcome data
outcome_loneliness <- read_outcome_data(
  snps = NULL,                            # Keep 'snps=NULL' so that all SNPs are uploaded
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\LONE",    # This is the filename of the summary statistics file for your outcome
  sep = "\t",                           # Specify whether the file is a tab delimited file ("\t") or a space delimited file ("")
  snp_col = "SNP",# Insert the name of column that includes the SNP ID's
  chr_col = "CHR",
  pos_col = "BP",
  beta_col = "BETA",                      # Insert the name of column with effect sizes
  se_col = "SE",                          # Insert the name of column with standard errors
  effect_allele_col = "A1",    # Insert the name of column with the effect allele
  other_allele_col = "A2",      # Insert the name of column with the non-effect allele
  pval_col = "P", # Insert the name of column with p-value
  eaf_col="MAF",
  samplesize_col = "N")    # Insert the name of column with effect allele frequency
# Note: A few columns are not present in the sum stat file so cannot be read directly but can be added
outcome_loneliness$outcome <- "loneliness" # Provide a name for the outcome
# Add the number of participants included as cases (i.e. the number of participants with the disease)    # Derive the total sample size, this should be N=184305
# Inspect your uploaded file:
length(outcome_loneliness$SNP) # Number of SNPs included  = 7723212

#QSNP F1 exposure
exposure_F1Qsnp <- read_exposure_data(
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\F1_GWAS_Qsnp", # This is the filename of the summary statistics file for your exposure
  sep = " ",# Specify whether the file is a tab delimited file ("\t") or a space delimited file ("")
  snp_col = "SNP",           # Insert the name of column that includes the SNP ID's
  beta_col = "BETA",         # Insert the name of column with effect sizes
  chr_col = "CHR",
  pos_col = "BP",
  se_col = "SE",        # Insert the ame of column with standard errors
  effect_allele_col = "A1",  # Insert the name of column with the effect allele
  other_allele_col = "A2",   # Insert the name of column with the non-effect allele
  pval_col = "P",  # Insert the name of column with p-value
  eaf_col="MAF", # The effect allele frequency
  samplesize_col = "N") # Add sample size when availabe, as this is useful for steiger

exposure_F1Qsnp$exposure <- "F1_Qsnp" 

#QC
#Qsnp sig
exposure_F1Qsnp5e8 <- subset(exposure_F1Qsnp, pval.exposure < 5e-8)
length(exposure_F1Qsnp5e8$SNP) #513 SNPs

#Harmonize Qsnp

DataMR_F1Qtoloneliness <- harmonise_data(exposure_dat = exposure_F1Qsnp5e8, outcome_dat = outcome_loneliness, action=2)
table(DataMR_F1Qtoloneliness$mr_keep) # This columns tells you which SNPs will be kept for the main analysis: All rows that are set to TRUE will be included in the MR analysis. 
# N=471=> Number of SNPs kept for MR analysis after harmonisation
attr(DataMR_F1Qtoloneliness, "log") 

#QSNP data clump
exposure_F1Qsnp5e8_clumped <- clump_data(DataMR_F1Qtoloneliness, clump_r2 = 0.001, clump_p1 = 1, clump_p2 = 1, clump_kb = 10000)
# Lets have a look at the number of SNPs we excluded
length(exposure_F1Qsnp5e8_clumped$SNP) # N included = 11


##MR 
(MR_F1Qtoloneliness <- mr(exposure_F1Qsnp5e8_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median")))
knitr::kable(as.data.frame(MR_F1Qtoloneliness), "markdown") #all sig except egger


#Sensitivity Analyses
#Cochran Q statistics
Results_F1Qtoloneliness_heterogeneity <- mr_heterogeneity(exposure_F1Qsnp5e8_clumped)
Results_F1Qtoloneliness_heterogeneity 
knitr::kable(as.data.frame(Results_F1Qtoloneliness_heterogeneity), "markdown") #sig, so must refer to Steiger

# NOTE: As with the mr() function, the mr_heterogeneity() function can take an argument to only perform heterogeneity tests using specified methods, e.g.

# Pleiotropy test
Results_F1Qtoloneliness_pleiotropy <- mr_pleiotropy_test(exposure_F1Qsnp5e8_clumped)
Results_F1Qtoloneliness_pleiotropy #just non sig, suggesting that results are unlikely to be  driven by pleiotropy, IVW is fine, but so is Egger
knitr::kable(as.data.frame(Results_F1Qtoloneliness_pleiotropy), "markdown")


# Leave-one-out analysis - good to see if results are biased by single SNPS
DataMR_F1Qtoloneliness_leaveOut_egger<- mr_leaveoneout(exposure_F1Qsnp5e8_clumped, method = mr_egger_regression) # Default: ivw method
DataMR_F1Qtoloneliness_leaveOut_ivw <- mr_leaveoneout(exposure_F1Qsnp5e8_clumped, method = mr_ivw) # Default: ivw method
knitr::kable(as.data.frame(DataMR_F1Qtoloneliness_leaveOut_ivw), "markdown")
knitr::kable(as.data.frame(DataMR_F1Qtoloneliness_leaveOut_egger), "markdown") #n.s

# Check max and min of the beta and the pvalue to see if any snp has changed them dramatically
out2 <- apply(DataMR_F1Qtoloneliness_leaveOut_egger[,c("b","p")], 2, function(x) {cbind(min(x), max(x))})
knitr::kable(as.data.frame(out2), "markdown") #doesnt seem that any SNP has had a dramatic effect

# Calculate baselines estimates on this new dataset with weaker instruments
# Preliminary step: take only variants with smallest absolute effect sizes, if not (we have I2 >99%) and no correction needed

# First, select variants with the weaker betas
DataMR_F1Qtolonelinessk <- DataMR_F1Qtoloneliness[abs(exposure_F1Qsnp5e8_clumped$beta.exposure) < quantile(abs(exposure_F1Qsnp5e8_clumped$beta.exposure), 0.20), ] 
# Second, take out instruments excluded in  TwoSampleMR
DataMR_F1Qtolonelinessk_keep <- DataMR_F1Qtolonelinessk[DataMR_F1Qtolonelinessk$mr_keep == "TRUE", ] 
length(DataMR_F1Qtolonelinessk_keep$SNP) # 99 variants selected. Note that a very small number for MR Egger (e.g. 8) yield completely unstable estimates.

# Calculate baselines estimates on this new dataset with weaker instruments
(MR_F1Qtoloneliness <- mr(DataMR_F1Qtolonelinessk_keep, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median")))
knitr::kable(as.data.frame(MR_F1Qtoloneliness), "markdown") #same as before

#Function to calculate I2
Isq <- function(y,s){
  k = length(y)
  w = 1/s^2; sum.w = sum(w)
  mu.hat = sum(y*w)/sum.w
  Q = sum(w*(y - mu.hat)^2)
  Isq = (Q - (k - 1))/Q
  Isq = max(0, Isq)
  return(Isq)
}

# If BetaXG and seBetaXG represent the vector of SNP-exposure estimates and standard errors, and BetaYG and seBetaYG represent the vector of SNP-exposure estimates and standard errors. We calculate the I 2
# Then do: Isq(BetaXG,seBetaXG)
# For MR regression weighted: Isq(BetaXG/seBetaYG,seBetaXG/seBetaYG)

# Example with  loneliness
# 1. Calculate I2 (I squared) - include all instruments
(isqloneliness <- Isq(y = DataMR_F1Qtolonelinessk$beta.exposure, s = DataMR_F1Qtolonelinessk$se.exposure))# Very high (97) many strong variants, so not much to correct for

# 1. Calculate I2 (I squared) - include only weak instruments
(isqloneliness_w <- Isq(DataMR_F1Qtolonelinessk$beta.exposure/DataMR_F1Qtolonelinessk$se.outcome, DataMR_F1Qtolonelinessk$se.exposure/DataMR_F1Qtolonelinessk$se.outcome))# Very close
# Despite weaker variant, I2 is high (97%) so really no problem of weak instrument

MR_F1Qtoloneliness_single <- mr_singlesnp(exposure_F1Qsnp5e8_clumped, all_method = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_F1Qtoloneliness_forest <- mr_forest_plot(MR_F1Qtoloneliness_single)
MR_F1Qtoloneliness_forest[[1]]

MR_F1toloneliness_IVW_Egger <- mr(exposure_F1Qsnp5e8_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_F1toloneliness_IVW_Egger_scatter <- mr_scatter_plot(MR_F1toloneliness_IVW_Egger, exposure_F1Qsnp5e8_clumped)
MR_F1toloneliness_IVW_Egger_scatter[[1]]

## MR Steiger
#     - TwoSampleMR relies on package psych, r.test(n = mean(n_exp), n2 = mean(n_out), r12 = r_exp, r34 = r_out)
#     -  n and n2 are the average N for exposure and outcome, r12 the r of the correlation with exposure and r34 with outcome (the 12 and 34 are there two show that variables are not the same)
# 2) Run MR-Steiger
DataMR_F1Qtoloneliness_Steiger <- directionality_test(exposure_F1Qsnp5e8_clumped)
DataMR_F1Qtoloneliness_Steiger #says correct causal direction and highly sig (F1 to LONE)
knitr::kable(as.data.frame(DataMR_F1Qtoloneliness_Steiger))

# We can apply the test on one SNP
DataMR_F1Qtoloneliness_Steiger <- directionality_test(exposure_F1Qsnp5e8_clumped[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome (although both of them are very small as this is just one SNP)
DataMR_F1Qtoloneliness_Steiger$snp_r2.exposure/DataMR_F1Qtoloneliness_Steiger$snp_r2.outcome # effect on the exposure 4.46 times bigger


#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(exposure_F1Qsnp5e8_clumped)[1], ncol = 8) 
for (i in 1:dim(exposure_F1Qsnp5e8_clumped)[1]){
  temp  <- directionality_test(exposure_F1Qsnp5e8_clumped[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_F1Qtoloneliness_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")

table(SteigerSNPs$correct_causal_direction) # 19 SNPS were valid instruments with the correct causal direction


exposure_F1Qsnp5e8_clumped$correct_causal_direction <- SteigerSNPs$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_F1Qtoloneliness_Steigerfiltered <- exposure_F1Qsnp5e8_clumped[exposure_F1Qsnp5e8_clumped$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_F1Qtoloneliness_Steigerfiltered) #check that number of rows matches


##############

## MR with reduced p-value threshold ##

#5e7
exposure_loneliness5e7 <- subset(exposure_loneliness, pval.exposure < 5e-7)
length(exposure_loneliness5e7$SNP) #1851

DataMR_lonelinesstoF1 <- harmonise_data(exposure_dat = exposure_loneliness5e7, outcome_dat = outcome_F1, action=2) #e-7
# N=696=> Number of SNPs kept for MR analysis after harmonisation
length(DataMR_lonelinesstoF1$SNP) #696 total variants for MR, 15 palindromic, 1011 absent from reference

exposure_loneliness5e7_clumped <- clump_data(DataMR_lonelinesstoF1, clump_r2 = 0.001, clump_p1 = 1, clump_p2 = 1, clump_kb = 10000)
# Lets have a look at the number of SNPs we excluded
length(exposure_loneliness5e7_clumped$SNP) # N included = 24

# Run MR 
(MR_lonelinesstoF1 <- mr(exposure_loneliness5e7_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median")))
knitr::kable(as.data.frame(MR_lonelinesstoF1), "markdown") 

#Cochran Q statistics
Results_lonelinesstoF1_heterogeneity <- mr_heterogeneity(exposure_loneliness5e7_clumped)
Results_lonelinesstoF1_heterogeneity 
knitr::kable(as.data.frame(Results_lonelinesstoF1_heterogeneity))
#not significant, so no can assume homogeneity and use IVW

## Pleiotropy test
Results_lonelinesstoF1_pleiotropy <- mr_pleiotropy_test(exposure_loneliness5e7_clumped)
Results_lonelinesstoF1_pleiotropy 
knitr::kable(as.data.frame(Results_lonelinesstoF1_pleiotropy ), "markdown")
#not significant, so can assume no horizontal pleiotropy

# Leave-one-out analysis
DataMR_lonelinesstoF1_leaveOut_ivw <- mr_leaveoneout(exposure_loneliness5e7_clumped) # Default: ivw method
DataMR_lonelinesstoF1_leaveOut_egger <- mr_leaveoneout(exposure_loneliness5e7_clumped, method = mr_egger_regression)
DataMR_lonelinesstoF1_leaveOut_egger_boot <- mr_leaveoneout(exposure_loneliness5e7_clumped, method = mr_egger_regression_bootstrap)

knitr::kable(as.data.frame(DataMR_lonelinesstoF1_leaveOut_ivw), "markdown")
knitr::kable(as.data.frame(DataMR_lonelinesstoF1_leaveOut_egger), "markdown")
knitr::kable(as.data.frame(DataMR_lonelinesstoF1_leaveOut_egger_boot), "markdown")

# MR Egger Sensitivity Analysis
# Calculate baselines estimates on this new dataset with weaker instruments
# Preliminary step: take only variants with smallest absolute effect sizes, if not (we have I2 >99%) and no correction needed

# First, select variants with the weaker betas
DataMR_lonelinesstoF1k <- DataMR_lonelinesstoF1[abs(exposure_loneliness5e7_clumped$beta.exposure) < quantile(abs(exposure_loneliness5e7_clumped$beta.exposure), 0.20), ] 
# Second, take out instruments excluded in  TwoSampleMR
DataMR_lonelinesstoF1k_keep <- DataMR_lonelinesstoF1k[DataMR_lonelinesstoF1k$mr_keep == "TRUE", ] 
length(DataMR_lonelinesstoF1k_keep$SNP) # 139 variants selected. Note that a very small number for MR Egger (e.g. 8) yield completely unstable estimates.

# Calculate baselines estimates on this new dataset with weaker instruments
(MR_lonelinesstoF1 <- mr(DataMR_lonelinesstoF1k_keep, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median")))
knitr::kable(as.data.frame(MR_lonelinesstoF1), "markdown")

#Function to calculate I2
Isq <- function(y,s){
  k = length(y)
  w = 1/s^2; sum.w = sum(w)
  mu.hat = sum(y*w)/sum.w
  Q = sum(w*(y - mu.hat)^2)
  Isq = (Q - (k - 1))/Q
  Isq = max(0, Isq)
  return(Isq)
}

# If BetaXG and seBetaXG represent the vector of SNP-exposure estimates and standard errors, and BetaYG and seBetaYG represent the vector of SNP-exposure estimates and standard errors. We calculate the I 2
# Then do: Isq(BetaXG,seBetaXG)
# For MR regression weighted: Isq(BetaXG/seBetaYG,seBetaXG/seBetaYG)

# 1. Calculate I2 (I squared) - include all instruments
(isqldl <- Isq(y = DataMR_lonelinesstoF1k$beta.exposure, s = DataMR_lonelinesstoF1k$se.exposure))
#ISQ = .970 (which is very high)

# 2. I2 with weaker instruments
(isqldl_w <- Isq(DataMR_lonelinesstoF1k$beta.exposure/DataMR_lonelinesstoF1k$se.outcome, DataMR_lonelinesstoF1k$se.exposure/DataMR_lonelinesstoF1k$se.outcome))
# the ISQ is very similar (.972)

#therefore no correction is needed




## MR Steiger
#     - TwoSampleMR relies on package psych, r.test(n = mean(n_exp), n2 = mean(n_out), r12 = r_exp, r34 = r_out)
#     -  n and n2 are the average N for exposure and outcome, r12 the r of the correlation with exposure and r34 with outcome (the 12 and 34 are there two show that variables are not the same)

# 2) Run MR-Steiger
DataMR_lonelinesstoF1_Steiger <- directionality_test(exposure_loneliness5e7_clumped)
DataMR_lonelinesstoF1_Steiger
knitr::kable(as.data.frame(DataMR_lonelinesstoF1_Steiger), "markdown") #TRUE causal direction

# apply the test on one SNP
DataMR_lonelinesstoF1_Steiger <- directionality_test(exposure_loneliness5e7_clumped[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome (although both of them are very small as this is just one SNP)
DataMR_lonelinesstoF1_Steiger$snp_r2.exposure/DataMR_lonelinesstoF1_Steiger$snp_r2.outcome # effect on the exposure 2.6 times bigger

#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(exposure_loneliness5e7_clumped)[1], ncol = 8) 
for (i in 1:dim(exposure_loneliness5e7_clumped)[1]){
  temp  <- directionality_test(exposure_loneliness5e7_clumped[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_lonelinesstoF1_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")

exposure_loneliness5e7_clumped$correct_causal_direction <- SteigerSNPs$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_lonelinesstoF1_Steigerfiltered <- exposure_loneliness5e7_clumped[exposure_loneliness5e7_clumped$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_lonelinesstoF1_Steigerfiltered ) #check that number of rows matches - 22 are in the correct direction,meaning2 were in the wrong direction

(MR_lonelinesstoF1_Steigerfiltered <- mr(DataMR_lonelinesstoF1_Steigerfiltered, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median","mr_egger_regression_bootstrap")))
knitr::kable(MR_lonelinesstoF1_Steigerfiltered, "markdown")


# Create forest plot
# Pick the different methods that you want to compare
MR_lonelinesstoF1_Egger_single <- mr_singlesnp(exposure_loneliness5e7_clumped, all_method = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_lonelinesstoF1_forest <- mr_forest_plot(MR_lonelinesstoF1_Egger_single)
MR_lonelinesstoF1_forest[[1]]

# Create scatter plot
MR_LONEtoF1_IVW_Egger <- mr(exposure_loneliness5e7_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_LONEtoF1_IVW_Egger_scatter <- mr_scatter_plot(MR_LONEtoF1_IVW_Egger, exposure_loneliness5e7_clumped)
MR_LONEtoF1_IVW_Egger_scatter[[1]]

#STEIGER PLOTS
# Create forest plot
# Pick the different methods that you want to compare
MR_lonelinesstoF1_Egger_single <- mr_singlesnp(DataMR_lonelinesstoF1_Steigerfiltered, all_method = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_lonelinesstoF1_forest <- mr_forest_plot(MR_lonelinesstoF1_Egger_single)
MR_lonelinesstoF1_forest[[1]]

# Create scatter plot
MR_LONEtoF1_IVW_Egger <- mr(DataMR_lonelinesstoF1_Steigerfiltered, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_LONEtoF1_IVW_Egger_scatter <- mr_scatter_plot(MR_LONEtoF1_IVW_Egger, DataMR_lonelinesstoF1_Steigerfiltered)
MR_LONEtoF1_IVW_Egger_scatter[[1]]



#### F1 Q to Loneliness with reduced p-value threshold

exposure_F1Qsnp5e7 <- subset(exposure_F1Qsnp, pval.exposure < 5e-7)
length(exposure_F1Qsnp5e7$SNP) #809 SNPs

DataMR_F1Qtoloneliness <- harmonise_data(exposure_dat = exposure_F1Qsnp5e7, outcome_dat = outcome_loneliness, action=2)
table(DataMR_F1Qtoloneliness$mr_keep) # This columns tells you which SNPs will be kept for the main analysis: All rows that are set to TRUE will be included in the MR analysis. 
# N=746=> Number of SNPs kept for MR analysis after harmonisation
attr(DataMR_F1Qtoloneliness, "log")

#QSNP data clump
exposure_F1Qsnp5e7_clumped <- clump_data(DataMR_F1Qtoloneliness, clump_r2 = 0.001, clump_p1 = 1, clump_p2 = 1, clump_kb = 10000)
# Lets have a look at the number of SNPs we excluded
length(exposure_F1Qsnp5e7_clumped$SNP) # N included = 21

##MR 
(MR_F1Qtoloneliness <- mr(exposure_F1Qsnp5e7_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median")))
knitr::kable(as.data.frame(MR_F1Qtoloneliness), "markdown") #all sig except egger


#Sensitivity Analyses
#Cochran Q statistics
Results_F1Qtoloneliness_heterogeneity <- mr_heterogeneity(exposure_F1Qsnp5e7_clumped)
Results_F1Qtoloneliness_heterogeneity 
knitr::kable(as.data.frame(Results_F1Qtoloneliness_heterogeneity), "markdown") #sig, so must refer to Steiger

# NOTE: As with the mr() function, the mr_heterogeneity() function can take an argument to only perform heterogeneity tests using specified methods, e.g.

# Pleiotropy test
Results_F1Qtoloneliness_pleiotropy <- mr_pleiotropy_test(exposure_F1Qsnp5e7_clumped)
Results_F1Qtoloneliness_pleiotropy #just non sig, suggesting that results are unlikely to be  driven by pleiotropy, IVW is fine, but so is Egger
knitr::kable(as.data.frame(Results_F1Qtoloneliness_pleiotropy), "markdown")


# Leave-one-out analysis - good to see if results are biased by single SNPS
DataMR_F1Qtoloneliness_leaveOut_egger<- mr_leaveoneout(exposure_F1Qsnp5e7_clumped, method = mr_egger_regression) # Default: ivw method
DataMR_F1Qtoloneliness_leaveOut_ivw <- mr_leaveoneout(exposure_F1Qsnp5e7_clumped, method = mr_ivw) # Default: ivw method
knitr::kable(as.data.frame(DataMR_F1Qtoloneliness_leaveOut_ivw), "markdown")
knitr::kable(as.data.frame(DataMR_F1Qtoloneliness_leaveOut_egger), "markdown") #n.s

# Check max and min of the beta and the pvalue to see if any snp has changed them dramatically
out2 <- apply(DataMR_F1Qtoloneliness_leaveOut_egger[,c("b","p")], 2, function(x) {cbind(min(x), max(x))})
knitr::kable(as.data.frame(out2), "markdown") #doesnt seem that any SNP has had a dramatic effect

# Calculate baselines estimates on this new dataset with weaker instruments
# Preliminary step: take only variants with smallest absolute effect sizes, if not (we have I2 >99%) and no correction needed

# First, select variants with the weaker betas
DataMR_F1Qtolonelinessk <- DataMR_F1Qtoloneliness[abs(exposure_F1Qsnp5e7_clumped$beta.exposure) < quantile(abs(exposure_F1Qsnp5e7_clumped$beta.exposure), 0.20), ] 
# Second, take out instruments excluded in  TwoSampleMR
DataMR_F1Qtolonelinessk_keep <- DataMR_F1Qtolonelinessk[DataMR_F1Qtolonelinessk$mr_keep == "TRUE", ] 
length(DataMR_F1Qtolonelinessk_keep$SNP) # 99 variants selected. Note that a very small number for MR Egger (e.g. 8) yield completely unstable estimates.

# Calculate baselines estimates on this new dataset with weaker instruments
(MR_F1Qtoloneliness <- mr(DataMR_F1Qtolonelinessk_keep, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median")))
knitr::kable(as.data.frame(MR_F1Qtoloneliness), "markdown") #same as before

#Function to calculate I2
Isq <- function(y,s){
  k = length(y)
  w = 1/s^2; sum.w = sum(w)
  mu.hat = sum(y*w)/sum.w
  Q = sum(w*(y - mu.hat)^2)
  Isq = (Q - (k - 1))/Q
  Isq = max(0, Isq)
  return(Isq)
}

# If BetaXG and seBetaXG represent the vector of SNP-exposure estimates and standard errors, and BetaYG and seBetaYG represent the vector of SNP-exposure estimates and standard errors. We calculate the I 2
# Then do: Isq(BetaXG,seBetaXG)
# For MR regression weighted: Isq(BetaXG/seBetaYG,seBetaXG/seBetaYG)

# Example with  loneliness
# 1. Calculate I2 (I squared) - include all instruments
(isqloneliness <- Isq(y = DataMR_F1Qtolonelinessk$beta.exposure, s = DataMR_F1Qtolonelinessk$se.exposure))# Very high (97) many strong variants, so not much to correct for

# 1. Calculate I2 (I squared) - include only weak instruments
(isqloneliness_w <- Isq(DataMR_F1Qtolonelinessk$beta.exposure/DataMR_F1Qtolonelinessk$se.outcome, DataMR_F1Qtolonelinessk$se.exposure/DataMR_F1Qtolonelinessk$se.outcome))# Very close
# Despite weaker variant, I2 is high (97%) so really no problem of weak instrument

#forest
MR_F1Qtoloneliness_single <- mr_singlesnp(exposure_F1Qsnp5e7_clumped, all_method = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_F1Qtoloneliness_forest <- mr_forest_plot(MR_F1Qtoloneliness_single)
MR_F1Qtoloneliness_forest[[1]]

#scatter
MR_F1toloneliness_IVW_Egger <- mr(exposure_F1Qsnp5e7_clumped, method_list = c("mr_egger_regression","mr_ivw","mr_weighted_mode","mr_weighted_median"))
MR_F1toloneliness_IVW_Egger_scatter <- mr_scatter_plot(MR_F1toloneliness_IVW_Egger, exposure_F1Qsnp5e7_clumped)
MR_F1toloneliness_IVW_Egger_scatter[[1]]

## MR Steiger
#     - TwoSampleMR relies on package psych, r.test(n = mean(n_exp), n2 = mean(n_out), r12 = r_exp, r34 = r_out)
#     -  n and n2 are the average N for exposure and outcome, r12 the r of the correlation with exposure and r34 with outcome (the 12 and 34 are there two show that variables are not the same)
# 2) Run MR-Steiger
DataMR_F1Qtoloneliness_Steiger <- directionality_test(exposure_F1Qsnp5e8_clumped)
DataMR_F1Qtoloneliness_Steiger #says correct causal direction and highly sig (F1 to LONE)
knitr::kable(as.data.frame(DataMR_F1Qtoloneliness_Steiger))

# We can apply the test on one SNP
DataMR_F1Qtoloneliness_Steiger <- directionality_test(exposure_F1Qsnp5e8_clumped[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome (although both of them are very small as this is just one SNP)
DataMR_F1Qtoloneliness_Steiger$snp_r2.exposure/DataMR_F1Qtoloneliness_Steiger$snp_r2.outcome # effect on the exposure 4.46 times bigger


#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(exposure_F1Qsnp5e8_clumped)[1], ncol = 8) 
for (i in 1:dim(exposure_F1Qsnp5e8_clumped)[1]){
  temp  <- directionality_test(exposure_F1Qsnp5e8_clumped[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_F1Qtoloneliness_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")

table(SteigerSNPs$correct_causal_direction) # 19 SNPS were valid instruments with the correct causal direction


exposure_F1Qsnp5e8_clumped$correct_causal_direction <- SteigerSNPs$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_F1Qtoloneliness_Steigerfiltered <- exposure_F1Qsnp5e8_clumped[exposure_F1Qsnp5e8_clumped$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_F1Qtoloneliness_Steigerfiltered) #check that number of rows matches


