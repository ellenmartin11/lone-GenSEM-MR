# Genomic Structural Equation Modelling and Mendelian Randomization of Loneliness and Psychiatric/Substance Use Phenotypes

All scripts used for data analysis can be found in [Analysis](https://github.com/ellenmartin11/lone-GenSEM-MR/tree/main/Analysis) and [Results](https://github.com/ellenmartin11/lone-GenSEM-MR/tree/main/Results).

This project uses the [GenomicSEM package](https://github.com/GenomicSEM/GenomicSEM) and scripts from [Schoeler 2021](https://github.com/TabeaSchoeler/TS2021_CommonLiabAddiction).

These analyses were carried out in R version 4.0.3 and GenomicSEM version 0.0.2.

## Getting Started
- Refer to the GenomicSEM wiki 
- Install necessary [R Packages](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20QC.Rmd)
- Download necessary software tools, e.g., [PLINK](https://www.cog-genomics.org/plink/)
- Download summary statistics files shown in the analysis scripts

## [Analysis Scripts](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/analysis.md):
### [Quality Control and Data Preparation Procedures](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20QC.Rmd)

### [Linkage Disequilibrium Score Regression (conducted via GenomicSEM) and Correlation Heatmap](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20LDSC%20and%20Correlations.Rmd)
![image](https://user-images.githubusercontent.com/68326791/163831075-aacc035c-ed82-455d-a2ce-25c1f8360a2d.png)

### [Exploratory Factor Analysis, Confirmatory Factor Analysis, Genomic Structural Equation Modelling](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20Factor%20Analysis%20and%20GSEM.md)
- The multivariate Genomic Structural Equation Model (used for the multivariate GWAS and Mendelian Randomization) and the Path Diagram
![image](https://user-images.githubusercontent.com/68326791/167619089-1e1c1a89-ed61-4e92-a342-8bf0d83bbb00.png)
- The supplemental figure without path constraints (negative associations between LONE and F2 and LONE and F3)
![image](https://user-images.githubusercontent.com/68326791/167618348-cf0ef1f8-da99-4731-8489-58c50bdf2781.png)

### [Multivariate GWAS](https://github.com/TabeaSchoeler/TS2021_CommonLiabAddiction) (conducted via GenomicSEM using the UCL Myriad Cluster)
![ManHplot2_commonLiability](https://user-images.githubusercontent.com/68326791/166987952-c4416ae4-2a64-4562-968c-c54c4fdccf26.jpeg)

|GWAS    | N (sample)| included SNPs| number of LD-independent genome-wide SNPs|smallest p-value | SNPs (shared)| SNPs (non-shared)|
|:-------|----------:|-------------:|-----------------------------------------:|:----------------|-------------:|-----------------:|
|F1      |     378755|       1096627|                                        18|3.2e-13          |             3|                15|

### Bidirectional Mendelian Randomization
[Mendelian Randomization Report and Plots](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/Bidirectional%20Mendelian%20Randomization%20Lone%20and%20F1.md)
- [Mendelian Randomization Analysis Script](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/Mendelian%20Randomisation.md)
- this also includes sensitivity tests 
- Loneliness on F1

|outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |    4| -1.3373398| 1.3802029| 0.4347899|
|F1      |loneliness |Weighted median           |    4|  0.3164848| 0.1226593| 0.0098745|
|F1      |loneliness |Inverse variance weighted |    4|  0.4086131| 0.1058460| 0.0001132|
|F1      |loneliness |Simple mode               |    4|  0.3061203| 0.1750974| 0.1787344|
|F1      |loneliness |Weighted mode             |    4|  0.2851900| 0.1593545| 0.1714478|

- F1 on Loneliness

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |    9| -0.1737334| 0.5206376| 0.7483842|
|loneliness |F1       |Weighted median           |    9|  0.2337610| 0.0742285| 0.0016371|
|loneliness |F1       |Inverse variance weighted |    9|  0.0835448| 0.1238827| 0.5000659|
|loneliness |F1       |Simple mode               |    9|  0.3289754| 0.0945554| 0.0083296|
|loneliness |F1       |Weighted mode             |    9|  0.2958618| 0.0885858| 0.0102337|

- Plot of loneliness on F1

![MR_lonelinesstoF1_forest](https://user-images.githubusercontent.com/68326791/165552941-142c5711-ac39-440e-82d0-5a7df048d834.png)
