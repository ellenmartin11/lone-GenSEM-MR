

# Bidirectional MR

---

## loneliness against F1

Date: **26 April, 2022**

---

### Results from two sample MR:


|method                    | nsnp|         b|        se|      pval|
|:-------------------------|----:|---------:|---------:|---------:|
|MR Egger                  |  133| 1.0804870| 0.4600482| 0.0203383|
|Weighted median           |  133| 0.2255302| 0.0238316| 0.0000000|
|Inverse variance weighted |  133| 0.2375566| 0.0216460| 0.0000000|
|Simple mode               |  133| 0.1754546| 0.0531232| 0.0012320|
|Weighted mode             |  133| 0.1819925| 0.0538574| 0.0009562|


### Heterogeneity tests


|method                    |        Q| Q_df|  Q_pval|
|:-------------------------|--------:|----:|-------:|
|MR Egger                  | 214.0721|  131| 6.3e-06|
|Inverse variance weighted | 219.5702|  132| 2.6e-06|


### Test for directional horizontal pleiotropy


| egger_intercept|        se|      pval|
|---------------:|---------:|---------:|
|      -0.0107765| 0.0058751| 0.0688844|


### Test that the loneliness exposure is upstream of the F1 outcome


| snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|---------------:|--------------:|:------------------------|------------:|
|       0.0101694|       0.001122|TRUE                     |            0|

Note - R^2 values are approximate

---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/165383133-a5b1fe04-f906-4d66-a1db-bfb077bc18f0.png)



### Scatter Plot Comparing MR Egger and IVW

![MR_lonelinesstointernalising_IVW_Egger_scatter](https://user-images.githubusercontent.com/68326791/165394642-509ca441-19cc-4cda-9aff-eca9cddafec1.png)

---

### Leave-one-out sensitivity analysis
|         b|         p|
|---------:|---------:|
| 0.8544645| 0.0083827|
| 1.2132926| 0.0617026|

---

### MR Steiger
- Steiger Filtering

|id.exposure |id.outcome |exposure   |outcome       |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:----------|:-------------|:---------------|:--------------|:------------------------|:------------|
|puZ4MB      |MB5zG3     |loneliness |F1            |6.882232e-05    |1.413843e-06   |TRUE                     |0.001305355  |
|puZ4MB      |MB5zG3     |loneliness |F1            |7.55431e-05     |3.600965e-06   |TRUE                     |0.002117355  |
|puZ4MB      |MB5zG3     |loneliness |F1            |7.269648e-05    |3.263003e-05   |TRUE                     |0.2030444    |
|puZ4MB      |MB5zG3     |loneliness |F1            |6.711018e-05    |1.50147e-06    |TRUE                     |0.001624853  |
|puZ4MB      |MB5zG3     |loneliness |F1            |7.46318e-05     |3.305729e-05   |TRUE                     |0.19119      |
|puZ4MB      |MB5zG3     |loneliness |F1            |6.923491e-05    |1.846996e-06   |TRUE                     |0.001637526  |

- MR with Steiger Filtering (very similar to original MR)

|id.exposure |id.outcome |outcome       |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|puZ4MB      |MB5zG3     |F1            |loneliness |MR Egger                  |  133| 1.0804870| 0.4600482| 0.0203383|
|puZ4MB      |MB5zG3     |F1            |loneliness |Weighted median           |  133| 0.2255302| 0.0239481| 0.0000000|
|puZ4MB      |MB5zG3     |F1            |loneliness |Inverse variance weighted |  133| 0.2375566| 0.0216460| 0.0000000|
|puZ4MB      |MB5zG3     |F1            |loneliness |Simple mode               |  133| 0.1754546| 0.0539756| 0.0014613|
|puZ4MB      |MB5zG3     |F1            |loneliness |Weighted mode             |  133| 0.1819925| 0.0530992| 0.0008130|

---
### MR PRESSO
- corrects for the influence of outliers
- in this case, both the raw MR and the outlier-corrected MR results are very similar


|Exposure   |MR Analysis       | Causal Estimate|        Sd|   T-stat| P-value|
|:----------|:-----------------|---------------:|---------:|--------:|-------:|
|loneliness |Raw               |       0.2375566| 0.0216460| 10.97463|       0|
|loneliness |Outlier-corrected |       0.2551023| 0.0191968| 13.28879|       0|


---

## F1 against Loneliness

---

### Results from Two-Sample MR

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|qJTRF1      |UKKKZb     |loneliness |F1       |MR Egger                  |    9| -0.1737334| 0.5206376| 0.7483842|
|qJTRF1      |UKKKZb     |loneliness |F1       |Weighted median           |    9|  0.2337610| 0.0742285| 0.0016371|
|qJTRF1      |UKKKZb     |loneliness |F1       |Inverse variance weighted |    9|  0.0835448| 0.1238827| 0.5000659|
|qJTRF1      |UKKKZb     |loneliness |F1       |Simple mode               |    9|  0.3289754| 0.0945554| 0.0083296|
|qJTRF1      |UKKKZb     |loneliness |F1       |Weighted mode             |    9|  0.2958618| 0.0885858| 0.0102337|


### Heterogeneity Tests

|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|------:|
|qJTRF1      |UKKKZb     |loneliness |F1       |MR Egger                  | 60.75190|    7|      0|
|qJTRF1      |UKKKZb     |loneliness |F1       |Inverse variance weighted | 63.01223|    8|      0|


### Test for directional horizontal pleiotropy

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|qJTRF1      |UKKKZb     |loneliness |F1       |       0.0044256| 0.0086719| 0.6255115|


### Test that the F1 exposure is upstream of loneliness outcome

|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|qJTRF1      |UKKKZb     |F1       |loneliness |        9.81e-05|        3.5e-06|TRUE                     |     0.000281|

---

### MR Steiger

- Steiger Filtered MR !CHECK IF THIS IS CORRECT because it's extremely different and the graphs are extremely different

|id.exposure |id.outcome |exposure |outcome    |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:--------|:----------|:---------------|:--------------|:------------------------|:------------|
|qJTRF1      |UKKKZb     |F1       |loneliness |9.813141e-05    |3.521383e-06   |TRUE                     |0.0002809675 |
|qJTRF1      |UKKKZb     |F1       |loneliness |8.288929e-05    |1.203016e-05   |TRUE                     |0.01078943   |
|qJTRF1      |UKKKZb     |F1       |loneliness |0.0001401907    |5.48707e-05    |TRUE                     |0.04493204   |
|qJTRF1      |UKKKZb     |F1       |loneliness |8.625831e-05    |3.21007e-06    |TRUE                     |0.0006969074 |
|qJTRF1      |UKKKZb     |F1       |loneliness |0.00012688      |5.666129e-05   |TRUE                     |0.0909476    |
|qJTRF1      |UKKKZb     |F1       |loneliness |0.0001036672    |1.623191e-05   |TRUE                     |0.00538071   |

- this is the table produced from directly calculating the R2


|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|qJTRF1      |UKKKZb     |loneliness |F1       |MR Egger                  |    8| 0.4582029| 0.3560016| 0.2454859|
|qJTRF1      |UKKKZb     |loneliness |F1       |Weighted median           |    8| 0.2738640| 0.0702526| 0.0000969|
|qJTRF1      |UKKKZb     |loneliness |F1       |Inverse variance weighted |    8| 0.2277049| 0.0834891| 0.0063843|
|qJTRF1      |UKKKZb     |loneliness |F1       |Simple mode               |    8| 0.3286496| 0.1105886| 0.0207541|
|qJTRF1      |UKKKZb     |loneliness |F1       |Weighted mode             |    8| 0.2952316| 0.0917594| 0.0147053|

---


### Forest Plot of Single SNP MR

![MR_F1toloneliness_forest](https://user-images.githubusercontent.com/68326791/165519300-12f5a809-0fc9-4f0a-be86-e03a4ad04252.png)

- Steiger Forest:

![MR_F1toloneliness_forest_Steig](https://user-images.githubusercontent.com/68326791/165521094-5989095f-609a-4b84-96b8-b630df8d934c.png)


### Scatter Plot

![MR_F1toloneliness_IVW_Egger_scatter](https://user-images.githubusercontent.com/68326791/165519372-4e6f4b08-568b-4c67-9d67-ac9f3abe6afb.png)

- Steiger Scatter

![MR_F1toloneliness_IVW_Egger_scatter_Steig](https://user-images.githubusercontent.com/68326791/165521237-7cab469c-8e72-4536-bc20-24b344cacf17.png)


### Funnel Plot

![DataMR_F1tolonelinessk_funnel_normal](https://user-images.githubusercontent.com/68326791/165521889-545fe0fe-4d57-4991-ade5-efbe84f1240b.png)

- Steiger Funnel

![DataMR_F1tolonelinessk_funnel_Steig](https://user-images.githubusercontent.com/68326791/165521841-a49fc62e-c0f4-441f-8307-a185c2f216ae.png)

---

### Leave-one-out Sensitivity Analysis

|          b|         p|
|----------:|---------:|
| -0.8294634| 0.2454859|
|  0.4582029| 0.9322272|




