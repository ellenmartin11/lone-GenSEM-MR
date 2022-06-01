# Stages of Analysis

## Download Sumstats
- these are available through [GWASatlas](https://atlas.ctglab.nl/) and through the [PGC](https://www.med.unc.edu/pgc/download-results/).

| Phenotype     | Source                 |
| ------------- | ---------------------- |
| ADHD          | [Demontis et al (2018)](https://pubmed.ncbi.nlm.nih.gov/30478444/) |
| ALC           | [Schumann (2016)](https://pubmed.ncbi.nlm.nih.gov/27911795/)       |
| ASD           | [Grove et al (2019)](https://www.biorxiv.org/content/10.1101/224774v2)     |
| ANX           | [Otowa et al (2016)](https://pubmed.ncbi.nlm.nih.gov/26754954/)     |
| BIP           | [Stahl et al (2019)](https://www.med.unc.edu/pgc/download-results/)     |
| CAN           | [Johnson et al (2020)](https://www.med.unc.edu/pgc/download-results/)   |
| LONELINESS    | [Day et al (2018)](https://pubmed.ncbi.nlm.nih.gov/29970889/)       |
| MDD           | [Howard et al (2019)](https://www.med.unc.edu/pgc/download-results/)     |
| PTSD          | [Nievergelt et al (2019)](https://www.med.unc.edu/pgc/download-results/)|
| SCZ           | [Pardinas et al (2018)](https://pubmed.ncbi.nlm.nih.gov/29483656/)  |
| SMK           | Wootton et al (2019)   |

## Data Preprocessing and Quality Control
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20QC.Rmd)
- it includes the general data clean-up and pre-processing as well as munging through GenomicSEM
- importantlty, for the multivariate GWA cluster script to work properly, all odds ratios (OR) must be converted to BETA estimates (which is just log(OR))

## LD Score Regression
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20LDSC%20and%20Correlations.Rmd)
- it includes LDSC executed through GenomicSEM and the production of a correlation heatmap between all the phenotypes using the LDSC output 

## Construction of Latent Genomic Factors
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/GenSEM%20Factor%20Analysis%20and%20GSEM.md)
- it contains the exploratory factor analysis and confirmatory factor analysis 
- the GenomicSEM usermodels were then specified based on the best-fitting model according to [confirmatory factor analysis output](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Results/CFA3.csv)
- the path diagrams were manually generated using Powerpoint and were based on the output of the GenomicSEM usermodels.

## Multivariate GWA
- for detailed analysis steps for multivariate GWA, see [Schoeler (2021)](https://github.com/TabeaSchoeler/TS2021_CommonLiabAddiction/tree/master/analysis)
- This was executed using the UCL High-Performance Cluster, the script for which can be found here. The cluster script is dependent on the R script processingMultiGWA.R
- Multivariate GWA was conducted on F1 (based on the GSEM model which constrained the paths between LONE and F2 and LONE and F3 to be 0)
- a multivariate GWA was conducted only for F1 (mood and neurodevelopmental disorders) as this factor was the only one that remained significantly positively associated with loneliness in multivariate GenomicSEM
- for sanity checks of the F1 GWA, [FUMA](https://fuma.ctglab.nl/) was used

## Mendelian Randomization
- the script for this can be found [Here](https://github.com/ellenmartin11/lone-GenSEM-MR/blob/main/Analysis/Mendelian%20Randomisation.md).
- it includes bidirectional Mendelian Randomisation conducted in R using the [TwoSampleMR](https://mrcieu.github.io/TwoSampleMR/) package alongside sensitivity analyses
- it tests the SNP effects from loneliness (Day et al, 2018) to F1 (output of multivariate GWA) as well as from F1 to loneliness
