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
datafile = './Preprocessing_FTS_Outputs/04-26-2020data.Rds'

aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart<-readRDS(datafile)

# aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart <- subset(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart, 
#                                                                       select = c(Deaths, `% Hispanic`, `% Black`, `% Asian`, `% Non-Hispanic White`, `% Native Hawaiian/Other Pacific Islander`, q_popdensity, 
#                                                                                  `Median Household Income`, date_since_social, date_since, date_since_reopen, date_since_reclosure, date_since_mask, 
#                                                                                  pct_obesity, pct_age65, pct_diabetes, LungCancer, COPD, AdultAsthma, PediatricAsthma, All.Cause.death_rate, state, population))

combined.mode.nb.random.off.main = glmer.nb(Deaths ~ scale(`% Hispanic`) + scale(`% Black`) + scale(`% Asian`) 
                                            + scale(`% Non-Hispanic White`) + scale(`% Native Hawaiian/Other Pacific Islander`)
                                            + factor(q_popdensity)
                                            + scale(log(`Median Household Income`))
                                            + scale(date_since_social) + scale(date_since) 
                                            # + scale(date_since_reopen)
                                            # + scale(date_since_reclosure) 
                                            + scale(date_since_mask)
                                            + scale(pct_obesity)
                                            + scale(pct_age65) + scale(pct_diabetes)
                                            + scale(LungCancer)
                                            + scale(COPD)
                                            + scale(AdultAsthma)
                                            + scale(PediatricAsthma)
                                            + scale(All.Cause.death_rate)
                                            + (1|state)
                                            + offset(log(population)), data = aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart)
# save results in parallelism
date = substr(datafile, 29,33)
assign(date, summary(combined.mode.nb.random.off.main))
fname = paste("./TemporalResults/NationalModel/",date,".rda",sep="")
do.call(save, list(date, file=fname))
