

# Bidirectional MR

---

## loneliness to F1

Date: **6 June, 2022**

---

### Results from two sample MR:
|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   18| 0.6062202| 0.2340154| 1.97x10<sup>-02</sup> |
|F1      |loneliness |Inverse variance weighted |   18| 0.5219772| 0.0444478| 7.62x10<sup>-32</sup>|
|F1      |loneliness |Weighted mode             |   18| 0.6053939| 0.1233620| 9.54x10<sup>-05</sup>|
|F1      |loneliness |Weighted median           |   18| 0.5116992| 0.0656303| 1.09x10<sup>-14</sup>|

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

### Leave-one-out Analysis
- Egger

|exposure   |outcome | samplesize|SNP        |         b|        se|         p|
|:----------|:-------|----------:|:----------|---------:|---------:|---------:|
|loneliness |F1      |     378372|rs11867618 | 0.5576534| 0.2519041| 0.0427575|
|loneliness |F1      |     378372|rs1261070  | 0.5290675| 0.2591245| 0.0591716|
|loneliness |F1      |     378372|rs1317149  | 0.6682225| 0.2391420| 0.0136168|
|loneliness |F1      |     378372|rs1439252  | 0.6506272| 0.2380761| 0.0154083|
|loneliness |F1      |     378372|rs1532896  | 0.6123182| 0.2460868| 0.0250819|
|loneliness |F1      |     378372|rs17453775 | 0.5596788| 0.2352478| 0.0310669|
|loneliness |F1      |     378372|rs1966836  | 0.6009321| 0.2416748| 0.0251655|
|loneliness |F1      |     378372|rs1997851  | 0.6242887| 0.2435815| 0.0216348|
|loneliness |F1      |     378372|rs2069117  | 0.6237547| 0.2342195| 0.0177204|
|loneliness |F1      |     378372|rs2126787  | 0.5814242| 0.2415482| 0.0294153|
|loneliness |F1      |     378372|rs2273146  | 0.5562942| 0.2378828| 0.0336195|
|loneliness |F1      |     378372|rs4462992  | 0.5584647| 0.2376492| 0.0328811|
|loneliness |F1      |     378372|rs495146   | 0.6124753| 0.2415084| 0.0228205|
|loneliness |F1      |     378372|rs613872   | 0.7806033| 0.3208836| 0.0279771|
|loneliness |F1      |     378372|rs7044244  | 0.5796282| 0.2413461| 0.0297291|
|loneliness |F1      |     378372|rs7105282  | 0.6595545| 0.2377699| 0.0141864|
|loneliness |F1      |     378372|rs7737302  | 0.6157556| 0.2342586| 0.0189882|
|loneliness |F1      |     378372|rs9388863  | 0.6063277| 0.2428003| 0.0246402|
|loneliness |F1      |     378372|All        | 0.6062202| 0.2340154| 0.019716 |

- IVW

|exposure   |outcome | samplesize|SNP        |         b|        se|  p|
|:----------|:-------|----------:|:----------|---------:|---------:|--:|
|loneliness |F1      |     378372|rs11867618 | 0.5143892| 0.0457711|  0|
|loneliness |F1      |     378372|rs1261070  | 0.5138815| 0.0454951|  0|
|loneliness |F1      |     378372|rs1317149  | 0.5113079| 0.0454429|  0|
|loneliness |F1      |     378372|rs1439252  | 0.5134321| 0.0454403|  0|
|loneliness |F1      |     378372|rs1532896  | 0.5228299| 0.0459919|  0|
|loneliness |F1      |     378372|rs17453775 | 0.5418365| 0.0455787|  0|
|loneliness |F1      |     378372|rs1966836  | 0.5254915| 0.0456760|  0|
|loneliness |F1      |     378372|rs1997851  | 0.5183727| 0.0455545|  0|
|loneliness |F1      |     378372|rs2069117  | 0.5438862| 0.0460882|  0|
|loneliness |F1      |     378372|rs2126787  | 0.5148689| 0.0456292|  0|
|loneliness |F1      |     378372|rs2273146  | 0.5350859| 0.0457251|  0|
|loneliness |F1      |     378372|rs4462992  | 0.5351828| 0.0457762|  0|
|loneliness |F1      |     378372|rs495146   | 0.5191240| 0.0455874|  0|
|loneliness |F1      |     378372|rs613872   | 0.5277503| 0.0469315|  0|
|loneliness |F1      |     378372|rs7044244  | 0.5129681| 0.0461770|  0|
|loneliness |F1      |     378372|rs7105282  | 0.5109996| 0.0454518|  0|
|loneliness |F1      |     378372|rs7737302  | 0.5126381| 0.0455057|  0|
|loneliness |F1      |     378372|rs9388863  | 0.5225120| 0.0459203|  0|
|loneliness |F1      |     378372|All        | 0.5219772| 0.0444478|  0|

### Test that the loneliness exposure is upstream of the F1 outcome

|id.exposure |id.outcome |exposure   |outcome | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:-----------|:----------|:----------|:-------|---------------:|--------------:|:------------------------|------------:|
|vAfkOq      |JtqFLP     |loneliness |F1      |       0.0015155|      0.0004071|TRUE                     |            0|

- Steiger directionality test suggests that we have the correct direction of causal effect from loneliness to F1

### MR Egger Sensitivity Test
|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   93| 0.9035909| 0.3661821| 0.0154724|
|F1      |loneliness |Inverse variance weighted |   93| 0.2953529| 0.0564966| 0.0000002|
|F1      |loneliness |Weighted mode             |   93| 0.6742801| 0.0772064| 0.0000000|
|F1      |loneliness |Weighted median           |   93| 0.5205278| 0.0375445| 0.0000000|

- still significant and consistent across MR methods
- I2 of all instruments = .972, I2 of weaker instruments .973
---

### Forest plot of single SNP MR

![image](https://user-images.githubusercontent.com/68326791/174834547-029ea887-ec97-443c-aa53-5e2beb388b18.png)


### Scatter Plot 

![image](https://user-images.githubusercontent.com/68326791/174834379-fa060ccd-5973-49f3-aeaa-897a1ba57a7f.png)

---

### Steiger Filtering

|id.exposure |id.outcome |exposure   |outcome |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:-----------|:----------|:----------|:-------|:---------------|:--------------|:------------------------|:------------|
|YWuKOa      |HmJIIS     |loneliness |F1      |8.306257e-05    |3.19655e-05    |TRUE                     |0.1176345    |
|YWuKOa      |HmJIIS     |loneliness |F1      |7.72194e-05     |2.913312e-05   |TRUE                     |0.1252601    |
|YWuKOa      |HmJIIS     |loneliness |F1      |6.694028e-05    |3.32602e-05    |TRUE                     |0.2748574    |
|YWuKOa      |HmJIIS     |loneliness |F1      |7.089193e-05    |2.923562e-05   |TRUE                     |0.173049     |
|YWuKOa      |HmJIIS     |loneliness |F1      |8.682598e-05    |2.044539e-05   |TRUE                     |0.03007451   |
|YWuKOa      |HmJIIS     |loneliness |F1      |6.889268e-05    |1.223055e-06   |TRUE                     |0.001140197  |


---

## F1 to Loneliness

---

### Results from Two-Sample MR

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   20| -0.0351787| 0.3222680| 9.14x10<sup>-01</sup>|
|loneliness |F1       |Inverse variance weighted |   20|  0.1953648| 0.0772606| 1.15x10<sup>-02</sup>|
|loneliness |F1       |Weighted mode             |   20|  0.3583561| 0.0648296| 2.71x10<sup>-05</sup>|
|loneliness |F1       |Weighted median           |   20|  0.3247741| 0.0508896| 1.14x10<sup>-10</sup>|

- IVW and the other methods significant apart from Egger

### Heterogeneity Tests

|outcome    |exposure |method                    |        Q| Q_df| Q_pval|
|:----------|:--------|:-------------------------|--------:|----:|------:|
|loneliness |F1       |MR Egger                  | 123.7979|   18|      8.03x10<sup>-18</sup>|
|loneliness |F1       |Inverse variance weighted | 127.5379|   19|      4.26x10<sup>-18</sup>|

- since results do indicate heterogeneity, so we have to refer to Egger

### Test for directional horizontal pleiotropy
|outcome    |exposure | egger_intercept|        se|      pval|
|:----------|:--------|---------------:|---------:|---------:|
|loneliness |F1       |       0.0041158| 0.0055814| 0.4703709|

- there does not seem to be evidence of pleiotropy

### Leave-one-out Analysis
- Egger

|exposure |outcome    | samplesize|SNP        |          b|        se|         p|
|:--------|:----------|:----------|:----------|----------:|---------:|---------:|
|F1       |loneliness |     445024|rs1021363  | -0.0346849| 0.3288408| 0.9172324|
|F1       |loneliness |     445024|rs11663602 | -0.0312597| 0.3309432| 0.9258509|
|F1       |loneliness |     445024|rs12519058 | -0.0111979| 0.3513877| 0.9749487|
|F1       |loneliness |     445024|rs12807357 | -0.0379857| 0.3268809| 0.9088506|
|F1       |loneliness |     445024|rs13197574 | -0.1348601| 0.3527623| 0.7069780|
|F1       |loneliness |     445024|rs13207689 |  0.1558188| 0.3205553| 0.6331098|
|F1       |loneliness |     445024|rs1532279  | -0.1558127| 0.3266486| 0.6394336|
|F1       |loneliness |     445024|rs158179   | -0.1056815| 0.3250705| 0.7490698|
|F1       |loneliness |     445024|rs1592757  |  0.2311593| 0.2669992| 0.3986714|
|F1       |loneliness |     445024|rs17693963 | -0.1616358| 0.3438615| 0.6442852|
|F1       |loneliness |     445024|rs2232423  | -0.1462195| 0.3613261| 0.6907630|
|F1       |loneliness |     445024|rs2568958  | -0.0685018| 0.3300289| 0.8380363|
|F1       |loneliness |     445024|rs4274014  | -0.0366807| 0.3309243| 0.9130389|
|F1       |loneliness |     445024|rs4287126  | -0.0368347| 0.3324400| 0.9130717|
|F1       |loneliness |     445024|rs4632195  |  0.0110153| 0.3220223| 0.9731108|
|F1       |loneliness |     445024|rs7087685  |  0.0228464| 0.3318567| 0.9459169|
|F1       |loneliness |     445024|rs7721129  | -0.0247870| 0.3320426| 0.9413646|
|F1       |loneliness |     445024|rs7807190  | -0.0400872| 0.3324336| 0.9054319|
|F1       |loneliness |     445024|rs8179610  | -0.0118710| 0.3268401| 0.9714499|
|F1       |loneliness |     445024|rs9393707  | -0.0979622| 0.3388554| 0.7760028|
|F1       |loneliness |     445024|All        | -0.0351787| 0.3222680| 0.91428  |

- IVW

|exposure |outcome    | samplesize|SNP        |         b|        se|         p|
|:--------|:----------|:----------|:----------|---------:|---------:|---------:|
|F1       |loneliness |     445024|rs1021363  | 0.1842146| 0.0808643| 0.0227223|
|F1       |loneliness |     445024|rs11663602 | 0.1889514| 0.0808632| 0.0194558|
|F1       |loneliness |     445024|rs12519058 | 0.1891230| 0.0800031| 0.0180814|
|F1       |loneliness |     445024|rs12807357 | 0.1814844| 0.0803279| 0.0238651|
|F1       |loneliness |     445024|rs13197574 | 0.1861237| 0.0814461| 0.0222989|
|F1       |loneliness |     445024|rs13207689 | 0.2300595| 0.0736091| 0.0017755|
|F1       |loneliness |     445024|rs1532279  | 0.2087444| 0.0780566| 0.0074892|
|F1       |loneliness |     445024|rs158179   | 0.2092184| 0.0788525| 0.0079711|
|F1       |loneliness |     445024|rs1592757  | 0.2650645| 0.0632247| 0.0000276|
|F1       |loneliness |     445024|rs17693963 | 0.1803275| 0.0806076| 0.0252795|
|F1       |loneliness |     445024|rs2232423  | 0.1871622| 0.0818435| 0.0222058|
|F1       |loneliness |     445024|rs2568958  | 0.2047017| 0.0804192| 0.0109143|
|F1       |loneliness |     445024|rs4274014  | 0.1996813| 0.0816727| 0.0144894|
|F1       |loneliness |     445024|rs4287126  | 0.1948564| 0.0815147| 0.0168280|
|F1       |loneliness |     445024|rs4632195  | 0.1737931| 0.0777681| 0.0254331|
|F1       |loneliness |     445024|rs7087685  | 0.1819956| 0.0782260| 0.0199900|
|F1       |loneliness |     445024|rs7721129  | 0.1873912| 0.0809617| 0.0206367|
|F1       |loneliness |     445024|rs7807190  | 0.1925195| 0.0812909| 0.0178711|
|F1       |loneliness |     445024|rs8179610  | 0.1790823| 0.0796005| 0.0244640|
|F1       |loneliness |     445024|rs9393707  | 0.1854684| 0.0809110| 0.0218912|
|F1       |loneliness |     445024|All        | 0.1953648| 0.0772606| 0.0114503|

### Test that the F1 exposure is upstream of loneliness outcome

|exposure |outcome    | snp_r2.exposure| snp_r2.outcome|correct_causal_direction | steiger_pval|
|:--------|:----------|---------------:|--------------:|:------------------------|------------:|
|F1       |loneliness |       0.0020098|      0.0004383|TRUE                     |            2.82x10<sup>-27</sup>|

### MR Egger Sensitivity Analyses
- selecting weaker instruments and re-running MR

|id.exposure |id.outcome |outcome    |exposure |method                    | nsnp|         b|        se|    pval|
|:-----------|:----------|:----------|:--------|:-------------------------|----:|---------:|---------:|-------:|
|FiVgWO      |8Fx7jK     |loneliness |F1       |MR Egger                  |   99| 0.2296281| 0.1191998| 0.05698|
|FiVgWO      |8Fx7jK     |loneliness |F1       |Inverse variance weighted |   99| 0.2908296| 0.0212012| 0.00000|
|FiVgWO      |8Fx7jK     |loneliness |F1       |Weighted mode             |   99| 0.3687299| 0.0547427| 0.00000|
|FiVgWO      |8Fx7jK     |loneliness |F1       |Weighted median           |   99| 0.3124483| 0.0214773| 0.00000|

- problem does not seem to be weak SNPS
- I2 all instruments = .968
- I2 weak instruments = .967 

---


### Forest Plot of MR

![image](https://user-images.githubusercontent.com/68326791/174838638-aac2b0b6-8b06-4c61-8b09-8b2e45516e94.png)


### Scatter Plot

![image](https://user-images.githubusercontent.com/68326791/174838823-2535bf28-fbc3-4df7-b530-4ac91c1d6f2e.png)

--- 

### Steiger Filtering
-  correct causal direction

|exposure |outcome    |snp_r2.exposure |snp_r2.outcome |correct_causal_direction |steiger_pval |
|:--------|:----------|:---------------|:--------------|:------------------------|:------------|
|F1       |loneliness |9.277061e-05    |2.081419e-05   |TRUE                     |0.02186975   |
|F1       |loneliness |8.105609e-05    |1.245558e-05   |TRUE                     |0.01330606   |
|F1       |loneliness |8.711655e-05    |1.203016e-05   |TRUE                     |0.007991305  |
|F1       |loneliness |9.386044e-05    |2.631801e-05   |TRUE                     |0.03927085   |
|F1       |loneliness |9.742577e-05    |1.75734e-05    |TRUE                     |0.01022911   |
|F1       |loneliness |8.888098e-05    |2.332567e-05   |TRUE                     |0.0375808    |

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   20| -0.0351787| 0.3222680| 9.14x10<sup>-01</sup>|
|loneliness |F1       |Weighted median           |   20|  0.3247741| 0.0509153| 8.15x10<sup>-11</sup>|
|loneliness |F1       |Inverse variance weighted |   20|  0.1953648| 0.0772606| 1.15x10<sup>-02</sup>|
|loneliness |F1       |Weighted mode             |   20|  0.3583561| 0.0693145| 6.67x10<sup>-05</sup>


