# Genomic Structural Equation Modelling and Mendelian Randomization of Loneliness and Psychiatric/Substance Use Phenotypes

All scripts used for data analysis can be found in [Analysis](https://github.com/ellenmartin11/lone-GenSEM-MR/tree/main/Analysis) and [Results](https://github.com/ellenmartin11/lone-GenSEM-MR/tree/main/Results).

This project uses the [GenomicSEM package](https://github.com/GenomicSEM/GenomicSEM) and scripts from [Schoeler 2021](https://github.com/TabeaSchoeler/TS2021_CommonLiabAddiction).

## [Analysis Scripts](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/analysis.md):
- [Quality Control and Data Preparation Procedures](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20QC.Rmd)
- [Linkage Disequilibrium Score Regression (conducted via GenomicSEM) and Correlation Heatmap](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20LDSC%20and%20Correlations.Rmd)
- [Exploratory Factor Analysis, Confirmatory Factor Analysis, Genomic Structural Equation Modelling](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20Factor%20Analysis%20and%20GSEM.md)
- [Multivariate GWAS](https://github.com/TabeaSchoeler/TS2021_CommonLiabAddiction) (conducted via GenomicSEM using the UCL Myriad Cluster)
- [Mendelian Randomization](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/Mendelian%20Randomisation.md)

## Results:
### LDSC Genetic Correlation
![image](https://user-images.githubusercontent.com/68326791/163831075-aacc035c-ed82-455d-a2ce-25c1f8360a2d.png)

### Confirmatory Factor Analyis and GenomicSEM Path Models
- [The final 3 factor confirmatory factor analysis model loadings](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/CFA3.csv)

- [The multivariate Genomic Structural Equation Model](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/MartinFigure4.pdf) (used for the multivariate GWAS and Mendelian Randomization) and the [Path Diagram](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/MartinFigure4.pdf)
![image](https://user-images.githubusercontent.com/68326791/163831501-86328e1d-d074-4809-aef2-d80b543b1406.png)

### GWA on F1 (Mood and neurodevelopmental latent factor)

![image](https://user-images.githubusercontent.com/68326791/165550787-442404f9-e59d-4df1-9fc4-c030dc68de00.png)

![ManHplot2_commonLiability](https://user-images.githubusercontent.com/68326791/166987952-c4416ae4-2a64-4562-968c-c54c4fdccf26.jpeg)

![image](https://user-images.githubusercontent.com/68326791/165552480-941a8a6f-bb95-4276-858d-1a74efba3b2d.png)

### Bidirectional Mendelian Randomization

|outcome |exposure   |method                    | nsnp|          b|        se|      pval|
|:-------|:----------|:-------------------------|----:|----------:|---------:|---------:|
|F1      |loneliness |MR Egger                  |    4| -1.3373398| 1.3802029| 0.4347899|
|F1      |loneliness |Weighted median           |    4|  0.3164848| 0.1226593| 0.0098745|
|F1      |loneliness |Inverse variance weighted |    4|  0.4086131| 0.1058460| 0.0001132|
|F1      |loneliness |Simple mode               |    4|  0.3061203| 0.1750974| 0.1787344|
|F1      |loneliness |Weighted mode             |    4|  0.2851900| 0.1593545| 0.1714478|

[Mendelian Randomization Report and Plots](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/Bidirectional%20Mendelian%20Randomization%20Lone%20and%20F1.md)


![MR_lonelinesstoF1_forest](https://user-images.githubusercontent.com/68326791/165552941-142c5711-ac39-440e-82d0-5a7df048d834.png)
