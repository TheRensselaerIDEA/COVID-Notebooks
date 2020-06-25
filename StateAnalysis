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

#FIXED EFFECTS STATE MODEL WITH MASS PACKAGE


#Split data by state
aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart<-readRDS('06-21-2020data.Rds')
statesplit<-split(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart,aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart$state)
Arizona<-statesplit$AZ


####NEW STATE MODEL####

##Arizona##

Arizona.model<- glm.nb(Deaths ~ scale(pct_blk) + factor(q_popdensity)
                      + scale(log(medhouseholdincome))+scale(education)
                      + scale(date_since)
                      + scale(beds/population)+scale(pct_obesity)
                      + scale(pct_age65)+scale(pct_diabetes)
                      + offset(log(population)), data=Arizona)
summary<-(summary(Arizona.model))
coefficient.matrix<-exp(summary[["coefficients"]][1:13])


##STAT TESTS, WILL FIX LATER###
##DISPERSION TEST

Mean<-mean(aggregate_pm_census_cdc_test_beds$Deaths) # calculate mean

Variance<-var(aggregate_pm_census_cdc_test_beds$Deaths) # calculate variance

#Ratio=Dispersion- heavy overdispersion, neg binomial or quasipoisson more appropriate than poisson
Ratio<-(Variance/Mean)
Ratio

#Benjamini-Hochberg, probably need to generalize coeff. term
#Get p-values of each coefficient-replace first coefficient term to see other terms
blk.p.val.list<-summary(mode.nb.random.off.main)[10]$coefficients[2:10,4]
asian.p.val.list<-summary(asian.mode.nb.random.off.main)[10]$coefficients[2:10,4]
white.p.val.list<-summary(white.mode.nb.random.off.main)[10]$coefficients[2:10,4]
native.p.val.list<-summary(native.mode.nb.random.off.main)[10]$coefficients[2:10,4]
hispanic.p.val.list<-summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2:10,4]
combined.p.val.list<-summary(combined.mode.nb.random.off.main)[10]$coefficients[2:14,4]

#BH Multiple Hyp test
#Blk- no change in number of significant terms, FDR=2e-04
blk.MH.test<-BH(p.val.list, alpha = 0.05)
summary(blk.MH.test)
plot(blk.MH.test)

#Asian- no change in number of significant terms, FDR=.0011
asian.MH.test<-BH(asian.p.val.list, alpha = 0.05)
summary(asian.MH.test)
plot(asian.MH.test)

#White- no change in number of significant terms, FDR=3e-04
white.MH.test<-BH(white.p.val.list, alpha = 0.05)
summary(white.MH.test)
plot(white.MH.test)

#Native- no change in number of significant terms, FDR=0
native.MH.test<-BH(native.p.val.list, alpha = 0.05)
summary(native.MH.test)
plot(native.MH.test)

#Hispanic- no change in number of significant terms, FDR=0
hispanic.MH.test<-BH(hispanic.p.val.list, alpha = 0.05)
summary(hispanic.MH.test)
plot(hispanic.MH.test)

#Combined- no change in number of significant terms, FDR=.0014
combined.MH.test<-BH(combined.p.val.list, alpha = 0.05)
summary(combined.MH.test)
plot(combined.MH.test)


#vuong-functional, need to interpret resultsmaybe not necessary?
v <- as.numeric(predict(mode.nb.random.off.main, type="response")>.05)

BiCopVuongClarke(
  v,
  aggregate_pm_census_cdc_test_beds$pct_blk,
  familyset = NA,
  correction = FALSE,
  level = 0.05,
  rotations = TRUE
)



