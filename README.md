# Genomic Structural Equation Modelling and Mendelian Randomization of Loneliness and Psychiatric/Substance Use Phenotypes

This documentation briefly outlines the stages of analysis and displays some of the results.

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

![ManHplotGWA](https://user-images.githubusercontent.com/68326791/172226766-16364374-c4b4-4c77-86bb-f5258e5faa29.PNG)


|GWAS        | N (sample)| included SNPs| number of LD-independent genome-wide SNPs|smallest p-value | SNPs (shared)| SNPs (non-shared)|
|:-----------|----------:|-------------:|-----------------------------------------:|:----------------|-------------:|-----------------:|
|F1          |     378372|       1968630|                                        22|5.6e-14          |             5|                17|
|Loneliness  |     445024|       1968630|                                        18|3.8e-17          |            18|                 0|

### Bidirectional Mendelian Randomization
- [Mendelian Randomization Report and Plots](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/Bidirectional%20Mendelian%20Randomization%20Lone%20and%20F1.md)
- [Mendelian Randomization Analysis Script](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/Mendelian%20Randomisation.md)
- this also includes sensitivity tests 
- Loneliness on F1

|outcome |exposure   |method                    | nsnp|         b|        se|      pval|
|:-------|:----------|:-------------------------|----:|---------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   18| 0.6062202| 0.2340154| 0.0197169|
|F1      |loneliness |Inverse variance weighted |   18| 0.5219772| 0.0444478| 0.0000000|
|F1      |loneliness |Simple mode               |   18| 0.6509311| 0.1302015| 0.0001097|
|F1      |loneliness |Weighted median           |   18| 0.5116992| 0.0685280| 0.0000000|

- F1 on Loneliness

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   20| -0.0351787| 0.3222680| 0.9142834|
|loneliness |F1       |Weighted median           |   20|  0.3247741| 0.0527980| 0.0000000|
|loneliness |F1       |Inverse variance weighted |   20|  0.1953648| 0.0772606| 0.0114503|
|loneliness |F1       |Simple mode               |   20|  0.3682482| 0.0674862| 0.0000290|
|loneliness |F1       |Weighted mode             |   20|  0.3583561| 0.0687201| 0.0000493|

- Plot of loneliness on F1

![image](https://user-images.githubusercontent.com/68326791/172142549-ad867979-2182-43fb-a972-80dd641c64b4.png)
