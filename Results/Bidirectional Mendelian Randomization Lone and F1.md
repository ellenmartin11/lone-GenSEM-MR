

# Bidirectional MR

---

## loneliness to F1/NMD

F1 refers to the Neurodevelopmental and Mood Disorders latent factor (NMD)

Date: **6 June, 2022**

---

### Results from two sample MR:

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|zekZiO      |bCloOr     |F1      |loneliness |MR Egger                  |   11|  0.5443916| 0.2789841| 8.28x10<sup>-02</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |Inverse variance weighted |   11|  0.4956359| 0.0547951| 1.49x10<sup>-19</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |Weighted mode             |   11|  0.5238836| 0.1343346| 2.96x10<sup>-03</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |Weighted median           |   11|  0.4810642| 0.0803782| 2.16x10<sup>-09</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |MR Egger (bootstrap)      |   11| -0.1618239| 0.3356590| 3.00x10<sup>-01</sup>|

- All methods except for Egger and Egger Boostrap are significant 

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

|id.exposure |id.outcome |exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|zekZiO      |bCloOr     |loneliness |F1      |       0.0009896|      0.0002397|TRUE                     |4.87x10<sup>-13</sup>|

- Steiger directionality test suggests that we have the correct direction of causal effect from loneliness to F1

### MR Egger Sensitivity Test
|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|zekZiO      |bCloOr     |F1      |loneliness |MR Egger                  |   77| 1.4606595| 0.3571151| 1.07x10<sup>-04</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |Inverse variance weighted |   77| 0.4687211| 0.0449261| 1.75x10<sup>-25</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |Weighted mode             |   77| 0.6736313| 0.1070706| 1.84x10<sup>-08</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |Weighted median           |   77| 0.5464386| 0.0363076| 3.44x10<sup>-51</sup>|
|zekZiO      |bCloOr     |F1      |loneliness |MR Egger (bootstrap)      |   77| 0.2411901| 0.1979520| 1.13x10<sup>-01</sup>|

- still significant and consistent across MR methods
- I2 of all instruments = .972, I2 of weaker instruments .972
---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/198327856-a6862c01-ce57-4d14-9afa-c40d07eb6a67.png)

### Scatter Plot 

![image](https://user-images.githubusercontent.com/68326791/198328770-69c6ce2a-7ae7-457a-94fb-f38e0714d700.png)

---

### Steiger Filtering

|id.exposure |id.outcome |exposure   |outcome |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:----------|:-------|:---------------|:--------------|:------------------------|:------------|
|zekZiO      |bCloOr     |loneliness |F1      |8.306257e-05    |3.19655e-05    |TRUE                     |0.1176345    |
|zekZiO      |bCloOr     |loneliness |F1      |7.089193e-05    |2.923562e-05   |TRUE                     |0.173049     |
|zekZiO      |bCloOr     |loneliness |F1      |7.481954e-05    |1.473583e-05   |TRUE                     |0.02957451   |
|zekZiO      |bCloOr     |loneliness |F1      |0.0001012337    |4.970203e-06   |TRUE                     |0.0003971839 |
|zekZiO      |bCloOr     |loneliness |F1      |7.854718e-05    |6.505678e-06   |TRUE                     |0.004310286  |
|zekZiO      |bCloOr     |loneliness |F1      |7.838155e-05    |7.084081e-06   |TRUE                     |0.005108644  |

- results of MR Steiger are the same as normal MR

---

## F1 to Loneliness

---

### Results from Two-Sample MR

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|eOlwoU      |hK2UjT     |loneliness |F1       |MR Egger                  |   14| -0.2495892| 0.4675338| 6.03x10<sup>-01</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Inverse variance weighted |   14|  0.2087931| 0.0983364| 3.37x10<sup>-02</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Weighted mode             |   14|  0.3570321| 0.0836802| 9.18x10<sup>-04</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Weighted median           |   14|  0.3232340| 0.0604615| 8.99x10<sup>-08</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |MR Egger (bootstrap)      |   14| -0.2617346| 0.3267510| 1.98x10<sup>-01</sup>|

- IVW and the other methods significant apart from Egger

### Heterogeneity Tests

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|------:|
|eOlwoU      |hK2UjT     |loneliness |F1       |MR Egger                  | 88.39920|   12|1.00x10<sup>-13</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Inverse variance weighted | 95.80784|   13|1.07x10<sup>-14</sup>|

- since results do indicate heterogeneity, so we have to refer to Egger, which is n.s.

### Test for directional horizontal pleiotropy
|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|eOlwoU      |hK2UjT     |loneliness |F1       |       0.0076312| 0.0076095| 0.3357276|

- there does not seem to be evidence of pleiotropy

### Test that the F1 exposure is upstream of loneliness outcome

|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1       |loneliness |       0.0020098|      0.0004383|TRUE                     |            2.82x10<sup>-27</sup>|

### MR Egger Sensitivity Analyses
- selecting weaker instruments and re-running MR

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|eOlwoU      |hK2UjT     |loneliness |F1       |MR Egger                  |  103| 0.4037587| 0.1210831| 1.20x10<sup>-03</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Inverse variance weighted |  103| 0.2927095| 0.0211061| 9.83x10<sup>-44</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Weighted mode             |  103| 0.3767557| 0.0577646| 2.70x10<sup>-09</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |Weighted median           |  103| 0.3151128| 0.0205324| 3.70x10<sup>-53</sup>|
|eOlwoU      |hK2UjT     |loneliness |F1       |MR Egger (bootstrap)      |  103| 0.2593580| 0.0823343| 2.00x10<sup>-03</sup>|

- problem does not seem to be weak SNPS
- I2 all instruments = .970
- I2 weak instruments = .969

---


### Forest Plot of MR

![image](https://user-images.githubusercontent.com/68326791/198335468-1f10a61b-790b-4d14-8484-ef60269774ca.png)


### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198336108-187eb7eb-3ee3-4386-be58-828d44744d18.png)

--- 

### Steiger Filtering
-  correct causal direction

|id.exposure |id.outcome |exposure |outcome    |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:--------|:----------|:---------------|:--------------|:------------------------|:------------|
|eOlwoU      |hK2UjT     |F1       |loneliness |9.277061e-05    |2.081419e-05   |TRUE                     |0.02186975   |
|eOlwoU      |hK2UjT     |F1       |loneliness |8.105609e-05    |1.245558e-05   |TRUE                     |0.01330606   |
|eOlwoU      |hK2UjT     |F1       |loneliness |8.711655e-05    |1.203016e-05   |TRUE                     |0.007991305  |
|eOlwoU      |hK2UjT     |F1       |loneliness |9.386044e-05    |2.631801e-05   |TRUE                     |0.03927085   |
|eOlwoU      |hK2UjT     |F1       |loneliness |8.442823e-05    |5.981661e-06   |TRUE                     |0.002293868  |
|eOlwoU      |hK2UjT     |F1       |loneliness |8.222106e-05    |3.21007e-06    |TRUE                     |0.001000479  |

- results of MR Steiger are the same as normal MR

---

## F1 QSNP filtered to Loneliness

---

### Results from Two Sample MR

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |MR Egger                  |   10| 0.4439023| 0.3011940| 1.79x10<sup>-01</sup>|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Inverse variance weighted |   10| 0.3393446| 0.0654521| 2.16x10<sup>-07</sup>|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Weighted mode             |   10| 0.3857237| 0.0880167| 1.76x10<sup>-03</sup>|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Weighted median           |   10| 0.3826074| 0.0639450| 2.19x10<sup>-09</sup>|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |MR Egger (bootstrap)      |   10| 0.3582235| 0.2508896| 5.8x10<sup>-02</sup>|

- all significant except for egger

### Heterogeneity Test

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df|    Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|---------:|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |MR Egger                  | 20.81972|    8| 0.0076421|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Inverse variance weighted | 21.15064|    9| 0.0119981|

- evidence of heterogeneity, therefore we must refer to Egger

### Test for Directional Horizontal Pleiotropy

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |      -0.0017578| 0.0049295| 0.7306186|


### Steiger

|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|k7gnkc      |hK2UjT     |F1_Qsnp  |loneliness |       0.0011072|      0.0002447|TRUE                     |1.49x10<sup>-15</sup>|


|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |MR Egger                  |   10| 0.4439023| 0.3011940| 0.1787594|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Weighted median           |   10| 0.3826074| 0.0656935| 0.0000000|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Inverse variance weighted |   10| 0.3393446| 0.0654521| 0.0000002|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Simple mode               |   10| 0.3882365| 0.0895519| 0.0018903|
|k7gnkc      |hK2UjT     |loneliness |F1_Qsnp  |Weighted mode             |   10| 0.3857237| 0.0826944| 0.0011778|


---

## Loneliness to F1/NMD with reduced p-value threshold

MR using a p-value threshold of p < 5x10<sup>-07</sup> to increase instruments for MR

---

### Results from Two Sample MR

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger                  |   24|  0.2901209| 0.3827217| 0.4564671|
|gTcrej      |ihPf73     |F1      |loneliness |Inverse variance weighted |   24|  0.4898733| 0.0741826| 4.01x10<sup>-11</sup>|
|gTcrej      |ihPf73     |F1      |loneliness |Weighted mode             |   24|  0.5341551| 0.1055374| 4.01x10<sup>-05</sup>|
|gTcrej      |ihPf73     |F1      |loneliness |Weighted median           |   24|  0.4828668| 0.0623770| 9.86x10<sup>-15</sup>|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger (bootstrap)      |   24| -0.0835106| 0.2224388| 0.3450000|

- similar pattern of results to main MR analysis with 11 instruments

### Hetereogeneity

|id.exposure |id.outcome |outcome |exposure   |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:-------|:----------|:-------------------------|--------:|----:|------:|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger                  | 74.76671|   22|  1e-07|
|gTcrej      |ihPf73     |F1      |loneliness |Inverse variance weighted | 75.72983|   23|  2e-07|

- Q for both Egger and IVW are significant, so there is evidence of heterogeneity and we must refer to MR Egger

### Horizontal Directional Pleiotropy

|id.exposure |id.outcome |outcome |exposure   | egger_intercept|       se|      pval|
|:-----------|:----------|:-------|:----------|---------------:|--------:|---------:|
|gTcrej      |ihPf73     |F1      |loneliness |       0.0026415| 0.004962| 0.5998197|

- no evidence of directional horizontal pleiotropy


### MR Egger Sensitivity Analysis

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger                  |  139| 0.7990098| 0.2366442| 0.0009559|
|gTcrej      |ihPf73     |F1      |loneliness |Inverse variance weighted |  139| 0.4228029| 0.0337056| 0.0000000|
|gTcrej      |ihPf73     |F1      |loneliness |Weighted mode             |  139| 0.6591925| 0.1130996| 0.0000000|
|gTcrej      |ihPf73     |F1      |loneliness |Weighted median           |  139| 0.4874169| 0.0289665| 0.0000000|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger (bootstrap)      |  139| 0.1279381| 0.1266754| 0.1560000|

- I2 of all instruments = 0.970, I2 of weak instruments = 0.970, so no correction is needed

---

### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/198681335-196a5016-8acc-4c5c-8587-2313599e26fe.png)

### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198681665-1203cae7-68a3-49f7-9958-4958cc314532.png)

---

### Steiger Directionality Test

|id.exposure |id.outcome |exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|gTcrej      |ihPf73     |loneliness |F1      |       0.0017882|      0.0005796|TRUE                     |            0|

- 2 instruments were found to be in the incorrect direction

### MR Steiger
|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger                  |   22| 0.4625481| 0.3004663| 0.1393710|
|gTcrej      |ihPf73     |F1      |loneliness |Inverse variance weighted |   22| 0.4355445| 0.0583633| 8.48x10<sup>-14</sup>|
|gTcrej      |ihPf73     |F1      |loneliness |Weighted mode             |   22| 0.5412482| 0.1115567| 8.51x10<sup>-05</sup>|
|gTcrej      |ihPf73     |F1      |loneliness |Weighted median           |   22| 0.4741883| 0.0645738| 2.08x10<sup>-13</sup>|
|gTcrej      |ihPf73     |F1      |loneliness |MR Egger (bootstrap)      |   22| 0.1380797| 0.2257816| 0.2810000|

---

### Steiger Forest Plot

![image](https://user-images.githubusercontent.com/68326791/198682179-09abde67-76cc-4130-842b-7d86cacf5d98.png)

### Steiger Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198682374-483332af-1db7-40a0-b7d5-3754d2ebca55.png)

### MR Raps

- beta hat (causal effect) = 0.5128462
- beta se = 0.06853184
- beta p value = 7.238654e-14

- indicates a causal association from loneliness to F1
---

## NMD/F1 to Loneliness with Reduced p-value threshold (e<sup>-07</sup>)

---

### Two Sample MR Results

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger                  |   35| -0.3333987| 0.3011675| 0.2762892|
|vvA60E      |0oxnSr     |loneliness |F1       |Inverse variance weighted |   35|  0.2574628| 0.0551922| 3.09x10<sup>-06</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |Weighted mode             |   35|  0.2941663| 0.0727519| 2.86x10<sup>-04</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |Weighted median           |   35|  0.2890684| 0.0412860| 2.53x10<sup>-12</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger (bootstrap)      |   35| -0.1645353| 0.1996521| 0.1950000|

- significant across IVW, weighted mode and weighted median

### Heterogeneity

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|------:|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger                  | 152.1081|   33|3.23x10<sup>-17</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |Inverse variance weighted | 170.4151|   34|4.47x10<sup>-20</sup>|

- evidence of heterogeneity so must refer to MR Egger, which is n.s.

### Test of directional horizontal pleiotropy

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|     pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|--------:|
|vvA60E      |0oxnSr     |loneliness |F1       |       0.0091299| 0.0045812| 0.054593|

- n.s. but only just

### Mr Egger Sensitivity Analysis

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger                  |  188| 0.2995167| 0.1007209| 0.0033319|
|vvA60E      |0oxnSr     |loneliness |F1       |Inverse variance weighted |  188| 0.2826353| 0.0171767| 7.78x10<sup>-61</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |Weighted mode             |  188| 0.1957380| 0.0506386| 1.53x10<sup>-04</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |Weighted median           |  188| 0.2974803| 0.0165897| 6.68x10<sup>-72</sup>|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger (bootstrap)      |  188| 0.1161874| 0.0638577| 0.0340000|

- I2 all instruments = .968
- I2 weak instruments = .967, so no weak instrument bias and no need to adjust

### Testing that F1 is upstream of loneliness

|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|vvA60E      |0oxnSr     |F1       |loneliness |       0.0029892|      0.0006832|TRUE                     |            0|



---
### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/198688515-2a0c6f52-f9dc-4f76-a5ab-9ccacec1de96.png)

### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/198688656-db6168cb-e560-4792-863a-3f45725f00b0.png)

---

### MR Steiger

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger                  |   34| -0.1866047| 0.3033239| 0.5427736|
|vvA60E      |0oxnSr     |loneliness |F1       |Inverse variance weighted |   34|  0.2427261| 0.0525080| 0.0000038|
|vvA60E      |0oxnSr     |loneliness |F1       |Weighted mode             |   34|  0.2936696| 0.0710177| 0.0002289|
|vvA60E      |0oxnSr     |loneliness |F1       |Weighted median           |   34|  0.2866372| 0.0416342| 0.0000000|
|vvA60E      |0oxnSr     |loneliness |F1       |MR Egger (bootstrap)      |   34| -0.0909525| 0.1924328| 0.3150000|

- results are very similar to normal MR 

### MR RAPS

- MR Raps indicates a significant causal effect from F1 to Loneliness

- beta hat (causal effect) = .304
- beta se = 0.04972369
- beta p value = 1.022118e-09

---

## F1 QSNP MR Results with Reduced p-value threshold (e<sup>-07</sup>)

---

### Two Sample MR Results

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger                  |   19| 0.2059939| 0.2780956| 0.4689654|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Inverse variance weighted |   19| 0.3466251| 0.0548549| 2.63x10<sup>-10</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Weighted mode             |   19| 0.3661856| 0.0769367| 1.57x10<sup>-04</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Weighted median           |   19| 0.3358195| 0.0510162| 4.62x10<sup>-11</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger (bootstrap)      |   19| 0.0922217| 0.2017945| 0.3230000|

- sig across MR methods except for Egger

### Heterogeneity

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df|   Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|--------:|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger                  | 48.75725|   17| 6.57e-05|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Inverse variance weighted | 49.52169|   18| 8.91e-05|

- evidence of heterogeneity, so must refer to Egger

### Directional Horizontal Pleiotropy

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |       0.0021538| 0.0041719| 0.6123145|

- n.s.

### Egger Sensitivity Analysis

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger                  |  146| 0.2111061| 0.0998598| 0.0362366|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Inverse variance weighted |  146| 0.2835963| 0.0185522| 9.42x10<sup>-53</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Weighted mode             |  146| 0.3703243| 0.0520006| 4.59x10<sup>-11</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Weighted median           |  146| 0.3106336| 0.0191519| 3.67x10<sup>-59</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger (bootstrap)      |  146| 0.1780485| 0.0715615| 0.0060000|

- I2 all instruments = .964
- I2 weak instruments = .962

### Testing that F1 QSNP is upstream of loneliness
|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|ynm33e      |0oxnSr     |F1_Qsnp  |loneliness |       0.0018235|       0.000444|TRUE                     |            0|

### MR Steiger

- 20 SNPs operating in the correct direction

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger                  |   18| 0.4306750| 0.2357781| 0.0864743|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Inverse variance weighted |   18| 0.3222953| 0.0448503| 6.67x10<sup>-13</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Weighted mode             |   18| 0.3650974| 0.0829786| 0.0003913|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |Weighted median           |   18| 0.3330525| 0.0503948| 3.87x10<sup>-11</sup>|
|ynm33e      |0oxnSr     |loneliness |F1_Qsnp  |MR Egger (bootstrap)      |   18| 0.2327269| 0.2176984| 0.1360000|

### MR Raps

- MR Raps indicates a significant causal effect from F1 Qsnp to Loneliness

- beta hat (causal effect) = .358
- beta se = 0.0497
- beta p value = 1.33e-15

