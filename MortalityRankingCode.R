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

#Change Crude Rate to numeric for easier ranking later
count.mortal$`Crude Rate`<-as.numeric(count.mortal$`Crude Rate`)

#Removing "unreliable counties"
reliable.count.mortal<-subset(count.mortal, count.mortal$`Crude Rate` != 'Unreliable')

#Mortality comparison data frame-> comparison of deaths(pop/100k)#############

#mortality comparison data frame
mortal.comp<-data.frame(reliable.count.mortal$`County Code`,reliable.count.mortal$`Crude Rate`)

#adding in covid mortality 
covid.adjustedpop<-(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart$population/100000)
covid.mortal<-(aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart$Deaths/covid.adjustedpop)
scaled.aggregate<-cbind(covid.mortal,aggregate_pm_census_cdc_test_beds_age_diabete_obesity_heart)


#adjusting fips in covid mortality to have same format as mortal.comp
scaled.aggregate$fips<-as.integer(scaled.aggregate$fips)

#covid mortality comparison data frame
covid.comp<-data.frame(scaled.aggregate$fips,scaled.aggregate$covid.mortal)



#combined mortality data frame
combinedmortality=merge(mortal.comp, covid.comp,by.x='reliable.count.mortal..County.Code.',by.y = 'scaled.aggregate.fips',all.x = T)

#NOTE, about 85 counties have missing COVID 19 data, this accounts for that
combinedmortality<-na.omit(combinedmortality)

#ranking############
final.mortal.rank<-rank(combinedmortality$reliable.count.mortal..Crude.Rate.)
covid.rank<-rank(combinedmortality$scaled.aggregate.covid.mortal)

##adjusting covid.rank to start at 1
final.covid.rank<-covid.rank-1076
final.covid.rank[final.covid.rank < 0] <- 1

combinedmortality<-cbind(combinedmortality,final.mortal.rank,final.covid.rank)


#rank delta
rank.delta<-final.mortal.rank-final.covid.rank
combinedmortality<-cbind(combinedmortality,rank.delta)

#graphing rank
ggplot(combinedmortality,aes(x=reliable.count.mortal..County.Code., y=rank.delta)) +geom_point()


#
#graphing 
combinedmortality$factor.reliable.count.mortal..County.Code<-as.factor(combinedmortality$reliable.count.mortal..County.Code.)
ggplot(combinedmortality,aes(x=reliable.count.mortal..County.Code.)) +
  geom_point(aes(y=final.mortal.rank,color ='blue')) +
  geom_point(aes(y=final.covid.rank, color= 'red')) 


#IDENTIFYING counties with declining performance
poor.performance<-combinedmortality[combinedmortality[6]<(-1000),]
poor.performance.county<-poor.performance$reliable.count.mortal..County.Code. 
poor.performance.area<-Mode(stringr::str_extract(poor.performance.county, "^.{2}"))
poor.performance.area

###The state of Georgia has been identified###



