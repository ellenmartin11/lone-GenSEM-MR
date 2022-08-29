

## GenSEM Factor Analyisis

Factor Analysis:
- exploratory factor analysis on no_loneliness_odd

- confirmatory factor analysis on no_loneliness_even

- selection of the best fitting model

- Specification of GenomicSEM model with loneliness, based on best-fitting factor structure

- Path diagrams were manually generated using PowerPoint

Setting WD's and Getting Libraries


```r
setwd("C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2") #setting WD locally

#libraries
library(Matrix) #for smoothing the data
library(GenomicSEM) #for confirmatory factor analysis
```


```r
library(psych) #for factor analysis
library(factoextra) #for factor analysis
```

```r
library(nFactors) #for factor analysis
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
![image](https://user-images.githubusercontent.com/68326791/163401518-4c1be344-a44c-4290-972b-7014cd2278b3.png)


```r
#alternate visualisation of scree plot
res.pca <- prcomp(corrstruc_smooth, scale = TRUE)
screeplot(res.pca, type = "lines")
```

![](GenSEM-Factor-Analysis-and-GSEM_files/figure-html/scree-2.png)<!-- -->
![image](https://user-images.githubusercontent.com/68326791/163401691-763a73cd-f12b-4409-816c-3acee8fed2e0.png)


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

### 1 factor
```r

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
### 2 factor
```r

fit2 <- fa(corrstruc_smooth, nfactors = 2, rotate = "promax", fm = "uls")
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
F1 =~ ADHD + CAN + PTSD + SMK + MDD

F2 =~ ANX + BIP + MDD + SCZ


### 3 factor

```
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
F1 =~ ADHD + ANX + ASD + MDD + PTSD

F2 =~ ALC + CAN + SMK

F3 =~ BIP + SCZ


### 4 factor
```r

fit4 <- fa(corrstruc_smooth, nfactors = 4, rotate="promax", fm = "uls")
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
F1 =~ ADHD + ASD + MDD + PTSD

F2 =~ ANX + MDD

F3 =~ BIP + SCZ

F4 =~ ALC + CAN + SMK

## Confirmatory Factor Analysis

Conducted using GenomicSEM, using the EVEN data to prevent overfitting
- Results suggest that a 3 factor solution achieves the best fit
```r
setwd("C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2") #setting WD locally

load("no_loneliness_even.RData")
```
### 1 factor (p-factor)
```
model1CFA <- 'F1 =~ NA*ADHD + ANX + ASD + MDD + PTSD + BIP + SCZ + CAN + SMK'
pfact<-usermodel(no_loneliness_even, estimation = "DWLS", model = model1CFA, CFIcalc = TRUE, std.lv = TRUE)
```

```r
pfact$modelfit 
View(pfact$results)
##       chisq df      p_chisq      AIC       CFI      SRMR
## df 336.2923 27 3.947636e-55 372.2923 0.7644647 0.1545144
```
- 0.15 SRMR and 0.76 CFI suggests poor fit

### 2 factor (bi-factor)
```

model2CFA <- 'F1 =~ NA*ADHD + CAN + PTSD + SMK + MDD
              F2 =~ NA*ANX + BIP + MDD + SCZ
'
fita<-usermodel(no_loneliness_even, estimation = "DWLS", model = model2CFA, CFIcalc = TRUE, std.lv = TRUE)

fita$modelfit 
View(fita$results)

##       chisq df      p_chisq      AIC       CFI      SRMR
## df 149.5153 18 9.231812e-23 185.5153 0.8819682 0.1908851
```
- 0.19 SRMR and 0.88 CFI suggests poor fit


### 3 factor 
smoking forced to one factor (F2)
```r

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
fitb$modelfit 
View(fitb$results)
#write.csv(fitb$results, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2\\CFA3.csv", row.names = TRUE)

##       chisq df      p_chisq      AIC       CFI      SRMR
## df 139.4249 33 4.868991e-15 183.4249 0.9274874 0.1047666
```
- CFI = .93 and SRMR = .10 suggests acceptable fit, so this will be the selected 3 factor model

- the full 3 factor CFA output can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/CFA3factOutput.csv)



### alternate 3 factor
smoking on both F1 and F2
```r
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
fitb2$modelfit 
View(fitb2$results)

##      chisq df p_chisq     AIC       CFI     SRMR
## df 1141880 31       0 1141928 -769.7565 7.615717
```
- poor fit
### 4 factor
```r

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

fitc$modelfit 
View(fitc$results)

##       chisq df p_chisq      AIC       CFI     SRMR
## df 908593.4 29       0 908645.4 -612.2881 7.479126
```
- incredibly poor fit


## GenomicSEM with Loneliness
- specifying both a multivariate (adjusted) and non-adjusted model
- in these models, F1 refers to the latent factor for neurodevelopmental and mood disorders (NMD), F2 refers to the latent factor for substance use traits (SUT) and F3 refers to the latent factor for disorders with psychotic features (DPF).
### multivariate (adjusted) model

```r
setwd("C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2") #setting WD locally

load("combined_covstruc.RData") #full ldsc data set used

multivarlatent<- 'F1 =~ NA*ADHD + ANX + ASD + PTSD + MDD
                               F2 =~ NA*ALC + CAN + SMK
                               F3 =~ NA*BIP + SCZ

#latent indicator for loneliness
                               LONE =~ LONELINESS
                               LONE~~1*LONE
                               LONELINESS~~0*LONELINESS

#regressions with LONE and multivar adjustment
                               LONE ~ F1 + F2 + F3

                               F1 ~~ F2 + F3
                               F2 ~~ F3
'

fit1constrlatent<-usermodel(combined_covstruc, estimation = "DWLS", model = multivarlatent, CFIcalc = TRUE, std.lv = TRUE)
View(fit1constrlatent$results) 
```

```r
View(fit1constrlatent$results) 
fit1constrlatent$modelfit #SRMR = .10, CFI = .94 
```
- usermodel results can be found [here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/multivarlatent.csv)

### multivar model constrained and latent indicator for lone

```r
multivar_constrained_latent<- 'F1 =~ NA*ADHD + ANX + ASD + PTSD + MDD
                               F2 =~ NA*ALC + CAN + SMK
                               F3 =~ NA*BIP + SCZ

#latent indicator for loneliness
                               LONE =~ LONELINESS
                               LONE~~1*LONE
                               LONELINESS~~0*LONELINESS

#with constraints
                               LONE ~ F1 + 0*F2 + 0*F3 #constrained to 0 to check for potential over-inflation of positive association between LONE and F1

                               F1 ~~ F2 + F3
                               F2 ~~ F3
'

fit1constrlatent<-usermodel(combined_covstruc, estimation = "DWLS", model = multivar_constrained_latent, CFIcalc = TRUE, std.lv = TRUE)
```


```r
View(fit1constrlatent$results) 
fit1constrlatent$modelfit 

##       chisq df     p_chisq      AIC       CFI       SRMR
## df 387.4599 41 5.98959e-58 437.4599 0.9354812 0.09849712

#write.csv(fit1constrlatent$results, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2\\multivar-latent-constr-SUPP.csv", row.names = TRUE)

```
Full usermodel results can be found [here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/multivar-latent-constr.csv)
This is the model on which the multivariate GWA is specified in the next stage of analysis, as F1 (NMD) is the only latent genetic factor of interest.

![image](https://user-images.githubusercontent.com/68326791/168543083-e44c704c-6193-4237-b8d0-48fe05fbc9c8.png)

### unadjusted model

```r



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

```r
View(fit2unadj$results) 
fit2unadj$modelfit
#write.csv(fit2unadj$results, file = "C:\\Users\\ellen\\OneDrive\\BSc Psych\\Publication Genetics\\GSEM2\\GSEMUnadjModelSUPP.csv", row.names = TRUE)
```
Full usermodel results are shown [here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/GSEMUnadjModelSUPP.csv)

```
##       chisq df      p_chisq      AIC       CFI       SRMR
## df 319.2259 39 1.116823e-45 373.2259 0.9478155 0.09417271
```
![image](https://user-images.githubusercontent.com/68326791/163406898-9713ed93-6ef6-499a-b00f-5d170f816752.png)


