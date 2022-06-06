## Mendelian Randomization in R

- Mendelian Randomization was executed using [TwoSampleMR](https://mrcieu.github.io/TwoSampleMR/) in R
- the loneliness sumstats file (Day et al, 2018) was used as the exposure
- the internalising (F1) sumstats file (generated via multivariate GWA) was used as the outcome

### Installing Libraries
```r
#libraries
install.packages("remotes")
remotes::install_github("MRCIEU/TwoSampleMR") #TwoSampleMR
library(data.table)
library(TwoSampleMR)
```
## Loneliness on F1
### Processing Outcome and Exposure Data
- this involves re-naming columns so that they can be read by MR
```r
#outcome data
outcome_F1 <- read_outcome_data(
  snps = NULL,                            #Keep 'snps=NULL' so that all SNPs are uploaded
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\F1LONE", #This is the filename of the summary statistics file for your outcome
  sep = "\t",  #Specify whether the file is a tab delimited file ("\t") or a space delimited file ("")
  snp_col = "SNP",#Insert the name of column that includes the SNP ID's
  chr_col = "CHR",
  pos_col = "BP",
  beta_col = "BETA",  #Insert the name of column with effect sizes
  se_col = "SE",      #Insert the name of column with standard errors
  effect_allele_col = "A1", #Insert the name of column with the effect allele
  other_allele_col = "A2",  #Insert the name of column with the non-effect allele
  pval_col = "P", #Insert the name of column with p-value
  eaf_col="MAF",
  samplesize_col = "N")    #Insert the name of column with effect allele frequency
#Note: A few columns are not present in the sum stat file so cannot be read directly but can be added
outcome_internalising$outcome <- "F1" #Provide a name for the outcome

#Inspect your uploaded file:
length(outcome_F1$SNP) 

#Number of SNPs included  = 1968630


#exposure data

exposure_loneliness <- read_exposure_data(
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\LONE", 
  sep = "\t",
  snp_col = "SNP",        
  beta_col = "BETA",         
  chr_col = "CHR",
  pos_col = "BP",
  se_col = "SE",       
  effect_allele_col = "A1",  
  other_allele_col = "A2", 
  pval_col = "P",  
  eaf_col="MAF",
  samplesize_col = "N") 

exposure_loneliness$exposure <- "loneliness"       
length(exposure_loneliness$SNP)

#Number of SNPs included = 7723212
```

### Quality Control, Harmonizing, then Clumping
- quality control involves selecting only significant genome-wide significant p-values for loneliness, harmonizing the data across GWAS' and clumping

```r
#Select genome-wide significant snps
exposure_loneliness5e8 <- subset(exposure_loneliness, pval.exposure < 5e-8)
# Lets have a look at the number of SNPs that we would include:
length(exposure_loneliness5e8$SNP) # Number of genome-wide significant snps: 15

#Harmonize
DataMR_lonelinesstoF1 <- harmonise_data(exposure_dat = exposure_loneliness5e8, outcome_dat = outcome_F1, action=2)
table(DataMR_lonelinesstoF1$mr_keep) # This columns tells you which SNPs will be kept for the main analysis: All rows that are set to TRUE will be included in the MR analysis. 

# N=420 => Number of SNPs kept for MR analysis after harmonisation
attr(DataMR_lonelinesstoF1, "log") # Detailed summary of what was done and reasons for excluding SNPs 



#Clump
exposure_loneliness5e8_clumped <- clump_data(DataMR_lonelinesstoF1, clump_r2 = 0.05, clump_p1 = 1, clump_p2 = 1, clump_kb = 250)
# Lets have a look at the number of SNPs we excluded
length(exposure_loneliness5e8_clumped$SNP) 

# N included = 18

```

## Mendelian Randomization
- Results can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/MR%20Loneliness%20against%20Internalising.md).
```r
#running MR
(MR_lonelinesstoF1 <- mr(exposure_loneliness5e8_clumped))
knitr::kable(as.data.frame(exposure_loneliness5e8_clumped), "markdown")
```

### Sensitivity Analyses
Cochran Q statistics
```r
Results_lonelinesstoF1_heterogeneity <- mr_heterogeneity(exposure_loneliness5e8_clumped)
Results_lonelinesstoF1_heterogeneity 
```
Pleiotropy test
```r
Results_lonelinesstoF1_pleiotropy <- mr_pleiotropy_test(exposure_loneliness5e8_clumped)
Results_lonelinesstoF1_pleiotropy #just non sig, suggesting that results are unlikely to be  driven by pleiotropy, IVW is fine, but so is Egger
knitr::kable(as.data.frame(Results_lonelinesstoF1_pleiotropy), "markdown")
```
Leave-one-out Egger analysis - good to see if results are biased by single SNPS
- MR Egger assumes no measurement error as measurement error can lead to underestimation of the true causal effect
- To check for this, the I2 can be measured, which is an indication of measurement error annd is derived from the Cochran Q statistics
- if IR > 90%, then we do not need to worry about measurement error or bias by single SNPS
```r
DataMR_lonelinesstoF1_leaveOut_egger<- mr_leaveoneout(exposure_loneliness5e8_clumped, method = mr_egger_regression) # Default: ivw method
DataMR_lonelinesstoF1_leaveOut_egger
# Check max and min of the beta and the pvalue to see if any snp has changed them dramatically
out2 <- apply(DataMR_lonelinesstoF1_leaveOut_egger[,c("b","p")], 2, function(x) {cbind(min(x), max(x))})
knitr::kable(as.data.frame(out2), "markdown") #doesnt seem that any SNP has had a dramatic effect

```

### MR Steiger
- this tests whether the directionality we have specified is correct
- it does this by comparing the independent correlations to see if they are statistically different and, if so, to what degree they statistically differ
- The test calculates the variance explained in the exposure and the outcome by the instrumenting SNPs, and tests if the variance in the outcome is less than the exposure

```r
#Run MR-Steiger
DataMR_lonelinesstoF1_Steiger <- directionality_test(DataMR_lonelinesstoF1)
DataMR_lonelinesstoF1_Steiger 

#says correct causal direction and highly sig (loneliness to F1)

# We can apply the test on one SNP
DataMR_lonelinesstoF1_Steiger <- directionality_test(exposure_loneliness5e8_clumped[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome (although both of them are very small as this is just one SNP)
DataMR_lonelinesstoF1_Steiger$snp_r2.exposure/DataMR_lonelinesstoF1_Steiger$snp_r2.outcome # effect on the exposure 2.41


#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(exposure_loneliness5e8_clumped)[1], ncol = 8) 
for (i in 1:dim(exposure_loneliness5e8_clumped)[1]){
  temp  <- directionality_test(exposure_loneliness5e8_clumped[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_lonelinesstoF1_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")
save(SteigerSNPs, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\SteigerSNPs.RData")

table(SteigerSNPs$correct_causal_direction) # all SNPs in the right direction

exposure_loneliness5e8_clumped$correct_causal_direction <- SteigerSNPs$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_lonelinesstoF1_Steigerfiltered <- exposure_loneliness5e8_clumped[exposure_loneliness5e8_clumped$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_lonelinesstoF1_Steigerfiltered) # rows match

# Redo MR with Steiger 
(MR_lonelinesstoF1_Steigerfiltered <- mr(DataMR_lonelinesstoF1_Steigerfiltered))
knitr::kable(MR_lonelinesstoF1_Steigerfiltered, "markdown")

```

### Plots
- 
```r
#Create forest plot
#Pick the different methods that you want to compare
MR_lonelinesstoF1_IVW_Egger_single <- mr_singlesnp(exposure_loneliness5e8_clumped, all_method = c("mr_ivw","mr_egger_regression", "mr_weighted_median", "mr_weighted_mode"))
MR_lonelinesstoF1_forest <- mr_forest_plot(MR_lonelinesstoF1_IVW_Egger_single)
MR_lonelinesstoF1_forest[[1]]

#Create scatter plot
MR_lonelinesstoF1_IVW_Egger <- mr(exposure_loneliness5e8_clumped, method_list = c("mr_egger_regression", "mr_ivw", "mr_weighted_median", "mr_weighted_mode"))
MR_lonelinesstoF1_IVW_Egger_scatter <- mr_scatter_plot(MR_lonelinesstoF1_IVW_Egger, exposure_loneliness5e8_clumped)
MR_lonelinesstoF1_IVW_Egger_scatter[[1]]

# Funnel plot
DataMR_lonelinesstoF1k_single <- mr_singlesnp(exposure_loneliness5e8_clumped, all_method = c("mr_ivw","mr_egger_regression", "mr_weighted_median", "mr_weighted_mode"))
DataMR_lonelinesstoF1k_funnel <- mr_funnel_plot(DataMR_lonelinesstoF1k_single)
DataMR_lonelinesstoF1k_funnel[[1]]
```
## F1 on Loneliness
### Processing Outcome and Exposure Data
```r
#processing outcome data
outcome_loneliness <- read_outcome_data(
  snps = NULL,                            
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\LONE",   
  sep = "\t",                          
  snp_col = "SNP",
  chr_col = "CHR",
  pos_col = "BP",
  beta_col = "BETA",                     
  se_col = "SE",                         
  effect_allele_col = "A1",   
  other_allele_col = "A2",      
  pval_col = "P", 
  eaf_col="MAF",
  samplesize_col = "N")    # Insert the name of column with effect allele frequency
outcome_loneliness$outcome <- "loneliness" # Provide a name for the outcome

#Inspect your uploaded file:
length(outcome_loneliness$SNP)
#Number of SNPs included  = 7723212


#processing exposure data

exposure_F1 <- read_exposure_data(
  filename = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\MR and GWAS\\F1LONE",  
  sep = "\t",
  snp_col = "SNP",          
  beta_col = "BETA",         
  chr_col = "CHR",
  pos_col = "BP",
  se_col = "SE",        
  effect_allele_col = "A1",  
  other_allele_col = "A2",  
  pval_col = "P",  
  eaf_col="MAF", 
  samplesize_col = "N") 

exposure_F1$exposure <- "F1"       
length(exposure_F1$SNP)
#SNP 1096627 

```

### Quality Control, Harmonizing, then Clumping

```r
# Select genome-wide significant snps
exposure_F15e8 <- subset(exposure_F1, pval.exposure < 5e-8)
# Lets have a look at the number of SNPs that we would include:
length(exposure_F15e8$SNP) 

# Number of genome-wide significant snps: 546


#######Harmonize
DataMR_F1toloneliness <- harmonise_data(exposure_dat = exposure_F15e8, outcome_dat = outcome_loneliness, action=2)
table(DataMR_F1toloneliness$mr_keep) # This columns tells you which SNPs will be kept for the main analysis: All rows that are set to TRUE will be included in the MR analysis. 

# N=496=> Number of SNPs kept for MR analysis after harmonisation

attr(DataMR_F1toloneliness, "log") # Detailed summary of what was done and reasons for excluding SNPs 
#palindromic alleles and intermediate allele frequencies

# ========= Clump the data =========
exposure_F15e8_clumped <- clump_data(DataMR_F1toloneliness, clump_r2 = 0.001, clump_p1 = 1, clump_p2 = 1, clump_kb = 10000)
# Lets have a look at the number of SNPs we excluded
length(exposure_F15e8_clumped$SNP) 
# N included = 10
length(exposure_F15e8_clumped$SNP) - length(exposure_F15e8$SNP) 
# N excluded - 536

```

## Mendelian Randomization

```r

(MR_F1toloneliness <- mr(exposure_F15e8_clumped))
knitr::kable(as.data.frame(MR_F1toloneliness), "markdown")
```

### Sensitivity Analyses
Cochran Q statistics
```r
Results_F1toloneliness_heterogeneity <- mr_heterogeneity(exposure_F15e8_clumped)
Results_F1toloneliness_heterogeneity 
knitr::kable(as.data.frame(Results_F1toloneliness_heterogeneity), "markdown")
```
Pleiotropy test
```r
Results_F1toloneliness_pleiotropy <- mr_pleiotropy_test(exposure_F15e8_clumped)
Results_F1toloneliness_pleiotropy #just non sig, suggesting that results are unlikely to be  driven by pleiotropy, IVW is fine, but so is Egger
knitr::kable(as.data.frame(Results_F1toloneliness_pleiotropy), "markdown")
```
Leave-one-out analysis
```r
DataMR_F1toloneliness_leaveOut_egger<- mr_leaveoneout(exposure_F15e8_clumped, method = mr_egger_regression) # Default: ivw method
DataMR_F1toloneliness_leaveOut_egger
```
### MR Steiger
```r
# Check max and min of the beta and the pvalue to see if any snp has changed them dramatically
out2 <- apply(DataMR_F1toloneliness_leaveOut_egger[,c("b","p")], 2, function(x) {cbind(min(x), max(x))})
knitr::kable(as.data.frame(out2), "markdown") #doesnt seem that any SNP has had a dramatic effect

## MR Steiger
#     - TwoSampleMR relies on package psych, r.test(n = mean(n_exp), n2 = mean(n_out), r12 = r_exp, r34 = r_out)
#     -  n and n2 are the average N for exposure and outcome, r12 the r of the correlation with exposure and r34 with outcome (the 12 and 34 are there two show that variables are not the same)
library(TwoSampleMR)
# 2) Run MR-Steiger
DataMR_F1toloneliness_Steiger <- directionality_test(exposure_F15e8_clumped)
DataMR_F1toloneliness_Steiger 
#says correct causal direction and highly sig (F1 to LONE)
knitr::kable(as.data.frame(DataMR_F1toloneliness_Steiger))

# We can apply the test on one SNP
DataMR_F1toloneliness_Steiger <- directionality_test(exposure_F15e8_clumped[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome (although both of them are very small as this is just one SNP)
DataMR_F1toloneliness_Steiger$snp_r2.exposure/DataMR_F1toloneliness_Steiger$snp_r2.outcome # effect on the exposure 27.5 times bigger

#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(exposure_F15e8_clumped)[1], ncol = 8) 
for (i in 1:dim(exposure_F15e8_clumped)[1]){
  temp  <- directionality_test(exposure_F15e8_clumped[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_F1toloneliness_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")

table(SteigerSNPs$correct_causal_direction) # 9 SNPS were valid instruments with the correct causal direction

exposure_F15e8_clumped$correct_causal_direction <- SteigerSNPs$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_F1toloneliness_Steigerfiltered <- exposure_F15e8_clumped[exposure_F15e8_clumped$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_F1toloneliness_Steigerfiltered) #check that number of rows matches
# Redo MR with Steiger 
(MR_F1toloneliness_Steigerfiltered <- mr(DataMR_F1toloneliness_Steigerfiltered))
knitr::kable(MR_F1toloneliness_Steigerfiltered, "markdown")
```
### Plots
```r
# Create forest plot
# Pick the different methods that you want to compare
MR_F1toloneliness_IVW_Egger_single <- mr_singlesnp(exposure_F15e8_clumped, all_method = c("mr_ivw","mr_egger_regression", "mr_weighted_median", "mr_weighted_mode"))
MR_F1toloneliness_forest <- mr_forest_plot(MR_F1toloneliness_IVW_Egger_single)
MR_F1toloneliness_forest[[1]]

# Create scatter plot
MR_F1toloneliness_IVW_Egger <- mr(exposure_F15e8_clumped, method_list = c("mr_egger_regression", "mr_ivw"))
MR_F1toloneliness_IVW_Egger_scatter <- mr_scatter_plot(MR_F1toloneliness_IVW_Egger, exposure_F15e8_clumped)
MR_F1toloneliness_IVW_Egger_scatter[[1]]

# Normal Funnel plot

DataMR_F1tolonelinessk_single <- mr_singlesnp(exposure_F15e8_clumped, all_method = c("mr_ivw","mr_egger_regression", "mr_weighted_median", "mr_weighted_mode"))
DataMR_F1tolonelinessk_funnel <- mr_funnel_plot(DataMR_F1tolonelinessk_single)
DataMR_F1tolonelinessk_funnel[[1]]
```
