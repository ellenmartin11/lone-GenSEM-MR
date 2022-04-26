## Mendelian Randomization in R

- Mendelian Randomization was executed using TwoSampleMR in R
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

### Processing Outcome and Exposure Data
- this involves re-naming columns so that they can be read by MR
```r
#outcome data
outcome_internalising <- read_outcome_data(
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
outcome_internalising$outcome <- "internalising" #Provide a name for the outcome

#Inspect your uploaded file:
length(outcome_internalising$SNP) #Number of SNPs included  = 1096627


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
```

### Quality Control, Clumping and Harmonizing
- quality control involves selecting only significant p-values for loneliness, clumping and harmonizing the data

```r
#Select genome-wide significant snps
exposure_loneliness5e8 <- subset(exposure_loneliness, pval.exposure < 5e-8)
# Lets have a look at the number of SNPs that we would include:
length(exposure_loneliness5e8$SNP) # Number of genome-wide significant snps: 1146


#Clump
exposure_loneliness5e8_clumped <- clump_data(exposure_loneliness5e8, clump_r2 = 0.001, clump_p1 = 1, clump_p2 = 1, clump_kb = 10000)
# Lets have a look at the number of SNPs we excluded
length(exposure_loneliness5e8_clumped$SNP) # N included = 15
length(exposure_loneliness5e8_clumped$SNP) - length(exposure_loneliness5e8$SNP) # N excluded - 1131

#Harmonize
DataMR_lonelinesstointernalising <- harmonise_data(exposure_dat = exposure_loneliness5e8, outcome_dat = outcome_internalising, action=2)
table(DataMR_lonelinesstointernalising$mr_keep) # This columns tells you which SNPs will be kept for the main analysis: All rows that are set to TRUE will be included in the MR analysis. 
# N=133 => Number of SNPs kept for MR analysis after harmonisation
attr(DataMR_lonelinesstointernalising, "log") # Detailed summary of what was done and reasons for excluding SNPs 
```

## Mendelian Randomization
- Results can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/MR%20Loneliness%20against%20Internalising.md).
```r
#running MR
(MR_lonelinesstointernalising <- mr(DataMR_lonelinesstointernalising))
knitr::kable(as.data.frame(MR_lonelinesstointernalising), "markdown")
```

### Sensitivity Analyses
Cochran Q statistics
```r
Results_lonelinesstointernalising_heterogeneity <- mr_heterogeneity(DataMR_lonelinesstointernalising)
Results_lonelinesstointernalising_heterogeneity 
```
Pleiotropy test
```r
Results_lonelinesstointernalising_pleiotropy <- mr_pleiotropy_test(DataMR_lonelinesstointernalising)
Results_lonelinesstointernalising_pleiotropy #just non sig, suggesting that results are unlikely to be  driven by pleiotropy, IVW is fine, but so is Egger
knitr::kable(as.data.frame(Results_lonelinesstointernalising_pleiotropy), "markdown")
```
Leave-one-out Egger analysis - good to see if results are biased by single SNPS
- MR Egger assumes no measurement error as measurement error can lead to underestimation of the true causal effect
- To check for this, the I2 can be measured, which is an indication of measurement error annd is derived from the Cochran Q statistics
- if IR > 90%, then we do not need to worry about measurement error or bias by single SNPS
```r
DataMR_lonelinesstointernalising_leaveOut_egger<- mr_leaveoneout(DataMR_lonelinesstointernalising, method = mr_egger_regression) # Default: ivw method
DataMR_lonelinesstointernalising_leaveOut_egger
# Check max and min of the beta and the pvalue to see if any snp has changed them dramatically
out2 <- apply(DataMR_lonelinesstointernalising_leaveOut_egger[,c("b","p")], 2, function(x) {cbind(min(x), max(x))})
knitr::kable(as.data.frame(out2), "markdown") #doesnt seem that any SNP has had a dramatic effect

#Calculate baselines estimates on this new Egger dataset with weaker instruments
#Preliminary step: take only variants with smallest absolute effect sizes, if not (we have I2 >99%) and no correction needed
#First, select variants with the weaker betas
DataMR_lonelinesstointernalisingk <- DataMR_lonelinesstointernalising[abs(DataMR_lonelinesstointernalising$beta.exposure) < quantile(abs(DataMR_lonelinesstointernalising$beta.exposure), 0.20), ] 
#Second, take out instruments excluded in  TwoSampleMR
DataMR_lonelinesstointernalisingk_keep <- DataMR_lonelinesstointernalisingk[DataMR_lonelinesstointernalisingk$mr_keep == "TRUE", ] 
length(DataMR_lonelinesstointernalisingk_keep$SNP) # 25 variants selected. Note that a very small number for MR Egger (e.g. 8) yield completely unstable estimates.

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

#
#Calculate I2 (I squared) - include all instruments
(isqldl <- Isq(y = DataMR_lonelinesstointernalisingk$beta.exposure, s = DataMR_lonelinesstointernalisingk$se.exposure))# Very high (95.6%) many strong variants, so not much to correct for

#Calculate I2 (I squared) - include only weak instruments
(isqldl_w <- Isq(DataMR_lonelinesstointernalisingk$beta.exposure/DataMR_lonelinesstointernalisingk$se.outcome, DataMR_lonelinesstointernalisingk$se.exposure/DataMR_lonelinesstointernalisingk$se.outcome))# Very close
# Despite weaker variant, I2 is high (95.8%) so really no problem of weak instrument
```

### MR Steiger
- this tests whether the directionality we have specified is correct
- it does this by comparing the independent correlations to see if they are statistically different and, if so, to what degree they statistically differ
- The test calculates the variance explained in the exposure and the outcome by the instrumenting SNPs, and tests if the variance in the outcome is less than the exposure
```r
#Run MR-Steiger
DataMR_lonelinesstointernalising_Steiger <- directionality_test(DataMR_lonelinesstointernalising)
DataMR_lonelinesstointernalising_Steiger #says correct causal direction and highly sig (loneliness to internalising)

# We can apply the test on one SNP
DataMR_lonelinesstointernalising_Steiger <- directionality_test(DataMR_lonelinesstointernalising[1, ])
# As can be seen the r2 for the exposure is much bigger than for the outcome
DataMR_lonelinesstointernalising_Steiger$snp_r2.exposure/DataMR_lonelinesstointernalising_Steiger$snp_r2.outcome #effect on the exposure 48.7 times bigger

#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(DataMR_lonelinesstointernalising)[1], ncol = 8) 
for (i in 1:dim(DataMR_lonelinesstointernalising)[1]){
  temp  <- directionality_test(DataMR_lonelinesstointernalising[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_lonelinesstointernalising_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")

table(SteigerSNPs$correct_causal_direction) # all SNPS valid instruments

#direct calculation of r
DataMR_lonelinesstointernalising$r.exposure =
  get_r_from_pn(n = DataMR_lonelinesstointernalising$samplesize.exposure,
                p = DataMR_lonelinesstointernalising$pval.exposure)

DataMR_lonelinesstointernalising$r.outcome =
  get_r_from_pn(n = 184305,
                p = DataMR_lonelinesstointernalising$pval.outcome)
#and recalculate Steiger
SteigerSNPs1 = matrix(nrow = dim(DataMR_lonelinesstointernalising)[1],ncol = 8) 
for (i in 1:dim(DataMR_lonelinesstointernalising)[1]){
  temp  <- directionality_test(DataMR_lonelinesstointernalising[i, ])
  SteigerSNPs1[i, ] = as.matrix(temp)
}

SteigerSNPs1 = as.data.frame(SteigerSNPs1)
names(SteigerSNPs1) = names(DataMR_lonelinesstointernalising_Steiger)  
table(SteigerSNPs1$correct_causal_direction) # most SNPS valid instruments
head(SteigerSNPs1)
# As expected, these are identical as we are just using the internal function used by directionality_test() to calculate r
identical(SteigerSNPs$steiger_pval, SteigerSNPs1$steiger_pval) #NOT IDENTICAL

DataMR_lonelinesstointernalising$r.outcome =
  get_r_from_lor(lor = DataMR_lonelinesstointernalising$beta.outcome,
                 af = DataMR_lonelinesstointernalising$eaf.outcome,
                 ncase = 60801,
                 ncontrol = 123504,
                 prevalence = 0.05, #They assume prevalence of 5% in the paper
                 model = "logit",
                 correction = FALSE)

#and recalculate appropriate Steiger
SteigerSNPs2 = matrix(nrow =dim(DataMR_lonelinesstointernalising)[1],ncol = 8) 
for (i in 1:dim(DataMR_lonelinesstointernalising)[1]){
  temp  <- directionality_test(DataMR_lonelinesstointernalising[i, ])
  SteigerSNPs2[i, ] = as.matrix(temp)
}

SteigerSNPs2 = as.data.frame(SteigerSNPs2)
names(SteigerSNPs2) = names(DataMR_lonelinesstointernalising_Steiger)  
table(SteigerSNPs2$correct_causal_direction)
head(SteigerSNPs2)
# no change in validity of instruments though

DataMR_lonelinesstointernalising$correct_causal_direction <- SteigerSNPs2$correct_causal_direction # integrate the correct_causal_direction column into DataMR
DataMR_lonelinesstointernalising_Steigerfiltered <- DataMR_lonelinesstointernalising[DataMR_lonelinesstointernalising$correct_causal_direction == "TRUE",] #create DataMR only with those SNPs
dim(DataMR_lonelinesstointernalising_Steigerfiltered) #check that number of rows matches
# Redo MR with Steiger 
(MR_lonelinesstointernalising_Steigerfiltered <- mr(DataMR_lonelinesstointernalising_Steigerfiltered))
knitr::kable(MR_lonelinesstointernalising_Steigerfiltered, "markdown") 
#the results of the steiger filtered MR are extremely similar to the original MR
```

### Plots
- Produces a SNP forest plot 
- Produces a scatterplot comparing MR Egger and Inverse Median Weighted
- These plots can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/MR%20Loneliness%20against%20Internalising.md).
```r
#Create forest plot
#Pick the different methods that you want to compare
MR_lonelinesstointernalising_IVW_Egger_single <- mr_singlesnp(DataMR_lonelinesstointernalising, all_method = c("mr_ivw","mr_egger_regression", "mr_weighted_median", "mr_weighted_mode"))
MR_lonelinesstointernalising_forest <- mr_forest_plot(MR_lonelinesstointernalising_IVW_Egger_single)
MR_lonelinesstointernalising_forest[[1]]

#Create scatter plot
MR_lonelinesstointernalising_IVW_Egger <- mr(DataMR_lonelinesstointernalising, method_list = c("mr_egger_regression", "mr_ivw"))
MR_lonelinesstointernalising_IVW_Egger_scatter <- mr_scatter_plot(MR_lonelinesstointernalising_IVW_Egger, DataMR_lonelinesstointernalising)
MR_lonelinesstointernalising_IVW_Egger_scatter[[1]]
```
