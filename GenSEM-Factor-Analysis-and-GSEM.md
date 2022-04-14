---
title: "GenSEM Factor Analysis"
author: "Ellen Martin"
date: "11/02/2022"
output:
  html_document: 
    keep_md: yes
  pdf_document: default
---

## GenSEM Factor Analyisis

Factor Analysis:
- exploratory factor analysis on no_loneliness_odd

- confirmatory factor analysis on no_loneliness_even

- selection of the best fitting model

- Specification of GenomicSEM model with loneliness, based on best-fitting factor structure

##Setting WD's and Getting Libraries


```r
setwd("C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2") #setting WD locally

#libraries
library(Matrix) #for smoothing the data
library(GenomicSEM) #for confirmatory factor analysis
```

```
## Warning: replacing previous import 'gdata::nobs' by 'lavaan::nobs' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'gdata::last' by 'data.table::last' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'gdata::first' by 'data.table::first' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'gdata::env' by 'R.utils::env' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'gdata::resample' by 'R.utils::resample' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'data.table::last' by 'dplyr::last' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::summarize' by 'dplyr::summarize' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::mutate' by 'dplyr::mutate' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::id' by 'dplyr::id' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::arrange' by 'dplyr::arrange' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::summarise' by 'dplyr::summarise' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'data.table::first' by 'dplyr::first' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::rename' by 'dplyr::rename' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::desc' by 'dplyr::desc' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::count' by 'dplyr::count' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'gdata::combine' by 'dplyr::combine' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'data.table::between' by 'dplyr::between'
## when loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'plyr::failwith' by 'dplyr::failwith' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'Matrix::tail' by 'utils::tail' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'Rcpp::.DollarNames' by 'utils::.DollarNames'
## when loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'Rcpp::prompt' by 'utils::prompt' when
## loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'Matrix::head' by 'utils::head' when loading
## 'GenomicSEM'
```

```
## Warning: replacing previous import 'R.utils::timestamp' by 'utils::timestamp'
## when loading 'GenomicSEM'
```

```
## Warning: replacing previous import 'gdata::object.size' by 'utils::object.size'
## when loading 'GenomicSEM'
```

```r
library(psych) #for factor analysis
library(factoextra) #for factor analysis
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'ggplot2'
```

```
## The following objects are masked from 'package:psych':
## 
##     %+%, alpha
```

```
## Welcome! Want to learn more? See two factoextra-related books at https://goo.gl/ve3WBa
```

```r
library(nFactors) #for factor analysis
```

```
## Loading required package: lattice
```

```
## 
## Attaching package: 'nFactors'
```

```
## The following object is masked from 'package:lattice':
## 
##     parallel
```

```r
#data
load("no_loneliness_odd.RData")

#smoothing the data
covstruc <- no_loneliness_odd$S #taking the S-matrix from the LDSC output
corrstruc <- cov2cor(covstruc) #converting to a correlation matrix for factor analysis
corrstruc_smooth <- as.matrix((nearPD(corrstruc))$mat) #smoothing the correlation matrix to nearest positive definite
```

## Scree Plot

Using a scree plot and eigenvalues to suggest the number of factors to retain.


```r
ev <- eigen(corrstruc_smooth) # get eigenvalues
ap <- parallel(subject=nrow(corrstruc_smooth),var=ncol(corrstruc_smooth),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS) #plots scree
```

![](GenSEM-Factor-Analysis-and-GSEM_files/figure-html/scree-1.png)<!-- -->

```r
#alternate visualisation of scree plot
res.pca <- prcomp(corrstruc_smooth, scale = TRUE)
screeplot(res.pca, type = "lines")
```

![](GenSEM-Factor-Analysis-and-GSEM_files/figure-html/scree-2.png)<!-- -->

```r
fviz_eig(res.pca)
```

![](GenSEM-Factor-Analysis-and-GSEM_files/figure-html/scree-3.png)<!-- -->

```r
get_eigenvalue(res.pca) 
```

```
##          eigenvalue variance.percent cumulative.variance.percent
## Dim.1  3.754844e+00     3.754844e+01                    37.54844
## Dim.2  2.971890e+00     2.971890e+01                    67.26734
## Dim.3  1.761867e+00     1.761867e+01                    84.88601
## Dim.4  8.927902e-01     8.927902e+00                    93.81391
## Dim.5  2.357226e-01     2.357226e+00                    96.17114
## Dim.6  1.636524e-01     1.636524e+00                    97.80766
## Dim.7  1.281094e-01     1.281094e+00                    99.08875
## Dim.8  8.061644e-02     8.061644e-01                    99.89492
## Dim.9  1.050815e-02     1.050815e-01                   100.00000
## Dim.10 8.130471e-33     8.130471e-32                   100.00000
```

```r
fviz_screeplot(res.pca)
```

![](GenSEM-Factor-Analysis-and-GSEM_files/figure-html/scree-4.png)<!-- -->

```r
#suggests the retention of 1-4 factors
```

## Exploratory Factor Analysis

Conducted specifying 1 - 4 factors to retain.


```r
#1 factor
fit1 <- fa(corrstruc_smooth, nfactors = 1, rotate = "promax", fm = "uls")
fit1$loadings
```

```
## 
## Loadings:
##      ULS1 
## ADHD 0.721
## ALC       
## ANX  0.601
## ASD  0.349
## BIP  0.371
## CAN  0.703
## MDD  0.720
## PTSD 0.881
## SCZ  0.468
## SMK  0.630
## 
##                 ULS1
## SS loadings    3.551
## Proportion Var 0.355
```

```r
#factor structure
# 'F1 =~ ADHD + CAN + PTSD + SMK + MDD
#  F2 =~ ANX + BIP + MDD + SCZ


#2 factor
fit2 <- fa(corrstruc_smooth, nfactors = 2, rotate = "promax", fm = "uls")
```

```
## Loading required namespace: GPArotation
```

```r
fit2$loadings
```

```
## 
## Loadings:
##      ULS1   ULS2  
## ADHD  0.907       
## ALC   0.129       
## ANX   0.286  0.431
## ASD   0.192  0.221
## BIP  -0.253  0.844
## CAN   0.618  0.174
## MDD   0.389  0.459
## PTSD  0.762  0.226
## SCZ  -0.125  0.820
## SMK   0.708       
## 
##                 ULS1  ULS2
## SS loadings    2.653 1.925
## Proportion Var 0.265 0.193
## Cumulative Var 0.265 0.458
```

```r
#factor structure
# 'F1 =~ ADHD + CAN + PTSD + SMK + MDD
#  F2 =~ ANX + BIP + MDD + SCZ


#3 factor
fit3 <- fa(corrstruc_smooth, nfactors = 3, rotate = "promax", fm = "uls")
fit3$loadings
```

```
## 
## Loadings:
##      ULS1   ULS3   ULS2  
## ADHD  0.766  0.293 -0.291
## ALC  -0.209  0.413       
## ANX   0.545         0.201
## ASD   0.390              
## BIP                 0.780
## CAN   0.232  0.803  0.171
## MDD   0.777 -0.126  0.157
## PTSD  0.945        -0.106
## SCZ          0.131  0.759
## SMK   0.332  0.659       
## 
##                 ULS1  ULS3  ULS2
## SS loadings    2.746 1.388 1.385
## Proportion Var 0.275 0.139 0.139
## Cumulative Var 0.275 0.413 0.552
```

```r
#factor structure
# 'F1 =~ ADHD + ANX + ASD + MDD + PTSD
#  F2 =~ ALC + CAN + SMK
#  F3 =~ BIP + SCZ


#4 factor

fit4 <- fa(corrstruc_smooth, nfactors = 4, rotate="promax", fm = "uls")
```

```
## Warning in fa.stats(r = r, f = f, phi = phi, n.obs = n.obs, np.obs = np.obs, :
## The estimated weights for the factor scores are probably incorrect. Try a
## different factor score estimation method.
```

```r
fit4$loadings
```

```
## 
## Loadings:
##      ULS1   ULS4   ULS2   ULS3  
## ADHD  0.885        -0.224  0.264
## ALC         -0.126         0.398
## ANX  -0.215  1.107              
## ASD   0.510 -0.124  0.149 -0.137
## BIP          0.107  0.668       
## CAN   0.115  0.168  0.129  0.810
## MDD   0.338  0.537              
## PTSD  0.884                     
## SCZ                 0.934  0.118
## SMK   0.236  0.131         0.672
## 
##                 ULS1  ULS4  ULS2  ULS3
## SS loadings    2.072 1.622 1.425 1.382
## Proportion Var 0.207 0.162 0.143 0.138
## Cumulative Var 0.207 0.369 0.512 0.650
```

```r
#factor structure
# 'F1 =~ ADHD + ASD + MDD + PTSD
#  F2 =~ ANX + MDD
#  F3 =~ BIP + SCZ
#  F4 =~ ALC + CAN + SMK
```

## Confirmatory Factor Analysis

Conducted using GenomicSEM, using the EVEN data to prevent overfitting
- Results suggest that a 3 factor solution achieves the best fit


```r
setwd("C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2") #setting WD locally

load("no_loneliness_even.RData")

#1 factor (p-factor)

model1CFA <- 'F1 =~ NA*ADHD + ANX + ASD + MDD + PTSD + BIP + SCZ + CAN + SMK'
pfact<-usermodel(no_loneliness_even, estimation = "DWLS", model = model1CFA, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
## [1] "Calculating SRMR"
## elapsed 
##    2.59 
## [1] "The S matrix was smoothed prior to model estimation due to a non-positive definite matrix. The largest absolute difference in a cell between the smoothed and non-smoothed matrix was  0.00725703275851572 As a result of the smoothing, the largest Z-statistic change for the genetic covariances was  1.55294575366921 . We recommend setting the smooth_check argument to true if you are going to run a multivariate GWAS."
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model1CFA, : A difference greater than .025 was observed pre- and post-
## smoothing for Z-statistics in the genetic covariance matrix. This reflects a
## large difference and results should be interpreted with caution!! This can often
## result from including low powered traits, and you might consider removing those
## traits from the model. If you are going to run a multivariate GWAS we strongly
## recommend setting the smooth_check argument to true to check smoothing for each
## SNP.
```

```r
pfact$modelfit #0.15 SRMR, 0.76 CFI - poor fit
```

```
##       chisq df      p_chisq      AIC       CFI      SRMR
## df 336.2923 27 3.947636e-55 372.2923 0.7644647 0.1545144
```

```r
View(pfact$results)


#2 factor (bi-factor)

model2CFA <- 'F1 =~ NA*ADHD + CAN + PTSD + SMK + MDD
              F2 =~ NA*ANX + BIP + MDD + SCZ
'
fita<-usermodel(no_loneliness_even, estimation = "DWLS", model = model2CFA, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
## [1] "Calculating SRMR"
## elapsed 
##    1.79 
## [1] "The S matrix was smoothed prior to model estimation due to a non-positive definite matrix. The largest absolute difference in a cell between the smoothed and non-smoothed matrix was  0.00646004760582394 As a result of the smoothing, the largest Z-statistic change for the genetic covariances was  1.6333380233469 . We recommend setting the smooth_check argument to true if you are going to run a multivariate GWAS."
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model2CFA, : A difference greater than .025 was observed pre- and post-
## smoothing for Z-statistics in the genetic covariance matrix. This reflects a
## large difference and results should be interpreted with caution!! This can often
## result from including low powered traits, and you might consider removing those
## traits from the model. If you are going to run a multivariate GWAS we strongly
## recommend setting the smooth_check argument to true to check smoothing for each
## SNP.
```

```r
fita$modelfit #0.19 SRMR, 0.88 CFI - poor fit
```

```
##       chisq df      p_chisq      AIC       CFI      SRMR
## df 149.5153 18 9.231812e-23 185.5153 0.8819682 0.1908851
```

```r
View(fita$results)


#3 factor 
#smoking forced to one factor (F2)

model3CFA <- 'F1 =~ NA*ADHD + ANX + ASD + MDD + PTSD
              F2 =~ NA*ALC + CAN + SMK
              F3 =~ NA*BIP + SCZ
#correlations
              F1~~F2
              F1~~F3
              F2~~F3
#constraints
              CAN~~a*CAN 
              SCZ~~a*SCZ
              a > .001
'
fitb<-usermodel(no_loneliness_even, estimation = "DWLS", model = model3CFA, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
## [1] "Calculating SRMR"
## elapsed 
##    7.62 
## [1] "The S matrix was smoothed prior to model estimation due to a non-positive definite matrix. The largest absolute difference in a cell between the smoothed and non-smoothed matrix was  0.00725092094356261 As a result of the smoothing, the largest Z-statistic change for the genetic covariances was  1.54896439799155 . We recommend setting the smooth_check argument to true if you are going to run a multivariate GWAS."
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model3CFA, : A difference greater than .025 was observed pre- and post-
## smoothing for Z-statistics in the genetic covariance matrix. This reflects a
## large difference and results should be interpreted with caution!! This can often
## result from including low powered traits, and you might consider removing those
## traits from the model. If you are going to run a multivariate GWAS we strongly
## recommend setting the smooth_check argument to true to check smoothing for each
## SNP.
```

```
## [1] "Please note that when equality constraints are used in the current version of Genomic SEM that the standardized output will also impose the same constraint."
```

```r
fitb$modelfit #CFI # .93, SRMR = .10 - acceptable fit
```

```
##       chisq df      p_chisq      AIC       CFI      SRMR
## df 139.4249 33 4.868991e-15 183.4249 0.9274874 0.1047666
```

```r
View(fitb$results)
#write.csv(fitb$results, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2\\CFA3.csv", row.names = TRUE)



#alternate 3 factor
#smoking on both F1 and F2

model3bCFA <- 'F1 =~ NA*ADHD + ANX + ASD + MDD + PTSD + SMK
               F2 =~ NA*ALC + CAN + SMK
               F3 =~ NA*BIP + SCZ

               F1~~F2
               F1~~F3
               F2~~F3

               CAN~~a*CAN
               a > .001
'
fitb2<-usermodel(no_loneliness_even, estimation = "DWLS", model = model3bCFA, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
```

```
## Warning in sqrt(1/diag(V)): NaNs produced
```

```
## Warning in cov2cor(Sigma.hat): diag(.) had 0 or NA entries; non-finite result is
## doubtful
```

```
## Warning in sqrt(1/diag(V)): NaNs produced
```

```
## Warning in cov2cor(Sigma.hat): diag(.) had 0 or NA entries; non-finite result is
## doubtful
```

```
## [1] "Calculating SRMR"
```

```
## Warning in sqrt(1/diag(V)): NaNs produced

## Warning in sqrt(1/diag(V)): diag(.) had 0 or NA entries; non-finite result is
## doubtful
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model3bCFA, : CFI estimates below 0 should not be trusted, and indicate that
## the other model fit estimates should be interpreted with caution. A negative CFI
## estimates typically appears due to negative residual variances.
```

```
## elapsed 
##    7.47 
## [1] "The S matrix was smoothed prior to model estimation due to a non-positive definite matrix. The largest absolute difference in a cell between the smoothed and non-smoothed matrix was  0.00725092094356261 As a result of the smoothing, the largest Z-statistic change for the genetic covariances was  1.54896439799155 . We recommend setting the smooth_check argument to true if you are going to run a multivariate GWAS."
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model3bCFA, : A difference greater than .025 was observed pre- and post-
## smoothing for Z-statistics in the genetic covariance matrix. This reflects a
## large difference and results should be interpreted with caution!! This can often
## result from including low powered traits, and you might consider removing those
## traits from the model. If you are going to run a multivariate GWAS we strongly
## recommend setting the smooth_check argument to true to check smoothing for each
## SNP.
```

```r
fitb2$modelfit #CFI # .93, SRMR = .10 - similar fit, so the first 3 factor solution is still better because it is more parismonious and aligns better with existing theory
```

```
##      chisq df p_chisq     AIC       CFI     SRMR
## df 1141880 31       0 1141928 -769.7565 7.615717
```

```r
View(fitb2$results)


#4 factor

model4CFA <-  'F1 =~ NA*ADHD + ASD + MDD + PTSD
               F2 =~ NA*ANX + MDD
               F3 =~ NA*BIP + SCZ
               F4 =~ NA*ALC + CAN + SMK

               F1 ~~ F2
               F1 ~~ F4
               F1 ~~ F3
               F2 ~~ F3
               F2 ~~ F4
               F3 ~~ F4

               CAN~~a*CAN
               MDD~~a*MDD
               a > .001
'
fitc<-usermodel(no_loneliness_even, estimation = "DWLS", model = model4CFA, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
```

```
## Warning in sqrt(1/diag(V)): NaNs produced
```

```
## Warning in cov2cor(Sigma.hat): diag(.) had 0 or NA entries; non-finite result is
## doubtful
```

```
## Warning in sqrt(1/diag(V)): NaNs produced
```

```
## Warning in cov2cor(Sigma.hat): diag(.) had 0 or NA entries; non-finite result is
## doubtful
```

```
## [1] "Calculating SRMR"
```

```
## Warning in sqrt(1/diag(V)): NaNs produced

## Warning in sqrt(1/diag(V)): diag(.) had 0 or NA entries; non-finite result is
## doubtful
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model4CFA, : CFI estimates below 0 should not be trusted, and indicate that the
## other model fit estimates should be interpreted with caution. A negative CFI
## estimates typically appears due to negative residual variances.
```

```
## elapsed 
##    6.83 
## [1] "The S matrix was smoothed prior to model estimation due to a non-positive definite matrix. The largest absolute difference in a cell between the smoothed and non-smoothed matrix was  0.00725092094356261 As a result of the smoothing, the largest Z-statistic change for the genetic covariances was  1.54896439799155 . We recommend setting the smooth_check argument to true if you are going to run a multivariate GWAS."
```

```
## Warning in usermodel(no_loneliness_even, estimation = "DWLS", model =
## model4CFA, : A difference greater than .025 was observed pre- and post-
## smoothing for Z-statistics in the genetic covariance matrix. This reflects a
## large difference and results should be interpreted with caution!! This can often
## result from including low powered traits, and you might consider removing those
## traits from the model. If you are going to run a multivariate GWAS we strongly
## recommend setting the smooth_check argument to true to check smoothing for each
## SNP.
```

```
## [1] "Please note that when equality constraints are used in the current version of Genomic SEM that the standardized output will also impose the same constraint."
```

```r
fitc$modelfit #0.14 SRMR, 0.96 CFI - poor fit
```

```
##       chisq df p_chisq      AIC       CFI     SRMR
## df 908593.4 29       0 908645.4 -612.2881 7.479126
```

```r
View(fitc$results)
```

##GenomicSEM with Loneliness
- specifying both a multivariate (adjusted) and non-adjusted model


```r
setwd("C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2") #setting WD locally

load("combined_covstruc.RData") #full ldsc data set used

#multivariate (adjusted), constrained model
multivar_constrained<- '
#specifying factor structure
                        F1 =~ NA*ADHD + ANX + ASD + PTSD + MDD
                        F2 =~ NA*ALC + CAN + SMK
                        F3 =~ NA*BIP + SCZ
                        
#regressed with lonelineliness, constrained to 0 for F2 and F3 because non-constrained output showed negative factor loadings from F2 and F3 to loneliness.
                        LONELINESS ~ F1 + 0*F2 + 0*F3

                        F1 ~~ F2 + F3
                        F2 ~~ F3
'

fit1constr<-usermodel(combined_covstruc, estimation = "DWLS", model = multivar_constrained, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
## [1] "Calculating SRMR"
## elapsed 
##     5.5
```

```r
View(fit1constr$results) 
fit1constr$modelfit #SRMR = .10, CFI = .94 - poorer fit than unconstrained multivar, but slightly acceptable still
```

```
##       chisq df     p_chisq      AIC       CFI       SRMR
## df 387.4599 41 5.98959e-58 437.4599 0.9354812 0.09849712
```

```r
#multivar model constrained and latent indicator for lone
multivar_constrained_latent<- 'F1 =~ NA*ADHD + ANX + ASD + PTSD + MDD
                               F2 =~ NA*ALC + CAN + SMK
                               F3 =~ NA*BIP + SCZ

#latent indicator for loneliness
                               LONE =~ LONELINESS
                               LONE~~1*LONE
                               LONELINESS~~0*LONELINESS

#with constraints
                               LONE ~ F1 + 0*F2 + 0*F3

                               F1 ~~ F2 + F3
                               F2 ~~ F3
'

fit1constrlatent<-usermodel(combined_covstruc, estimation = "DWLS", model = multivar_constrained_latent, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
## [1] "Calculating SRMR"
## elapsed 
##    4.61
```

```r
View(fit1constrlatent$results) 
fit1constrlatent$modelfit #same fit
```

```
##       chisq df      p_chisq      AIC       CFI       SRMR
## df 387.4601 41 5.989008e-58 437.4601 0.9354812 0.09849714
```

```r
#write.csv(fit1constrlatent$results, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2\\multivarconstrlatent.csv", row.names = TRUE)



#unadjusted model
unadjusted_model<- 'F1 =~ NA*ADHD + ANX + ASD + PTSD + MDD
                    F2 =~ NA*ALC + CAN + SMK
                    F3 =~ NA*BIP + SCZ

#latent indicator for loneliness
                               LONE =~ LONELINESS
                               LONE~~1*LONE
                               LONELINESS~~0*LONELINESS

#with constraints
                               LONE ~~ F1 + F2 + F3
                            
'

fit2unadj<-usermodel(combined_covstruc, estimation = "DWLS", model = unadjusted_model, CFIcalc = TRUE, std.lv = TRUE)
```

```
## [1] "Running primary model"
## [1] "Calculating model chi-square"
## [1] "Calculating CFI"
## [1] "Calculating Standardized Results"
## [1] "Calculating SRMR"
## elapsed 
##    3.56
```

```r
View(fit2unadj$results) 
fit2unadj$modelfit
```

```
##       chisq df      p_chisq      AIC       CFI       SRMR
## df 319.2259 39 1.116823e-45 373.2259 0.9478155 0.09417271
```

```r
#write.csv(fit2unadj$results, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2\\fit2unadj.csv", row.names = TRUE)
```

