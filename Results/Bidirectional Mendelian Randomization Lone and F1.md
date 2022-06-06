

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

![image](https://user-images.githubusercontent.com/68326791/172147388-f43daff9-169c-4e8d-99cf-0a9a88ac7854.png)

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

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|zayTw0      |70zEQu     |loneliness |F1       |MR Egger                  |   20| -0.0351787| 0.3222680| 0.9142834|
|zayTw0      |70zEQu     |loneliness |F1       |Weighted median           |   20|  0.3247741| 0.0527980| 0.0000000|
|zayTw0      |70zEQu     |loneliness |F1       |Inverse variance weighted |   20|  0.1953648| 0.0772606| 0.0114503|
|zayTw0      |70zEQu     |loneliness |F1       |Simple mode               |   20|  0.3682482| 0.0674862| 0.0000290|
|zayTw0      |70zEQu     |loneliness |F1       |Weighted mode             |   20|  0.3583561| 0.0687201| 0.0000493|

- IVW and the other methods significant apart from Egger

### Heterogeneity Tests


|id.exposure |id.outcome |outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:-----------|:----------|:----------|:--------|:-------------------------|--------:|----:|------:|
|zayTw0      |70zEQu     |loneliness |F1       |MR Egger                  | 123.7979|   18|      0|
|zayTw0      |70zEQu     |loneliness |F1       |Inverse variance weighted | 127.5379|   19|      0|


- since results do indicate heterogeneity, so we have to refer to Egger?


### Test for directional horizontal pleiotropy

|id.exposure |id.outcome |outcome    |exposure | egger_intercept|        se|      pval|
|:-----------|:----------|:----------|:--------|---------------:|---------:|---------:|
|zayTw0      |70zEQu     |loneliness |F1       |       0.0041158| 0.0055814| 0.4703709|

- there does not seem to be evidence of pleiotropy

### Test that the F1 exposure is upstream of loneliness outcome

|id.exposure |id.outcome |exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|zayTw0      |70zEQu     |F1       |loneliness |       0.0020098|      0.0004383|TRUE                     |            0|

- Steiger is significant?

---

### MR Steiger

- Steiger SNPS

|id.exposure |id.outcome |exposure |outcome    |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:--------|:----------|:---------------|:--------------|:------------------------|:------------|
|zayTw0      |70zEQu     |F1       |loneliness |9.277061e-05    |2.081419e-05   |TRUE                     |0.02186975   |
|zayTw0      |70zEQu     |F1       |loneliness |8.105609e-05    |1.245558e-05   |TRUE                     |0.01330606   |
|zayTw0      |70zEQu     |F1       |loneliness |8.711655e-05    |1.203016e-05   |TRUE                     |0.007991305  |
|zayTw0      |70zEQu     |F1       |loneliness |9.386044e-05    |2.631801e-05   |TRUE                     |0.03927085   |
|zayTw0      |70zEQu     |F1       |loneliness |9.742577e-05    |1.75734e-05    |TRUE                     |0.01022911   |
|zayTw0      |70zEQu     |F1       |loneliness |8.888098e-05    |2.332567e-05   |TRUE                     |0.0375808    |

- MR Steiger

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|zayTw0      |70zEQu     |loneliness |F1       |MR Egger                  |   20| -0.0351787| 0.3222680| 0.9142834|
|zayTw0      |70zEQu     |loneliness |F1       |Weighted median           |   20|  0.3247741| 0.0515304| 0.0000000|
|zayTw0      |70zEQu     |loneliness |F1       |Inverse variance weighted |   20|  0.1953648| 0.0772606| 0.0114503|
|zayTw0      |70zEQu     |loneliness |F1       |Simple mode               |   20|  0.3682482| 0.0709911| 0.0000524|
|zayTw0      |70zEQu     |loneliness |F1       |Weighted mode             |   20|  0.3583561| 0.0679870| 0.0000436|

- Results are identical to original MR?
---


### Forest Plot of Single SNP MR

![image](https://user-images.githubusercontent.com/68326791/172147611-8c8b4604-c590-41c0-a5bd-3f2430fed187.png)


### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/172147557-48687cee-678c-417c-9ff2-35d924b1e449.png)




