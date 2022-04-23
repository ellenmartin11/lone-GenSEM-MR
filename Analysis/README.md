# Stages of Analysis

## Download Sumstats
- these are available through [GWASatlas](https://atlas.ctglab.nl/) and through the [PGC](https://www.med.unc.edu/pgc/download-results/).

| Phenotype     | Source                 |
| ------------- | ---------------------- |
| ADHD          | Demontis et al (2018)  |
| ALC           | Schumann (2016)        |
| ASD           | Grove et al (2019)     |
| ANX           | Otowa et al (2016)     |
| BIP           | Stahl et al (2019)     |
| CAN           | Johnson et al (2020)   |
| LONELINESS    | Day et al (2018)       |
| MDD           | Howard et al (2019)    |
| PTSD          | Nievergelt et al (2019)|
| SCZ           | Pardinas et al (2018)  |
| SMK           | Wootton et al (2019)   |

## Data Preprocessing and Quality Control
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20QC.Rmd)
- it includes the general data clean-up and pre-processing as well as munging through GenomicSEM

## LD Score Regression
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20LDSC%20and%20Correlations.Rmd)
- it includes LDSC executed through GenomicSEM and the production of a correlation heatmap between all the phenotypes using the LDSC output 

## Construction of Latent Genomic Factors
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20Factor%20Analysis%20and%20GSEM.md)
- it contains the exploratory factor analysis and confirmatory factor analysis 
- the GenomicSEM usermodels were then specified based on the best-fitting model according to [confirmatory factor analysis output](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/CFA3.csv)
- the path diagrams were manually generated and can be found in [Fig 2](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/MartinFigure2.pdf) and [Fig 4](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/MartinFigure4.pdf)

## Multivariate GWAS
- for detailed analysis steps for multivariate GWAS, see [Schoeler (2021)](https://github.com/TabeaSchoeler/TS2021_CommonLiabAddiction/tree/master/analysis)

