# Polygenic resilience score may be sensitive to preclinical Alzheimer's disease changes.

## Abstract
Late-onset Alzheimer's disease (LOAD) is a polygenic disorder with a long prodromal phase, making early diagnosis challenging. Twin studies estimate LOAD as 60-80% heritable, and while common genetic variants can account for 30% of this heritability, nearly 70% remains "missing". Polygenic risk scores (PRS) leverage combined effects of many loci to predict LOAD risk, but often lack sensitivity to preclinical disease changes, limiting clinical utility. Our group has built and published on a resilience phenotype to model better-than-expected cognition give amyloid pathology burden and hypothesized it may assist in preclinical polygenic risk prediction. Thus, we built a LOAD PRS and a resilience PRS and evaluated both in predicting cognition in a dementia-free cohort (N=254). The LOAD PRS had a significant main effect on baseline memory (β=-0.18, P=1.68E-03). Both the LOAD PRS (β=-0.03, P=1.19E-03) and the resilience PRS (β=0.02, P=0.03) had significant main effects on annual memory decline. The resilience PRS interacted with CSF Aβ on baseline memory (β=-6.04E-04, P=0.02), whereby it predicted baseline memory among Aβ+ individuals (β=0.44, P=0.01) but not among Aβ- individuals (β=0.06, P=0.46). Excluding APOE from PRS resulted in mainly LOAD PRS associations attenuating, but notably the resilience PRS interaction with CSF Aβ and selective prediction among Aβ+ individuals was consistent. Although the resilience PRS is currently somewhat limited in scope from the phenotype's cross-sectional nature, our results suggest that the resilience PRS may be a promising tool in assisting in preclinical disease risk prediction among dementia-free and Aβ+ individuals, though replication and fine-tuning are needed.

## Software Tools

GWAS summary stats liftover: `liftOver`, PRS generation: `PLINK` (profile function)

Please see this Github [repository](https://github.com/VUMC-VMAC/PRS) which contains detail scripts and information on the standardized polygenic risk score (PRS) pipeline leveraged by our Computational Neurogenomics Team.   

## Acknowledgement
Standardized polygenic risk score pipeline was created by Emily Mahoney and validated by Jaclyn Eissman.

GWAS summary statistics were obtained from [Dumitrescu et al., 2020](https://academic.oup.com/brain/article/143/8/2561/5897112?login=false) and [Kunkle et al, 2019](https://www.nature.com/articles/s41588-019-0358-2).

Genetic, biomarker, cognitive data from this study was obtained from the [Vanderbilt Memory & Alzheimer's Center's](https://www.vumc.org/vmac/home) in-house longitudinal, clincial cohort, the [Vandebrilt Memory & Aging Project](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4866875/) (VMAP).

## Citation

Please cite the following paper:

Eissman JM, Wells G, Khan OA, Liu D, Petyuk VA, Gifford KA, Dumitrescu L, Jefferson AL, Hohman TJ. Polygenic resilience score may be sensitive to preclinical Alzheimer's disease changes. Pac Symp Biocomput. 2023;28:449-460. PMID: 36540999; PMCID: PMC9888419.

## Contact

For questions, comments, or data inquiries, please email corresponding author, Timothy Hohman, Ph.D. at timothy.j.hohman@vumc.org.
