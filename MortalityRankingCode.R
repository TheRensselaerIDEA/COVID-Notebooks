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
library('readxl')
library(ggplot2)

#Loading data- NOTE: some problem with the way the count.mortal sorts highest and lowest.
#I think it might be effecting the ranking system.

count.mortal<-read_excel('USmortalitycounty.xlsx')
aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart<-readRDS('06-21-2020data.Rds')


#Removing "unreliable counties", (saved unreliable fips for later comparison)
unreliable.count.mortal<-subset(count.mortal, count.mortal$`Crude Rate` == 'Unreliable')
reliable.count.mortal<-subset(count.mortal, count.mortal$`Crude Rate` != 'Unreliable')

#Mortality comparison data frame-> comparison of deaths(pop/100k)#############

#mortality comparison data frame
mortal.comp<-data.frame(reliable.count.mortal$`County Code`,reliable.count.mortal$`Age Adjusted Rate`)

#adding in covid mortality 
covid.adjustedpop<-(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart$population/100000)
covid.mortal<-covid.mortal<-(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart$Deaths/covid.adjustedpop)
scaled.aggregate<-cbind(covid.mortal,aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart)

#adjusting fips in covid mortality to have same format as mortal.comp
scaled.aggregate$fips<-as.integer(scaled.aggregate$fips)

#covid mortality comparison data frame
covid.comp<-data.frame(scaled.aggregate$fips,scaled.aggregate$covid.mortal)

#combined mortality data frame
combinedmortality=merge(mortal.comp, covid.comp,by.x='reliable.count.mortal..County.Code.',by.y = 'scaled.aggregate.fips',all.x = T)

#ranking
mortal.rank<-rank(combinedmortality$reliable.count.mortal..Age.Adjusted.Rate.)
covid.rank<-rank(combinedmortality$scaled.aggregate.covid.mortal)
combinedmortality<-cbind(combinedmortality,mortal.rank,covid.rank)
combinedmortality$reliable.count.mortal..County.Code<-as.factor(combinedmortality$reliable.count.mortal..County.Code.)

#graphing raw-needs work
ggplot(combinedmortality,aes(x=reliable.count.mortal..County.Code.)) +
  geom_point(aes(y='mortal.rank',color ='blue')) +
  geom_point(aes(y='covid.rank', color= 'red'))

#rank delta
rank.delta<-mortal.rank-covid.rank
combinedmortality<-cbind(combinedmortality,rank.delta)

#graphing rank
ggplot(combinedmortality,aes(x=reliable.count.mortal..County.Code., y=rank.delta)) +geom_point()

ggplot(combinedmortality,aes(x=reliable.count.mortal..County.Code., y=rank.delta, color=reliable.count.mortal..County.Code)) +geom_point()

