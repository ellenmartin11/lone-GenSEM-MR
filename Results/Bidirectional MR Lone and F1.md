

# Bidirectional MR

---

## loneliness against F1

Date: **26 April, 2022**

---

### Results from two sample MR:


|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|QWvjAh      |CUcqLz     |F1      |loneliness |MR Egger                  |    4| -1.3373398| 1.3802029| 0.4347899|
|QWvjAh      |CUcqLz     |F1      |loneliness |Weighted median           |    4|  0.3164848| 0.1226593| 0.0098745|
|QWvjAh      |CUcqLz     |F1      |loneliness |Inverse variance weighted |    4|  0.4086131| 0.1058460| 0.0001132|
|QWvjAh      |CUcqLz     |F1      |loneliness |Simple mode               |    4|  0.3061203| 0.1750974| 0.1787344|
|QWvjAh      |CUcqLz     |F1      |loneliness |Weighted mode             |    4|  0.2851900| 0.1593545| 0.1714478|


### Heterogeneity tests


|id.exposure |id.outcome |outcome |exposure   |method                    |        Q| Q_df|    Q_pval|
|:-----------|:----------|:-------|:----------|:-------------------------|--------:|----:|---------:|
|QWvjAh      |CUcqLz     |F1      |loneliness |MR Egger                  | 2.142708|    2| 0.3425444|
|QWvjAh      |CUcqLz     |F1      |loneliness |Inverse variance weighted | 3.865533|    3| 0.2763550|


### Test for directional horizontal pleiotropy


|id.exposure |id.outcome |outcome |exposure   | egger_intercept|        se|      pval|
|:-----------|:----------|:-------|:----------|---------------:|---------:|---------:|
|QWvjAh      |CUcqLz     |F1      |loneliness |         0.02251| 0.0177509| 0.3324007|


### Test that the loneliness exposure is upstream of the F1 outcome


| snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|---------------:|--------------:|:------------------------|------------:|
|       0.0101694|       0.001122|TRUE                     |            0|

Note - R^2 values are approximate

---

### Forest plot of single SNP MR

![MR_lonelinesstoF1_forest](https://user-images.githubusercontent.com/68326791/165531974-8358deab-c307-46b7-8856-338d94b0da11.png)



### Scatter Plot 

![MR_lonelinesstoF1_IVW_Egger_scatter_](https://user-images.githubusercontent.com/68326791/165532011-bf8e93b9-e312-466f-a959-e7c11752886d.png)


### Funnel Plot

![DataMR_lonelinesstoF1k_funnel](https://user-images.githubusercontent.com/68326791/165532068-b2171958-ff0c-492d-8525-b42ca328eba9.png)

---

### Leave-one-out sensitivity analysis
|          b|         p|
|----------:|---------:|
| -2.2245975| 0.3707499|
| -0.4501856| 0.9110630|

---

### MR Steiger

- Steiger SNPS
|id.exposure |id.outcome |exposure   |outcome |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:----------|:-------|:---------------|:--------------|:------------------------|:------------|
|QWvjAh      |CUcqLz     |loneliness |F1      |7.089193e-05    |2.94108e-05    |TRUE                     |0.1752496    |
|QWvjAh      |CUcqLz     |loneliness |F1      |0.0001012337    |5.066085e-06   |TRUE                     |0.0004105067 |
|QWvjAh      |CUcqLz     |loneliness |F1      |7.838155e-05    |6.355604e-06   |TRUE                     |0.004177349  |
|QWvjAh      |CUcqLz     |loneliness |F1      |8.288739e-05    |2.007288e-05   |TRUE                     |0.036465     |


- MR with Steiger Filtering (very similar to original MR)

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|QWvjAh      |CUcqLz     |F1      |loneliness |MR Egger                  |    4| -1.3373398| 1.3802029| 0.4347899|
|QWvjAh      |CUcqLz     |F1      |loneliness |Weighted median           |    4|  0.3164848| 0.1282560| 0.0136021|
|QWvjAh      |CUcqLz     |F1      |loneliness |Inverse variance weighted |    4|  0.4086131| 0.1058460| 0.0001132|
|QWvjAh      |CUcqLz     |F1      |loneliness |Simple mode               |    4|  0.3061203| 0.1872071| 0.2005229|
|QWvjAh      |CUcqLz     |F1      |loneliness |Weighted mode             |    4|  0.2851900| 0.1597900| 0.1722889|



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




