

# Bidirectional MR

---

## loneliness against F1

Date: **26 April, 2022**

---

### Results from two sample MR:

|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   18| 0.6062202| 0.2340154| 0.0197169|
|F1      |loneliness |Inverse variance weighted |   18| 0.5219772| 0.0444478| 0.0000000|
|F1      |loneliness |Simple mode               |   18| 0.6509311| 0.1302015| 0.0001097|
|F1      |loneliness |Weighted median           |   18| 0.5116992| 0.0685280| 0.0000000|

- All methods are significant

### Heterogeneity tests

|id.exposure |id.outcome |outcome |exposure   |method                    |        Q| Q_df|    Q_pval|
|:-----------|:----------|:-------|:----------|:-------------------------|--------:|----:|---------:|
|vAfkOq      |JtqFLP     |F1      |loneliness |MR Egger                  | 15.98945|   16| 0.4536972|
|vAfkOq      |JtqFLP     |F1      |loneliness |Inverse variance weighted | 16.12390|   17| 0.5150694|

- since Q is low and not statistically significant, we can assume homogeneity

### Test for directional horizontal pleiotropy


|id.exposure |id.outcome |outcome |exposure   | egger_intercept|        se|      pval|
|:-----------|:----------|:-------|:----------|---------------:|---------:|---------:|
|vAfkOq      |JtqFLP     |F1      |loneliness |      -0.0012102| 0.0033005| 0.7186737|

- test for pleiotropy suggests no horizontal pleiotropy

### Test that the loneliness exposure is upstream of the F1 outcome


|id.exposure |id.outcome |exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|vAfkOq      |JtqFLP     |loneliness |F1      |       0.0015155|      0.0004071|TRUE                     |            0|

- Steiger directionality test suggests that we have the correct direction of causal effect from loneliness to F1

---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/172142549-ad867979-2182-43fb-a972-80dd641c64b4.png)


### Scatter Plot 



### Funnel Plot


---

### Leave-one-out sensitivity analysis

---

### MR Steiger

- This is useful for detecting any reverse causation in genetic instruments, which could have biased the MR estimate
- Steiger filtering assumes that the instrument, if truly valid, should explain more variance in the exposure than the outcome, otherwise it removes such variants

- MR with Steiger Filtering (very similar to original MR) run on Steiger filtered SNPs

|id.exposure |id.outcome |outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|vAfkOq      |JtqFLP     |F1      |loneliness |MR Egger                  |   18| 0.6062202| 0.2340154| 0.0197169|
|vAfkOq      |JtqFLP     |F1      |loneliness |Weighted median           |   18| 0.5116992| 0.0641672| 0.0000000|
|vAfkOq      |JtqFLP     |F1      |loneliness |Inverse variance weighted |   18| 0.5219772| 0.0444478| 0.0000000|
|vAfkOq      |JtqFLP     |F1      |loneliness |Simple mode               |   18| 0.6509311| 0.1345771| 0.0001544|
|vAfkOq      |JtqFLP     |F1      |loneliness |Weighted mode             |   18| 0.6053939| 0.1253192| 0.0001564|

- the results are quite consistent with original MR, suggesting that it is unlikely for reverse causation of genetic instruments to have biased the IVW MR estimate

---

## F1 to Loneliness

---

### Results from Two-Sample MR

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |    9| -0.1737334| 0.5206376| 0.7483842|
|loneliness |F1       |Weighted median           |    9|  0.2337610| 0.0742285| 0.0016371|
|loneliness |F1       |Inverse variance weighted |    9|  0.0835448| 0.1238827| 0.5000659|
|loneliness |F1       |Simple mode               |    9|  0.3289754| 0.0945554| 0.0083296|
|loneliness |F1       |Weighted mode             |    9|  0.2958618| 0.0885858| 0.0102337|

- neither IVW or Egger are significant, suggesting that the correct causal direction is likely to be Loneliness to F1 rather than F1 to Loneliness

### Heterogeneity Tests


|         |method                    |        Q| Q_df| Q_pval|
|:--------|:-------------------------|--------:|----:|------:|
|F1       |MR Egger                  | 60.75190|    7|      0|
|F1       |Inverse variance weighted | 63.01223|    8|      0|


- since results do indicate heterogeneity, we have to refer to MR Egger instead of IVW, which is not significant either way


### Test for directional horizontal pleiotropy

|outcome    |exposure | egger_intercept|        se|      pval|
|:----------|:--------|---------------:|---------:|---------:|
|loneliness |F1       |       0.0044256| 0.0086719| 0.6255115|

- there does not seem to be evidence of pleiotropy

### Test that the F1 exposure is upstream of loneliness outcome

|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1       |loneliness |       0.0010096|      0.0004938|TRUE                     |     1.53e-05|

- Steiger seems to suggest correct causal direction from F1 to Loneliness 
---

### MR Steiger

- Steiger SNPS

|exposure |outcome    |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:--------|:----------|:---------------|:--------------|:------------------------|:------------|
|F1       |loneliness |9.813141e-05    |8.502824e-06   |TRUE                     |0.001566527  |
|F1       |loneliness |8.288929e-05    |2.904829e-05   |TRUE                     |0.09287999   |
|F1       |loneliness |0.0001401907    |0.0001324908   |TRUE                     |0.881412     |
|F1       |loneliness |8.625831e-05    |7.75112e-06    |TRUE                     |0.003262243  |
|F1       |loneliness |0.00012688      |0.0001368143   |FALSE                    |0.8448159    |
|F1       |loneliness |0.0001036672    |3.919389e-05   |TRUE                     |0.07609016   |

- MR Steiger

|outcome    |exposure |method                    | nsnp|         b|        se|      pval|
|:----------|:--------|:-------------------------|----:|---------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |    8| 0.4582029| 0.3560016| 0.2454859|
|loneliness |F1       |Weighted median           |    8| 0.2738640| 0.0751421| 0.0002678|
|loneliness |F1       |Inverse variance weighted |    8| 0.2277049| 0.0834891| 0.0063843|
|loneliness |F1       |Simple mode               |    8| 0.3286496| 0.1014612| 0.0142696|
|loneliness |F1       |Weighted mode             |    8| 0.2952316| 0.0918087| 0.0147405|

- As the Steiger results are very different to the initial MR, there seems to be some bias due to revere causation
- However, Mr Egger is still not significant according to MR Steiger
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

---


