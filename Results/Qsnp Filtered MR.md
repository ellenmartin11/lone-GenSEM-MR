# Q SNP Filtered Mendelian Randomization Results 

- for these MR analyses, F1 was filtered so that only Q_chisq_pval < 5e-8 were retained
- this ensures that effects from F1 to Loneliness operate only via F1 
- this gives the instruments from F1 to loneliness more credibility

## Loneliness to F1
- this uses 16 SNPs only (and specifies a p-value threshold of 5e-5 because there were not a sufficient number of instruments at genome-wide significance)

### Main MR Analyses

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |MR Egger                  |   16| 0.5698163| 1.8641771| 0.7643564|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Inverse variance weighted |   16| 0.6108896| 0.2185743| 0.0051918|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Weighted mode             |   16| 0.8993511| 0.1213076| 0.0000022|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Weighted median           |   16| 0.8495829| 0.1188160| 0.0000000|

- MR results show consistency in IVW, weighted mode and weighted median, but not Egger

### Heterogeneity Test

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|------:|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |MR Egger                  | 67.57216|   16|      0|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Inverse variance weighted | 67.89847|   17|      0|

- significant, so we have to refer to Egger, which was not significant
- these findings suggest that Loneliness does causally influence F1 (based on original, non QSnp filtered results), and through means other than F1

### Pleiotropy Test

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |      -0.0012567| 0.0045211| 0.7845966|

- not significant

### Test of Directionality

|id.exposure |id.outcome |exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|KxQuhO      |z8PzUM     |loneliness |F1_Qsnp |       0.0008378|      0.0008478|FALSE                    |    0.9372921|

- suggests incorrect direction of effect

### MR on Steiger Filtered SNPS

- runs MR only on SNPs in the correct causal direction

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |MR Egger                  |   12| 1.8126825| 2.0421222| 0.3955787|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Weighted median           |   12| 0.8029088| 0.1251320| 0.0000000|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Inverse variance weighted |   12| 0.4064990| 0.2430383| 0.0944116|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Simple mode               |   12| 0.9034902| 0.1261929| 0.0000185|
|KxQuhO      |z8PzUM     |F1_Qsnp |loneliness |Weighted mode             |   12| 0.8583766| 0.1164716| 0.0000141|

- IVW is no longer significant, suggests F1 to Lone may be the correct direction

### Steiger Forest Plot

![image](https://user-images.githubusercontent.com/68326791/175924525-88681ba1-accc-4747-a832-264fea391859.png)

## F1 to Loneliness

### Main MR Analyses

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |MR Egger                  |   18| 0.3301514| 0.2588163| 0.2202993|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Inverse variance weighted |   18| 0.2604654| 0.0625467| 0.0000312|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Weighted mode             |   18| 0.3801725| 0.0666539| 0.0000259|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Weighted median           |   18| 0.3461761| 0.0488614| 0.0000000|

- all significant except egger

### Heterogeneity Test

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|------:|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |MR Egger                  | 67.57216|   16|      0|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Inverse variance weighted | 67.89847|   17|      0|

- significant, so should refer to Egger which was not significant
- based on this, there is stronger evidence of a direction from Loneliness to F1, than for F1 (Qsnp filtered) to Loneliness

### Pleiotropy Test

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |      -0.0012567| 0.0045211| 0.7845966|

- no evidence of pleiotropy

### Directionality Test

|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|10j7vD      |9gZFSZ     |F1_Qsnp  |loneliness |       0.0018364|      0.0003635|TRUE                     |            0|

### MR Steiger

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |MR Egger                  |   18| 0.3301514| 0.2588163| 0.2202993|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Weighted median           |   18| 0.3461761| 0.0508044| 0.0000000|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Inverse variance weighted |   18| 0.2604654| 0.0625467| 0.0000312|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Simple mode               |   18| 0.3801725| 0.0756760| 0.0001043|
|10j7vD      |9gZFSZ     |loneliness |F1_Qsnp  |Weighted mode             |   18| 0.3801725| 0.0688395| 0.0000373|

- same as original MR, because all SNPs were in correct causal direction

### Forest Plot (Steiger SNPs)

![image](https://user-images.githubusercontent.com/68326791/175925886-79faf09b-57a6-4751-a6d9-da5a892f0baa.png)
