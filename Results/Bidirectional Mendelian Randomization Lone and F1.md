

# Bidirectional MR

---

## loneliness to F1/NMD

F1 refers to the Neurodevelopmental and Mood Disorders latent factor (NMD)
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-08</sup>
- 11 instruments
---

### Results from two sample MR:

|outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   11|  0.5443916| 0.2789841| 8.28x10<sup>-02</sup>|
|F1      |loneliness |Inverse variance weighted |   11|  0.4956359| 0.0547951| 1.49x10<sup>-19</sup>|
|F1      |loneliness |Weighted mode             |   11|  0.5238836| 0.1343346| 2.96x10<sup>-03</sup>|
|F1      |loneliness |Weighted median           |   11|  0.4810642| 0.0803782| 2.16x10<sup>-09</sup>|
|F1      |loneliness |MR Egger (bootstrap)      |   11| -0.1618239| 0.3356590| 3.00x10<sup>-01</sup>|

- All methods except for Egger and Egger Boostrap are significant 
- Egger bootstrap is in the negative direction

### Heterogeneity tests

|id.exposure |id.outcome |outcome |exposure   |method                    |        Q| Q_df|    Q_pval|
|:-----------|:----------|:-------|:----------|:-------------------------|--------:|----:|---------:|
|zekZiO      |bCloOr     |F1      |loneliness |MR Egger                  | 8.840471|    9| 0.4521287|
|zekZiO      |bCloOr     |F1      |loneliness |Inverse variance weighted | 8.872238|   10| 0.5442702|

- since Q is low and not statistically significant, we can assume homogeneity and refer to IVW

### Test for directional horizontal pleiotropy


|id.exposure |id.outcome |outcome |exposure   | egger_intercept|        se|      pval|
|:-----------|:----------|:-------|:----------|---------------:|---------:|---------:|
|zekZiO      |bCloOr     |F1      |loneliness |      -0.0007018| 0.0039373| 0.8624872|

- test for pleiotropy suggests no horizontal pleiotropy



### Test that the loneliness exposure is upstream of the F1 outcome

|exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|loneliness |F1      |       0.0009896|      0.0002397|TRUE                     |4.87x10<sup>-13</sup>|

- Steiger directionality test suggests that we have the correct direction of causal effect from loneliness to F1

### MR Egger Sensitivity Test
|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   77| 1.4606595| 0.3571151| 1.07x10<sup>-04</sup>|
|F1      |loneliness |Inverse variance weighted |   77| 0.4687211| 0.0449261| 1.75x10<sup>-25</sup>|
|F1      |loneliness |Weighted mode             |   77| 0.6736313| 0.1070706| 1.84x10<sup>-08</sup>|
|F1      |loneliness |Weighted median           |   77| 0.5464386| 0.0363076| 3.44x10<sup>-51</sup>|
|F1      |loneliness |MR Egger (bootstrap)      |   77| 0.2411901| 0.1979520| 1.13x10<sup>-01</sup>|

- still significant and consistent across MR methods
- I2 of all instruments = .972, I2 of weaker instruments .972
- not suggestive of weak instrument bias
---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/198327856-a6862c01-ce57-4d14-9afa-c40d07eb6a67.png)

### Scatter Plot 

![image](https://user-images.githubusercontent.com/68326791/198328770-69c6ce2a-7ae7-457a-94fb-f38e0714d700.png)

---

### Steiger Filtering

- all SNPs were found to be operating in the correct causal direction
- so results of MR steiger are the same as normal MR

---

## F1/NMD to Loneliness
- now evaluates the effect of neurodevelopmental/mood disorders on loneliness
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-08</sup>
- 14 instruments
---

### Results from Two-Sample MR

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   14| -0.2495892| 0.4675338| 6.03x10<sup>-01</sup>|
|loneliness |F1       |Inverse variance weighted |   14|  0.2087931| 0.0983364| 3.37x10<sup>-02</sup>|
|loneliness |F1       |Weighted mode             |   14|  0.3570321| 0.0836802| 9.18x10<sup>-04</sup>|
|loneliness |F1       |Weighted median           |   14|  0.3232340| 0.0604615| 8.99x10<sup>-08</sup>|
|loneliness |F1       |MR Egger (bootstrap)      |   14| -0.2617346| 0.3267510| 1.98x10<sup>-01</sup>|

- consistency across MR methods excluding MR Egger and MR Egger bootstrap
- MR Egger and MR Egger bootstrap are both in the negative direction

### Heterogeneity Tests

|outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|------:|
|loneliness |F1       |MR Egger                  | 88.39920|   12|1.00x10<sup>-13</sup>|
|loneliness |F1       |Inverse variance weighted | 95.80784|   13|1.07x10<sup>-14</sup>|

- cannot assume homogeneity, there is evidence of heterogeneity

### Test for directional horizontal pleiotropy

|outcome    |exposure | egger_intercept|        se|      pval|
|:----------|:--------|---------------:|---------:|---------:|
|loneliness |F1       |       0.0076312| 0.0076095| 0.3357276|

- there does not seem to be evidence of directional horizontal pleiotropy

### Test that the F1 exposure is upstream of loneliness outcome

|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1       |loneliness |       0.0020098|      0.0004383|TRUE                     |2.82x10<sup>-27</sup>|

### MR Egger Sensitivity Analyses
- selecting weaker instruments and re-running MR

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |  103| 0.4037587| 0.1210831| 1.20x10<sup>-03</sup>|
|loneliness |F1       |Inverse variance weighted |  103| 0.2927095| 0.0211061| 9.83x10<sup>-44</sup>|
|loneliness |F1       |Weighted mode             |  103| 0.3767557| 0.0577646| 2.70x10<sup>-09</sup>|
|loneliness |F1       |Weighted median           |  103| 0.3151128| 0.0205324| 3.70x10<sup>-53</sup>|
|loneliness |F1       |MR Egger (bootstrap)      |  103| 0.2593580| 0.0823343| 2.00x10<sup>-03</sup>|

- all MR methods are significant 
- the I<sup>2</sup> suggests that there is no weak instrument bias
- I<sup>2</sup> all instruments = .970, I<sup>2</sup> weak instruments = .969

---


### Forest Plot of MR

![image](https://user-images.githubusercontent.com/68326791/198335468-1f10a61b-790b-4d14-8484-ef60269774ca.png)


### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198336108-187eb7eb-3ee3-4386-be58-828d44744d18.png)

--- 

### Steiger Filtering

- all SNPs were found to be operating in the correct causal direction
- so results of MR Steiger are the same as normal MR

---

## F1 QSNP filtered to Loneliness
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-08</sup>
- 10 instruments
---

### Results from Two Sample MR
|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |   10| 0.4439023| 0.3011940| 1.79x10<sup>-01</sup>|
|loneliness |F1_Qsnp  |Inverse variance weighted |   10| 0.3393446| 0.0654521| 2.16x10<sup>-07</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |   10| 0.3857237| 0.0880167| 1.76x10<sup>-03</sup>|
|loneliness |F1_Qsnp  |Weighted median           |   10| 0.3826074| 0.0639450| 2.19x10<sup>-09</sup>|
|loneliness |F1_Qsnp  |MR Egger (bootstrap)      |   10| 0.3582235| 0.2508896| 5.8x10<sup>-02</sup>|

- MR methods are significant except for MR Egger and MR Egger bootstrap
- MR Egger and MR Egger bootstrap effects are now, however, in the positive direction (for the non-QSNP filtered analysis, they were in the negative direction)
- instability of effect estimates is likely due to the small number of instruments

### Heterogeneity Test

|outcome    |exposure |method                    |        Q| Q_df|    Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  | 20.81972|    8| 0.0076421|
|loneliness |F1_Qsnp  |Inverse variance weighted | 21.15064|    9| 0.0119981|

- cannot assume homogeneity, there is evidence of heterogeneity

### Test for Directional Horizontal Pleiotropy

|outcome    |exposure | egger_intercept|        se|      pval|
|:----------|:--------|---------------:|---------:|---------:|
|loneliness |F1_Qsnp  |      -0.0017578| 0.0049295| 0.7306186|

- no evidence of directional horizontal pleiotropy 

### Test that F1/NMD QSNP is upstream of loneliness

|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1_Qsnp  |loneliness |       0.0011072|      0.0002447|TRUE                     |1.49x10<sup>-15</sup>|


### MR Steiger

- all SNPs were found to be operating in the correct causal direction
- so results of MR Steiger are identical to that of the normal MR

---

## Loneliness to F1/NMD with reduced p-value threshold

- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-07</sup>
- 24 instruments

---

### Results from Two Sample MR

|outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   24|  0.2901209| 0.3827217| 0.4564671|
|F1      |loneliness |Inverse variance weighted |   24|  0.4898733| 0.0741826| 4.01x10<sup>-11</sup>|
|F1      |loneliness |Weighted mode             |   24|  0.5341551| 0.1055374| 4.01x10<sup>-05</sup>|
|F1      |loneliness |Weighted median           |   24|  0.4828668| 0.0623770| 9.86x10<sup>-15</sup>|
|F1      |loneliness |MR Egger (bootstrap)      |   24| -0.0835106| 0.2224388| 0.3450000|

- MR methods significant and consistent apart from MR Egger and MR Egger Bootstrap
- Like the Lone to NMD analysis using a genome-wide significance p-value threshold, the MR Egger bootstrap effect is also in the negative direction

### Hetereogeneity

|outcome |exposure   |method                    |        Q| Q_df| Q_pval|
|:-------|:----------|:-------------------------|--------:|----:|------:|
|F1      |loneliness |MR Egger                  | 74.76671|   22|  1e-07|
|F1      |loneliness |Inverse variance weighted | 75.72983|   23|  2e-07|

- we cannot assume homogeneity

### Horizontal Directional Pleiotropy

|outcome |exposure   | egger_intercept|       se|      pval|
|:-------|:----------|---------------:|--------:|---------:|
|F1      |loneliness |       0.0026415| 0.004962| 0.5998197|

- no evidence of directional horizontal pleiotropy


### MR Egger Sensitivity Analysis

|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |  139| 0.7990098| 0.2366442| 0.0009559|
|F1      |loneliness |Inverse variance weighted |  139| 0.4228029| 0.0337056| 0.0000000|
|F1      |loneliness |Weighted mode             |  139| 0.6591925| 0.1130996| 0.0000000|
|F1      |loneliness |Weighted median           |  139| 0.4874169| 0.0289665| 0.0000000|
|F1      |loneliness |MR Egger (bootstrap)      |  139| 0.1279381| 0.1266754| 0.1560000|

- all MR methods signficant and consistent, except for MR Egger bootstrap
- I<sup>2</sup> of all instruments = 0.970, I2 of weak instruments = 0.970, so there does not seem to be weak instrument bias

---

### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/198681335-196a5016-8acc-4c5c-8587-2313599e26fe.png)

### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198681665-1203cae7-68a3-49f7-9958-4958cc314532.png)

---

### Test that loneliness is upstream of F1/NMD

|exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|loneliness |F1      |       0.0017882|      0.0005796|TRUE                     |            0|

- 2 instruments were found to be operating in the incorrect direction

### MR Steiger
|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   22| 0.4625481| 0.3004663| 0.1393710|
|F1      |loneliness |Inverse variance weighted |   22| 0.4355445| 0.0583633| 8.48x10<sup>-14</sup>|
|F1      |loneliness |Weighted mode             |   22| 0.5412482| 0.1115567| 8.51x10<sup>-05</sup>|
|F1      |loneliness |Weighted median           |   22| 0.4741883| 0.0645738| 2.08x10<sup>-13</sup>|
|F1      |loneliness |MR Egger (bootstrap)      |   22| 0.1380797| 0.2257816| 0.2810000|

- results are still consistent with the original MR analysis, except that the MR Egger Bootstrapped effect is no longer in the negative direction
---

### Steiger Forest Plot

![image](https://user-images.githubusercontent.com/68326791/198682179-09abde67-76cc-4130-842b-7d86cacf5d98.png)

### Steiger Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198682374-483332af-1db7-40a0-b7d5-3754d2ebca55.png)

### MR RAPS

- beta hat (causal effect) = 0.5128462
- beta se = 0.06853184
- beta p value = 7.238654e-14

---

## NMD/F1 to Loneliness with Reduced p-value threshold
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-07</sup>
- 35 instruments

---

### Two Sample MR Results

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   35| -0.3333987| 0.3011675| 0.2762892|
|loneliness |F1       |Inverse variance weighted |   35|  0.2574628| 0.0551922| 3.09x10<sup>-06</sup>|
|loneliness |F1       |Weighted mode             |   35|  0.2941663| 0.0727519| 2.86x10<sup>-04</sup>|
|loneliness |F1       |Weighted median           |   35|  0.2890684| 0.0412860| 2.53x10<sup>-12</sup>|
|loneliness |F1       |MR Egger (bootstrap)      |   35| -0.1645353| 0.1996521| 0.1950000|

- pattern of results is similar to the original MR, where MR methods apart from Egger and Egger bootstrap are significant and consisent
- similarly, both Egger and Egger bootstrap are in the negative direction, like they are in the NMD/F1 to loneliness MR analysis using genome-wide significant instruments only

### Heterogeneity

|outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|------:|
|loneliness |F1       |MR Egger                  | 152.1081|   33|3.23x10<sup>-17</sup>|
|loneliness |F1       |Inverse variance weighted | 170.4151|   34|4.47x10<sup>-20</sup>|

- we cannot assume homogeneity 

### Test of directional horizontal pleiotropy

|outcome    |exposure | egger_intercept|        se|     pval|
|:----------|:--------|---------------:|---------:|--------:|
|loneliness |F1       |       0.0091299| 0.0045812| 0.054593|

- no evidence of directional horizontal pleiotropy (though it is near-significant)

### Mr Egger Sensitivity Analysis

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |  188| 0.2995167| 0.1007209| 0.0033319|
|loneliness |F1       |Inverse variance weighted |  188| 0.2826353| 0.0171767| 7.78x10<sup>-61</sup>|
|loneliness |F1       |Weighted mode             |  188| 0.1957380| 0.0506386| 1.53x10<sup>-04</sup>|
|loneliness |F1       |Weighted median           |  188| 0.2974803| 0.0165897| 6.68x10<sup>-72</sup>|
|loneliness |F1       |MR Egger (bootstrap)      |  188| 0.1161874| 0.0638577| 0.0340000|

- all MR methods are significant and consistent and this pattern of results is similar to that of the original MR analysis for F1/NMD to loneliness
- I<sup>2</sup> all instruments = .968, I<sup>2</sup> weak instruments = .967, so no weak instrument bias

### Testing that F1 is upstream of loneliness

|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|vvA60E      |0oxnSr     |F1       |loneliness |       0.0029892|      0.0006832|TRUE                     |            0|

- 1 SNP was found to be operating in the incorrect causal direction

---
### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/198688515-2a0c6f52-f9dc-4f76-a5ab-9ccacec1de96.png)

### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198688656-db6168cb-e560-4792-863a-3f45725f00b0.png)

---

### MR Steiger

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   34| -0.1866047| 0.3033239| 0.5427736|
|loneliness |F1       |Inverse variance weighted |   34|  0.2427261| 0.0525080| 0.0000038|
|loneliness |F1       |Weighted mode             |   34|  0.2936696| 0.0710177| 0.0002289|
|loneliness |F1       |Weighted median           |   34|  0.2866372| 0.0416342| 0.0000000|
|loneliness |F1       |MR Egger (bootstrap)      |   34| -0.0909525| 0.1924328| 0.3150000|

- results are very similar to normal MR and both MR Egger and MR Egger bootstrapped effect estimates are still in the negative direction

### MR RAPS

- MR Raps indicates a significant causal effect from F1 to Loneliness

- beta hat (causal effect) = .304
- beta se = 0.04972369
- beta p value = 1.022118e-09

---

## F1 QSNP MR Results with Reduced p-value threshold
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-07</sup>
- 19 instruments


---

### Two Sample MR Results

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |   19| 0.2059939| 0.2780956| 0.4689654|
|loneliness |F1_Qsnp  |Inverse variance weighted |   19| 0.3466251| 0.0548549| 2.63x10<sup>-10</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |   19| 0.3661856| 0.0769367| 1.57x10<sup>-04</sup>|
|loneliness |F1_Qsnp  |Weighted median           |   19| 0.3358195| 0.0510162| 4.62x10<sup>-11</sup>|
|loneliness |F1_Qsnp  |MR Egger (bootstrap)      |   19| 0.0922217| 0.2017945| 0.3230000|

- significant and consistent results across MR methods except for MR Egger and MR Egger bootstrapped

### Heterogeneity

|outcome    |exposure |method                    |        Q| Q_df|   Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|--------:|
|loneliness |F1_Qsnp  |MR Egger                  | 48.75725|   17| 6.57e-05|
|loneliness |F1_Qsnp  |Inverse variance weighted | 49.52169|   18| 8.91e-05|

- cannot assume homogeneity

### Directional Horizontal Pleiotropy

|outcome    |exposure | egger_intercept|        se|      pval|
|:----------|:--------|---------------:|---------:|---------:|
|loneliness |F1_Qsnp  |       0.0021538| 0.0041719| 0.6123145|

- no evidence of directional horizontal pleiotropy

### Egger Sensitivity Analysis

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |  146| 0.2111061| 0.0998598| 0.0362366|
|loneliness |F1_Qsnp  |Inverse variance weighted |  146| 0.2835963| 0.0185522| 9.42x10<sup>-53</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |  146| 0.3703243| 0.0520006| 4.59x10<sup>-11</sup>|
|loneliness |F1_Qsnp  |Weighted median           |  146| 0.3106336| 0.0191519| 3.67x10<sup>-59</sup>|
|loneliness |F1_Qsnp  |MR Egger (bootstrap)      |  146| 0.1780485| 0.0715615| 0.0060000|

- All MR instruments are significant, which is different from the F1_QSNP filtered results using only genome-wide significant instruments
- I<sup>2</sup> all instruments = .964, I<sup>2</sup> weak instruments = .962, so no weak instrument bias

### Testing that F1 QSNP is upstream of loneliness
|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1_Qsnp  |loneliness |       0.0018235|       0.000444|TRUE                     |            0|

### MR Steiger

- 1 SNP found to be operating in the incorrect direction

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |   18| 0.4306750| 0.2357781| 0.0864743|
|loneliness |F1_Qsnp  |Inverse variance weighted |   18| 0.3222953| 0.0448503| 6.67x10<sup>-13</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |   18| 0.3650974| 0.0829786| 0.0003913|
|loneliness |F1_Qsnp  |Weighted median           |   18| 0.3330525| 0.0503948| 3.87x10<sup>-11</sup>|
|loneliness |F1_Qsnp  |MR Egger (bootstrap)      |   18| 0.2327269| 0.2176984| 0.1360000|

- even though the effect estimates have increased slightly, the pattern of results is mostly the sam 

### MR Raps

- MR Raps indicates a significant causal effect from F1 Qsnp to Loneliness

- beta hat (causal effect) = .358
- beta se = 0.0497
- beta p value = 1.33e-15

