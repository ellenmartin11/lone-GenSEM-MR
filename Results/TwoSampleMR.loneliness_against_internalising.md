

# Two sample MR report

---

## loneliness against internalising

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

---

### Heterogeneity tests


|method                    |        Q| Q_df|  Q_pval|
|:-------------------------|--------:|----:|-------:|
|MR Egger                  | 214.0721|  131| 6.3e-06|
|Inverse variance weighted | 219.5702|  132| 2.6e-06|

--- 

### Test for directional horizontal pleiotropy


| egger_intercept|        se|      pval|
|---------------:|---------:|---------:|
|      -0.0107765| 0.0058751| 0.0688844|

--- 

### Test that the exposure is upstream of the outcome


| snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|---------------:|--------------:|:------------------------|------------:|
|       0.0101694|       0.001122|TRUE                     |            0|

Note - R^2 values are approximate

---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/165383133-a5b1fe04-f906-4d66-a1db-bfb077bc18f0.png)


---

### Comparison of results using different MR methods

![plot of chunk chunk6](figure/loneliness_against_internalisingchunk6-1.png)

---

### Funnel plot

![plot of chunk chunk7](figure/loneliness_against_internalisingchunk7-1.png)

---

### Leave-one-out sensitivity analysis
|         b|         p|
|---------:|---------:|
| 0.8544645| 0.0083827|
| 1.2132926| 0.0617026|
