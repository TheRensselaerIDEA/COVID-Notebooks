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

###Had trouble with looping so just hardcoded for the time being###


#Split data by state
aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart<-readRDS('CDCimputincluded_062120_data.Rds')
statesplit<-split(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart,aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart$state)


##Alabama##

AL.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                                    + factor(q_popdensity)
                                    + scale(log(medhouseholdincome))
                                    +scale(pct_obesity)
                                    +scale(pct_age65)+scale(pct_diabetes)
                                    +scale(LungCancer)
                                    +scale(AdultChronicLungDisease)
                                    +scale(COPD)
                                    +scale(AdultAsthma)
                                    +scale(PediatricAsthma)
                                    +scale(Despair.death_rate)
                                    +scale(All.Cause.death_rate)
                                    +scale(Cardiovascular.death_rate)
                                    + offset(log(population)), data = statesplit$AL)
summary(AL.model)
summary<-summary(AL.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix
###
AL.C<-summary(AL.model)[12]$coefficients[1:22,1]
#p-value
AL.P<-summary(AL.model)[12]$coefficients[1:22,4]
#adding to df
State.results<-cbind(State.results,AL.C,AL.P)

##Arkansas
AR.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$AR)
summary(AR.model)
summary<-summary(Arkansas.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix
###

##Arizona##

AZ.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$AZ)
summary(AZ.model)
summary<-summary(AZ.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix
###exponentiated coeff
AZ.C<-exp(summary(AZ.model)[12]$coefficients[1:22,1])
#p-value
AZ.P<-summary(AZ.model)[12]$coefficients[1:22,4]


###California##
CA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$CA)
summary(CA.model)
summary<-summary(CA.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###Colorado##
CO.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$CO)
summary(CO.model)
summary<-summary(CO.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

#Connecticut
CT.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$CT)
summary(CT.model)
summary<-summary(CT.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

#DC
DC.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$DC)
summary(DC.model)
summary<-summary(DC.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

#Delaware
DE.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$DE)
summary(DE.model)
summary<-summary(DE.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


#Florida
FL.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$FL)
summary(FL.model)
summary<-summary(FL.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Georgia

GA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$GA)
summary(GA.model)
summary<-summary(GA.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

#Iowa
IA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$IA)
summary(IA.model)
summary<-summary(Iowa.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


##Idaho
ID.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$ID)
summary(ID.model)
summary<-summary(ID.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

#Illinois
IL.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$IL)
summary(IL.model)
summary<-summary(IL.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Indiana
IN.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$IN)
summary(IN.model)
summary<-summary(IN.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###Kansas
KS.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$KS)
summary(KS.model)
summary<-summary(KS.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Kentucky 

KY.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$KY)
summary(KY.model)
summary<-summary(KY.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Louisiana

LA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$LA)
summary(LA.model)
summary<-summary(LA.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Massachusetts
Massachusetts.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$MA)
summary(Massachusetts.model)
summary<-summary(Massachusetts.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Maryland
MD.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$MD)
summary(MD.model)
summary<-summary(MD.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Maine
ME.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$ME)
summary(ME.model)
summary<-summary(ME.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Mississippi
MI.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))
                       +scale(pct_obesity)
                       +scale(pct_age65)+scale(pct_diabetes)
                       +scale(LungCancer)
                       +scale(AdultChronicLungDisease)
                       +scale(COPD)
                       +scale(AdultAsthma)
                       +scale(PediatricAsthma)
                       +scale(Despair.death_rate)
                       +scale(All.Cause.death_rate)
                       +scale(Cardiovascular.death_rate)
                       + offset(log(population)), data = statesplit$MI)
summary(MI.model)
summary<-summary(MI.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

##Minnesota
MN.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$MN)
summary(MN.model)
summary<-summary(MN.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###Missori
MO.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$MO)
summary(MO.model)
summary<-summary(MO.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

##MS
MS.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$MS)
summary(MS.model)
summary<-summary(MS.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###MT
MT.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$MT)
summary(MT.model)
summary<-summary(MT.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###NC
NC.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NC)
summary(NC.model)
summary<-summary(NC.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###ND
ND.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$ND)
summary(ND.model)
summary<-summary(ND.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###NE
NE.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NE)
summary(NE.model)
summary<-summary(NE.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###NH
NH.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NH)
summary(NH.model)
summary<-summary(NH.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###NJ
NJ.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NJ)
summary(NJ.model)
summary<-summary(NJ.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###NM

NM.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NM)
summary(NM.model)
summary<-summary(NM.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###NV
NV.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NV)
summary(NV.model)
summary<-summary(NV.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###NY
NY.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$NY)
summary(NY.model)
summary<-summary(NY.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###OH
OH.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$OH)
summary(OH.model)
summary<-summary(OH.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###OK
OK.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$OK)
summary(OK.model)
summary<-summary(OK.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###OR
OR.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$OR)
summary(OR.model)
summary<-summary(OR.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###PA
PA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$PA)
summary(PA.model)
summary<-summary(PA.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###RI
RI.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$RI)
summary(RI.model)
summary<-summary(RI.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###SC
SC.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$SC)
summary(SC.model)
summary<-summary(SC.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


##SD
SD.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$SD)
summary(SD.model)
summary<-summary(SD.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###TN
TN.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$TN)
summary(TN.model)
summary<-summary(TN.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###TX
TX.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$TX)
summary(TX.model)
summary<-summary(TX.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###UT
UT.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$UT)
summary(UT.model)
summary<-summary(UT.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###VA
VA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$VA)
summary(VA.model)
summary<-summary(VA.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###VT
VT.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$VT)
summary(VT.model)
summary<-summary(VT.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


###WA
WA.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$WA)
summary(WA.model)
summary<-summary(WA.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix


##WI
WI.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$WI)
summary(WI.model)
summary<-summary(WI.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###WV
WV.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$WV)
summary(WV.model)
summary<-summary(WV.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix

###WY
WY.model<- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                  + factor(q_popdensity)
                  + scale(log(medhouseholdincome))
                  +scale(pct_obesity)
                  +scale(pct_age65)+scale(pct_diabetes)
                  +scale(LungCancer)
                  +scale(AdultChronicLungDisease)
                  +scale(COPD)
                  +scale(AdultAsthma)
                  +scale(PediatricAsthma)
                  +scale(Despair.death_rate)
                  +scale(All.Cause.death_rate)
                  +scale(Cardiovascular.death_rate)
                  + offset(log(population)), data = statesplit$WY)
summary(WY.model)
summary<-summary(WY.model)[12]$coefficients[1:22,1]
coefficient.matrix<-exp(summary)
coefficient.matrix




