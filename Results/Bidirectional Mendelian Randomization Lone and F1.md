

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
|F1      |loneliness |Weighted mode             |   11|  0.5238836| 0.1343346| 2.36x10<sup>-03</sup>|
|F1      |loneliness |Weighted median           |   11|  0.4810642| 0.0803782| 7.22x10<sup>-09</sup>|

- All methods except for Egger are significant

### Heterogeneity tests

|id.exposure |id.outcome |outcome |exposure   |method                    |        Q| Q_df|    Q_pval|
|:-----------|:----------|:-------|:----------|:-------------------------|--------:|----:|---------:|
|zekZiO      |bCloOr     |F1      |loneliness |MR Egger                  | 8.840471|    9| 0.4521287|
|zekZiO      |bCloOr     |F1      |loneliness |Inverse variance weighted | 8.872238|   10| 0.5442702|

- since Q is low and not statistically significant, there is no evidence of heterogeneity

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

- still significant and consistent across MR methods
- I2 of all instruments = .972, I2 of weaker instruments .972
- not suggestive of weak instrument bias
---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/200127181-ffb802c1-74dd-44c7-9cd9-44c0a8cdacf4.png)

### Scatter Plot 

![image](https://user-images.githubusercontent.com/68326791/200127197-76fb510d-0288-4ca3-8f0b-9812ad7875ce.png)

---

### Steiger Filtering

- all SNPs were found to be operating in the correct causal direction
- so results of MR steiger are the same as normal MR

---

## F1 QSNP filtered to Loneliness
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-08</sup>
- 11 instruments
---

### Results from Two Sample MR
|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |   10| 0.4439023| 0.3011940| 1.79x10<sup>-01</sup>|
|loneliness |F1_Qsnp  |Inverse variance weighted |   10| 0.3393446| 0.0654521| 2.16x10<sup>-07</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |   10| 0.3857237| 0.0880167| 2.61x10<sup>-03</sup>|
|loneliness |F1_Qsnp  |Weighted median           |   10| 0.3826074| 0.0639450| 3.60x10<sup>-09</sup>|

- MR methods are significant except for MR Egger

### Heterogeneity Test

|outcome    |exposure |method                    |        Q| Q_df|    Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  | 20.81972|    8| 0.0076421|
|loneliness |F1_Qsnp  |Inverse variance weighted | 21.15064|    9| 0.0119981|

- there is evidence of heterogeneity

### Test for Directional Horizontal Pleiotropy

|outcome    |exposure | egger_intercept|        se|      pval|
|:----------|:--------|---------------:|---------:|---------:|
|loneliness |F1_Qsnp  |      -0.0017578| 0.0049295| 0.7306186|

- no evidence of directional horizontal pleiotropy 

### Test that F1/NMD QSNP is upstream of loneliness

|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1_Qsnp  |loneliness |       0.0011072|      0.0002447|TRUE                     |1.49x10<sup>-15</sup>|


### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/200128097-e09cecab-fd6a-418d-90d2-4a3b99625254.png)


### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/200128501-af96b0c9-1ef6-490d-9dd8-48bddb7dca88.png)


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
|F1      |loneliness |MR Egger                  |   24|  0.2901209| 0.3827217| 4.56x10<sup>-01</sup>|
|F1      |loneliness |Inverse variance weighted |   24|  0.4898733| 0.0741826| 4.01x10<sup>-11</sup>|
|F1      |loneliness |Weighted mode             |   24|  0.5341551| 0.1095374| 5.93x10<sup>-05</sup>|
|F1      |loneliness |Weighted median           |   24|  0.4828668| 0.0653770| 1.24x10<sup>-13</sup>|

- MR methods significant and consistent apart from MR Egger 

### Hetereogeneity

|outcome |exposure   |method                    |        Q| Q_df| Q_pval|
|:-------|:----------|:-------------------------|--------:|----:|------:|
|F1      |loneliness |MR Egger                  | 74.76671|   22|  1.15x10<sup>-07</sup>|
|F1      |loneliness |Inverse variance weighted | 75.72983|   23|  1.54x10<sup>-07</sup>|

- evidence of heterogeneity

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

- I<sup>2</sup> of all instruments = 0.970, I2 of weak instruments = 0.970, so there does not seem to be weak instrument bias

---

### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/200129780-c2b8775b-f5c0-4a4f-a21c-bf9cbd5c090b.png)

### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/200129783-ea819f2d-e238-4bbc-b7be-5edcf84f5066.png)

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

- results are still consistent with the original MR analysis, except that the MR Egger Bootstrapped effect is no longer in the negative direction
---

### MR RAPS

- beta hat (causal effect) = 0.5128462
- beta se = 0.06853184
- beta p value = 7.238654e-14

---

## NMD/F1 Qsnp to Loneliness with Reduced p-value threshold

## F1 QSNP MR Results with Reduced p-value threshold
- clumping parameters: r<sup>2</sup> < 0.001, kb = 10,000
- p-value threshold: p < 5x10<sup>-07</sup>
- 19 instruments

---

### Two Sample MR Results

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |   19| 0.2059939| 0.2780956| 4.69x10<sup>-01</sup>|
|loneliness |F1_Qsnp  |Inverse variance weighted |   19| 0.3466251| 0.0548549| 2.63x10<sup>-10</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |   19| 0.3661856| 0.0769367| 1.58x10<sup>-04</sup>|
|loneliness |F1_Qsnp  |Weighted median           |   19| 0.3358195| 0.0520162| 1.53x10<sup>-10</sup>|

- significant and consistent results across MR methods except for MR Egger 

### Heterogeneity

|outcome    |exposure |method                    |        Q| Q_df|   Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|--------:|
|loneliness |F1_Qsnp  |MR Egger                  | 48.75725|   17| 6.57x10<sup>-05</sup>|
|loneliness |F1_Qsnp  |Inverse variance weighted | 49.52169|   18| 8.91x10<sup>-05</sup>|

- there is evidence of heterogeneity

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

- I<sup>2</sup> all instruments = .964, I<sup>2</sup> weak instruments = .962, so no weak instrument bias

### Testing that F1 QSNP is upstream of loneliness
|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1_Qsnp  |loneliness |       0.0018235|       0.000444|TRUE                     |            0|

### Forest Plot

![image](https://user-images.githubusercontent.com/68326791/200130925-28aa36b7-e8fa-417e-aca9-49bd8e4c5302.png)

### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/200130961-1bf2642f-6e7f-4607-8ab2-04113dac6e27.png)


### MR Steiger

- 1 SNP found to be operating in the incorrect direction

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1_Qsnp  |MR Egger                  |   18| 0.4306750| 0.2357781| 0.0864743|
|loneliness |F1_Qsnp  |Inverse variance weighted |   18| 0.3222953| 0.0448503| 6.67x10<sup>-13</sup>|
|loneliness |F1_Qsnp  |Weighted mode             |   18| 0.3650974| 0.0829786| 0.0003913|
|loneliness |F1_Qsnp  |Weighted median           |   18| 0.3330525| 0.0503948| 3.87x10<sup>-11</sup>|

- even though the effect estimates have increased slightly, the pattern of results is mostly the sam 

### MR Raps

- MR Raps indicates a significant causal effect from F1 Qsnp to Loneliness

- beta hat (causal effect) = .358
- beta se = 0.0497
- beta p value = 1.33e-15

