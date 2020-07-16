knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

library("MASS")
library("lme4")
library("glmmTMB")
library("gamm4")
library('caret')
library('blmeco')
library(pROC)
library(VineCopula)
library("PerformanceAnalytics")
library(glmmTMB)
library(ggplot2)
library(cvms)
library(sgof)
library(tidyverse)
library(kableExtra)

# set datafile from parallelism
# args <- commandArgs()
# datafile = args[6]

# set datefile by hand
# datafile = '07-05-2020data-2.Rds'
datafile = './Preprocessing_FTS_outputs/07-05-2020data.Rds'

aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart<-readRDS(datafile)


combined.mode.nb.random.off.main = glmer.nb(Deaths ~ scale(`% Hispanic`) + scale(`% Black`) + scale(`% Asian`) + scale(`% Non-Hispanic White`) + scale(`% Native Hawaiian/Other Pacific Islander`)
                                            + factor(q_popdensity)
                                            + scale(log(`Median Household Income`))
                                            + scale(date_since_social) + scale(date_since) + scale(date_since_reopen)
                                            +scale(date_since_reclosure)+scale(date_since_mask)
                                            +scale(pct_obesity)
                                            +scale(pct_age65)+scale(pct_diabetes)
                                            +scale(LungCancer)
                                            +scale(COPD)
                                            +scale(AdultAsthma)
                                            +scale(PediatricAsthma)
                                            +scale(All.Cause.death_rate)
                                            + (1|State)
                                            + offset(log(population)), data = aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart)
# save results in parallelism
date = substr(datafile, 28,32)
assign(date, summary(mode.nb.random.off.combined))
fname = paste("./TemporalResults/NationalModel/",date,".rda",sep="")
do.call(save, list(date, file=fname))

# save results by hand
# combined.summary.July8<-summary(combined.mode.nb.random.off.main)
# saveRDS(combined.summary.July8, file = 'combined.summary.July8')
