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
F1 = Neurodevelopmental and Mood Disorders (NMD); F2 = Substance Use Traits (SUT); F3 = Disorders with Psychotic Features (DPF)

![image](https://user-images.githubusercontent.com/68326791/187250270-0fe8c239-0aa5-48be-b3d4-b4e5d1116352.png)

- The supplemental figure without path constraints (negative associations between LONE and F2/SUT and LONE and F3/DPF) - the * indicates no statistical significance at 0.05
![image](https://user-images.githubusercontent.com/68326791/187250423-2ab106c7-5c0c-4ddc-b5ca-d88d4f0e669a.png)

### [Multivariate GWAS](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEMcluster.sh) (conducted via GenomicSEM using the UCL Myriad Cluster)

![ManHplotGWA](https://user-images.githubusercontent.com/68326791/172226766-16364374-c4b4-4c77-86bb-f5258e5faa29.PNG)


|GWAS        | N (sample)| included SNPs| number of LD-independent genome-wide SNPs|smallest p-value | SNPs (shared)| SNPs (non-shared)|
|:-----------|----------:|-------------:|-----------------------------------------:|:----------------|-------------:|-----------------:|
|F1/NMD         |     378372|       1968630|                                        22|5.6e-14          |             5|                17|
|Loneliness  |     445024|       1968630|                                        18|3.8e-17          |            18|                 0|

### Bidirectional Mendelian Randomization
- [Mendelian Randomization Report and Plots](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/Bidirectional%20Mendelian%20Randomization%20Lone%20and%20F1.md)
- [Mendelian Randomization Analysis Script](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/Mendelian%20Randomisation.md)
- this also includes sensitivity tests 

- Loneliness to F1/NMD

|outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |   11|  0.5443916| 0.2789841| 8.28x10<sup>-02</sup>|
|F1      |loneliness |Inverse variance weighted |   11|  0.4956359| 0.0547951| 1.49x10<sup>-19</sup>|
|F1      |loneliness |Weighted mode             |   11|  0.5238836| 0.1343346| 2.96x10<sup>-03</sup>|
|F1      |loneliness |Weighted median           |   11|  0.4810642| 0.0803782| 2.16x10<sup>-09</sup>|
|F1      |loneliness |MR Egger (bootstrap)      |   11| -0.1618239| 0.3356590| 3.00x10<sup>-01</sup>|

- F1 to Loneliness

|outcome    |exposure |method                    | nsnp|          b|        se|      pval|
|:----------|:--------|:-------------------------|----:|----------:|---------:|---------:|
|loneliness |F1       |MR Egger                  |   14| -0.2495892| 0.4675338| 6.03x10<sup>-01</sup>|
|loneliness |F1       |Inverse variance weighted |   14|  0.2087931| 0.0983364| 3.37x10<sup>-02</sup>|
|loneliness |F1       |Weighted mode             |   14|  0.3570321| 0.0836802| 9.18x10<sup>-04</sup>|
|loneliness |F1       |Weighted median           |   14|  0.3232340| 0.0604615| 8.99x10<sup>-08</sup>|
|loneliness |F1       |MR Egger (bootstrap)      |   14| -0.2617346| 0.3267510| 1.98x10<sup>-01</sup>|

- Forest plot of loneliness to F1/NMD

![image](https://user-images.githubusercontent.com/68326791/198327856-a6862c01-ce57-4d14-9afa-c40d07eb6a67.png)
