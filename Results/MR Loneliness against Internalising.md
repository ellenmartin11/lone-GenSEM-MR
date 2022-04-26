

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
|puZ4MB      |MB5zG3     |loneliness |internalising |6.882232e-05    |1.413843e-06   |TRUE                     |0.001305355  |
|puZ4MB      |MB5zG3     |loneliness |internalising |7.55431e-05     |3.600965e-06   |TRUE                     |0.002117355  |
|puZ4MB      |MB5zG3     |loneliness |internalising |7.269648e-05    |3.263003e-05   |TRUE                     |0.2030444    |
|puZ4MB      |MB5zG3     |loneliness |internalising |6.711018e-05    |1.50147e-06    |TRUE                     |0.001624853  |
|puZ4MB      |MB5zG3     |loneliness |internalising |7.46318e-05     |3.305729e-05   |TRUE                     |0.19119      |
|puZ4MB      |MB5zG3     |loneliness |internalising |6.923491e-05    |1.846996e-06   |TRUE                     |0.001637526  |

- MR with Steiger Filtering (very similar to original MR)

|id.exposure |id.outcome |outcome       |exposure   |method                    | nsnp|         b|        se|      pval|
|:-----------|:----------|:-------------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|puZ4MB      |MB5zG3     |internalising |loneliness |MR Egger                  |  133| 1.0804870| 0.4600482| 0.0203383|
|puZ4MB      |MB5zG3     |internalising |loneliness |Weighted median           |  133| 0.2255302| 0.0239481| 0.0000000|
|puZ4MB      |MB5zG3     |internalising |loneliness |Inverse variance weighted |  133| 0.2375566| 0.0216460| 0.0000000|
|puZ4MB      |MB5zG3     |internalising |loneliness |Simple mode               |  133| 0.1754546| 0.0539756| 0.0014613|
|puZ4MB      |MB5zG3     |internalising |loneliness |Weighted mode             |  133| 0.1819925| 0.0530992| 0.0008130|
