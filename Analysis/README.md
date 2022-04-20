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
