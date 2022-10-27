

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

### Leave-one-out Analysis
- IVW

|exposure   |outcome |id.exposure |id.outcome | samplesize|SNP        |         b|        se|  p|
|:----------|:-------|:-----------|:----------|----------:|:----------|---------:|---------:|--:|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs11867618 | 0.4812323| 0.0573341|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs1439252  | 0.4804858| 0.0566879|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs1966836  | 0.4988553| 0.0571172|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs2069117  | 0.5271552| 0.0579610|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs2273146  | 0.5137743| 0.0572437|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs4462992  | 0.5138515| 0.0573440|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs495146   | 0.4891605| 0.0568625|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs613872   | 0.5000761| 0.0596658|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs7044244  | 0.4780433| 0.0581380|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs7105282  | 0.4766733| 0.0567101|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs9388863  | 0.4940247| 0.0572867|  0|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|All        | 0.4956359| 0.0547951|  0|

- Egger

|exposure   |outcome |id.exposure |id.outcome | samplesize|SNP        |         b|        se|         p|
|:----------|:-------|:-----------|:----------|----------:|:----------|---------:|---------:|---------:|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs11867618 | 0.4463445| 0.3046933| 0.1811112|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs1439252  | 0.6165781| 0.2861241| 0.0632871|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs1966836  | 0.5398820| 0.2940187| 0.1036449|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs2069117  | 0.5685066| 0.2793595| 0.0762591|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs2273146  | 0.4766950| 0.2858311| 0.1339216|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs4462992  | 0.4799443| 0.2854178| 0.1311612|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs495146   | 0.5565733| 0.2910761| 0.0922288|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs613872   | 0.7556010| 0.4978679| 0.1675741|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs7044244  | 0.4936769| 0.2856260| 0.1221776|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs7105282  | 0.6296018| 0.2855769| 0.0585662|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs9388863  | 0.5487723| 0.2950884| 0.0999786|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|All        | 0.5443916| 0.2789841| 0.0827889|

- Egger Bootstrapped

|exposure   |outcome |id.exposure |id.outcome | samplesize|SNP        |          b|        se|     p|
|:----------|:-------|:-----------|:----------|----------:|:----------|----------:|---------:|-----:|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs11867618 | -0.2204379| 0.4140230| 0.286|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs1439252  | -0.1402990| 0.3671067| 0.333|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs1966836  | -0.1851084| 0.3498960| 0.276|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs2069117  | -0.0761768| 0.3480997| 0.391|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs2273146  | -0.1291068| 0.3464793| 0.345|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs4462992  | -0.1220551| 0.3687351| 0.352|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs495146   | -0.1805948| 0.3403019| 0.283|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs613872   | -0.1850187| 0.3543951| 0.292|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs7044244  | -0.2675083| 0.3518851| 0.199|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs7105282  | -0.1267540| 0.3554224| 0.340|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|rs9388863  | -0.1530672| 0.3648315| 0.309|
|loneliness |F1      |zekZiO      |bCloOr     |     378372|All        | -0.1610779| 0.3387258| 0.299|


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

### Leave-one-out Analysis
- Egger

|exposure |outcome    |id.exposure |id.outcome | samplesize|SNP        |          b|        se|         p|
|:--------|:----------|:-----------|:----------|----------:|:----------|----------:|---------:|---------:|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs1021363  | -0.2677724| 0.4833570| 0.5906731|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs11663602 | -0.2516267| 0.4865899| 0.6153092|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs12519058 | -0.2512132| 0.5315738| 0.6457477|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs12807357 | -0.2799721| 0.4794685| 0.5710528|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs1532279  | -0.4758219| 0.4634104| 0.3265725|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs158179   | -0.3619430| 0.4653871| 0.4531342|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs1592757  |  0.4446341| 0.3588063| 0.2410590|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs2232423  | -0.7369740| 0.6016763| 0.2462075|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs4274014  | -0.2426821| 0.4875685| 0.6284680|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs4632195  | -0.2010804| 0.4680551| 0.6757749|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs7087685  | -0.1731689| 0.4900681| 0.7304998|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs7721129  | -0.2420922| 0.4874420| 0.6292057|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs7807190  | -0.2707728| 0.4950700| 0.5953422|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs8179610  | -0.2327543| 0.4774475| 0.6354764|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|All        | -0.2495892| 0.4675338| 0.6031996|

- IVW

|exposure |outcome    |id.exposure |id.outcome | samplesize|SNP        |         b|        se|         p|
|:--------|:----------|:-----------|:----------|----------:|:----------|---------:|---------:|---------:|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs1021363  | 0.1930543| 0.1055442| 0.0673798|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs11663602 | 0.2000506| 0.1053804| 0.0576477|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs12519058 | 0.2000261| 0.1037380| 0.0538320|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs12807357 | 0.1888930| 0.1046193| 0.0709924|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs1532279  | 0.2293336| 0.0999634| 0.0217804|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs158179   | 0.2303094| 0.1013995| 0.0231285|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs1592757  | 0.3189309| 0.0682156| 0.0000029|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs2232423  | 0.1977371| 0.1073512| 0.0654802|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs4274014  | 0.2166091| 0.1067497| 0.0424451|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs4632195  | 0.1771964| 0.1001255| 0.0767700|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs7087685  | 0.1893667| 0.1007325| 0.0601223|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs7721129  | 0.1977818| 0.1056221| 0.0611317|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs7807190  | 0.2055126| 0.1061101| 0.0527716|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|rs8179610  | 0.1852199| 0.1033381| 0.0730740|
|F1       |loneliness |eOlwoU      |hK2UjT     |     445024|All        | 0.2087931| 0.0983364| 0.0337327|

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

