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

### Mendelian Randomization
- Results can be found Here.
```r
#running MR
(MR_lonelinesstointernalising <- mr(DataMR_lonelinesstointernalising))
knitr::kable(as.data.frame(MR_lonelinesstointernalising), "markdown")

#Sensitivity Analyses
#Cochran Q statistics
Results_lonelinesstointernalising_heterogeneity <- mr_heterogeneity(DataMR_lonelinesstointernalising)
Results_lonelinesstointernalising_heterogeneity 

#Pleiotropy test
Results_lonelinesstointernalising_pleiotropy <- mr_pleiotropy_test(DataMR_lonelinesstointernalising)
Results_lonelinesstointernalising_pleiotropy #just non sig, suggesting that results are unlikely to be  driven by pleiotropy, IVW is fine, but so is Egger
knitr::kable(as.data.frame(Results_lonelinesstointernalising_pleiotropy), "markdown")

# Leave-one-out analysis - good to see if results are biased by single SNPS
DataMR_lonelinesstointernalising_leaveOut_egger<- mr_leaveoneout(DataMR_lonelinesstointernalising, method = mr_egger_regression) # Default: ivw method
DataMR_lonelinesstointernalising_leaveOut_egger

# Check max and min of the beta and the pvalue to see if any snp has changed them dramatically
out2 <- apply(DataMR_lonelinesstointernalising_leaveOut_egger[,c("b","p")], 2, function(x) {cbind(min(x), max(x))})
knitr::kable(as.data.frame(out2), "markdown") #doesnt seem that any SNP has had a dramatic effect
```

### MR Steiger
```r
#Run MR-Steiger
DataMR_lonelinesstointernalising_Steiger <- directionality_test(DataMR_lonelinesstointernalising)
DataMR_lonelinesstointernalising_Steiger #says correct causal direction and highly sig (loneliness to internalising)

#Loop over all SNPs
SteigerSNPs= matrix(nrow = dim(DataMR_lonelinesstointernalising)[1], ncol = 8) 
for (i in 1:dim(DataMR_lonelinesstointernalising)[1]){
  temp  <- directionality_test(DataMR_lonelinesstointernalising[i, ])
  SteigerSNPs[i, ] = as.matrix(temp)
}

SteigerSNPs <- as.data.frame(SteigerSNPs)
names(SteigerSNPs) <- names(DataMR_lonelinesstointernalising_Steiger)  
knitr::kable(head(SteigerSNPs), "markdown")
```

### Plots
- Produces a SNP forest plot 
- Produces a scatterplot comparing MR Egger and Inverse Median Weighted
- These plots can be found Here.
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
