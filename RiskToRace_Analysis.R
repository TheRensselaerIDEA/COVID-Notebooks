
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

# Main- mixed effects negative binomial, deaths from percent black to identify risk to specific race
mode.nb.random.off.main = glmer.nb(Deaths ~ pct_blk + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(mode.nb.random.off.main)
MRR_pct_blk<-exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1])
MRR_pct_blk
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
summary(mode.nb.random.off.main)[10]$coefficients[2,4]

#zero-inflated for race- nearly the same result as the main analysis
glmmTMB.off.main = glmmTMB(Deaths ~ pct_blk + factor(q_popdensity)
                           + scale(log(medhouseholdincome))+scale(education)
                           + scale(date_since_social) + scale(date_since)
                           + (1|state) + scale(beds/population) 
                           + offset(log(population)), data = aggregate_pm_census_cdc_test_beds,
                           family = nbinom2, ziformula  = ~ 1)
summary(glmmTMB.off.main)
exp(summary(glmmTMB.off.main)[6]$coefficients$cond[2,1])
exp(summary(glmmTMB.off.main)[6]$coefficients$cond[2,1] - 1.96*summary(glmmTMB.off.main)[6]$coefficients$cond[2,2])
exp(summary(glmmTMB.off.main)[6]$coefficients$cond[2,1] + 1.96*summary(glmmTMB.off.main)[6]$coefficients$cond[2,2])
summary(glmmTMB.off.main)[6]$coefficients$cond[2,4]

# exclude NY Metro- slighlty lower MMR for pct_blk, possibly due to high pct_blk incidence in high mortality area like nyc
mode.nb.random.off.nyc = glmer.nb(Deaths ~ pct_blk + factor(q_popdensity)
                                  + scale(log(medhouseholdincome))+scale(education)
                                  + scale(date_since_social) + scale(date_since)
                                  + (1|state) + scale(beds/population)
                                  + offset(log(population)),data = subset(aggregate_pm_census_cdc_test_beds,!(fips %in% c("09001","42089","36111","09009","36059","36103","34013",
                                                                                               "36079","36081",  "36085",  "36087",  "36119",  "36027",                                                                                                                           "36071",  "09005",  "34021"))))
summary(mode.nb.random.off.nyc)
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
summary(mode.nb.random.off.nyc)[10]$coefficients[2,4]




############MODELS FOR OTHER RACES########################################################

#ASIAN--> huge 95% CI (52.9,63989), MRR= 1840, p val sig.
asian.mode.nb.random.off.main = glmer.nb(Deaths ~ pct_asian + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(asian.mode.nb.random.off.main)
MRR_pct_asian<-exp(summary(asian.mode.nb.random.off.main)[10]$coefficients[2,1])
MRR_pct_asian
exp(summary(asian.mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(asian.mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(asian.mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(asian.mode.nb.random.off.main)[10]$coefficients[2,2])
summary(asian.mode.nb.random.off.main)[10]$coefficients[2,4]

# exclude NY metro (ASIAN)-MRR:1706.2, 95 CI= (53.47,5443),p-value=sig.
mode.nb.random.off.nyc = glmer.nb(Deaths ~ pct_asian + factor(q_popdensity)
                                  + scale(log(medhouseholdincome))+scale(education)
                                  + scale(date_since_social) + scale(date_since)
                                  + (1|state) + scale(beds/population)                           + (1|state)
                                  + offset(log(population)),data = subset(aggregate_pm_census_cdc_test_beds,!(fips %in% c("09001","42089","36111","09009","36059","36103","34013",
                                                                                                                          "36079","36081",  "36085",  "36087",  "36119",  "36027",                                                                                                                           "36071",  "09005",  "34021"))))
summary(mode.nb.random.off.nyc)
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
summary(mode.nb.random.off.nyc)[10]$coefficients[2,4]

#WHITE-MRR=.077, 95% CI=(.048,.122), p val is sig.
white.mode.nb.random.off.main = glmer.nb(Deaths ~ pct_white + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(white.mode.nb.random.off.main)
MRR_pct_white<-exp(summary(white.mode.nb.random.off.main)[10]$coefficients[2,1])
MRR_pct_white
exp(summary(white.mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(white.mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(white.mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(white.mode.nb.random.off.main)[10]$coefficients[2,2])
summary(white.mode.nb.random.off.main)[10]$coefficients[2,4]

#NATIVE- MMR=3.18, 95% CI=(.899,11.28),p-value=.07, not sig.
native.mode.nb.random.off.main = glmer.nb(Deaths ~ pct_native + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(native.mode.nb.random.off.main)
MRR_pct_native<-exp(summary(native.mode.nb.random.off.main)[10]$coefficients[2,1])
MRR_pct_native
exp(summary(native.mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(native.mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(native.mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(native.mode.nb.random.off.main)[10]$coefficients[2,2])
summary(native.mode.nb.random.off.main)[10]$coefficients[2,4]

#HISPANIC- MRR- 1.10, 95% CI= (1.09,1.10), p-value is sig.
hispanic.mode.nb.random.off.main = glmer.nb(Deaths ~ hispanic + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(hispanic.mode.nb.random.off.main)
hispanicMRR<-exp(summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2,1])
hispanicMRR
exp(summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2,2])
summary(hispanic.mode.nb.random.off.main)[10]$coefficients[2,4]


#########ALL RACES COMBINED####################
combined.mode.nb.random.off.main = glmer.nb(Deaths ~ hispanic + pct_blk + pct_asian + pct_white + pct_native
                                            + factor(q_popdensity)
                                            + scale(log(medhouseholdincome))+scale(education)
                                            + scale(date_since_social) + scale(date_since)
                                            + (1|state)+ scale(beds/population) 
                                            + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(combined.mode.nb.random.off.main)
CombinedMRR<-exp(summary(combined.mode.nb.random.off.main)[10]$coefficients[2,1])
CombinedMRR
exp(summary(combined.mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(combined.mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(combined.mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(combined.mode.nb.random.off.main)[10]$coefficients[2,2])
summary(combined.mode.nb.random.off.main)[10]$coefficients[2,4]

###Comparative Graphs########
x<-c("% Black", "%Asian","%White","%Native","%Hispanic")
x<-c(1:5)
y<-c(17.44,1840,.077,3.19,1.1)
y_below<-c(10.27,52.9,0.04,0.899,1.09)
y_above<-c(29.63,63989,0.122,11.28,1.11)
plot(x,y,xlab = "% Black   %Asian   %White   %Native   %Hispanic", ylab="MRR",pch=16,cex=2)
arrows(x0=x, y0=y_below, x1=x, y1=y_above, code=3, angle=90, length=0.1)

#graphs w/o %Asian
x<-c("% Black", "%White","%Native","%Hispanic")
x<-c(1:4)
y<-c(17.44,.077,3.19,1.1)
y_below<-c(10.27,0.04,0.899,1.09)
y_above<-c(29.63,0.122,11.28,1.11)
plot(x,y,xlab = "% Black     %White     %Native     %Hispanic", ylab="MRR",xaxt="none", ylim=c(1,30), pch=16,cex=2)
arrows(x0=x, y0=y_below, x1=x, y1=y_above, code=3, angle=90, length=0.1)
#Assumptions(only for pct_blk model for now) #############################################

##DISPERSION TEST

Mean<-mean(aggregate_pm_census_cdc_test_beds$Deaths) # calculate mean

Variance<-var(aggregate_pm_census_cdc_test_beds$Deaths) # calculate variance

#Ratio=Dispersion- heavy overdispersion, neg binomial or quasipoisson more appropriate than poisson
Ratio<-(Variance/Mean)
Ratio

#ROC/AUC Analysis of True positive vs False positive hit rate
blk.pred.fit.glmer <- predict(mode.nb.random.off.main, newdata = aggregate_pm_census_cdc_test_beds, type = "response")
asian.pred.fit.glmer<-predict(asian.mode.nb.random.off.main, newdata = aggregate_pm_census_cdc_test_beds, type = "response")
white.pred.fit.glmer<-predict(white.mode.nb.random.off.main, newdata = aggregate_pm_census_cdc_test_beds, type = "response")
native.pred.fit.glmer<-predict(native.mode.nb.random.off.main, newdata = aggregate_pm_census_cdc_test_beds, type = "response")
hispanic.pred.fit.glmer<-predict(hispanic.mode.nb.random.off.main, newdata = aggregate_pm_census_cdc_test_beds, type = "response")
#trying out multiclass.roc-93.4%, MULTICLASS ROC can't be graphed, no difference between 'predict' statements
multiroccurve<-(multiclass.roc(aggregate_pm_census_cdc_test_beds$Deaths, pred.fit.glmer,percent = TRUE))
multiroccurve2<-(multiclass.roc(aggregate_pm_census_cdc_test_beds$Deaths, projections,percent = TRUE))
#asian- 92.97%
asian.multiroccurve<-(multiclass.roc(aggregate_pm_census_cdc_test_beds$Deaths, asian.pred.fit.glmer,percent = TRUE))
#white- 93.3%
white.multiroccurve<-(multiclass.roc(aggregate_pm_census_cdc_test_beds$Deaths, white.pred.fit.glmer,percent = TRUE))
#native-93.43%
native.multiroccurve<-(multiclass.roc(aggregate_pm_census_cdc_test_beds$Deaths, native.pred.fit.glmer,percent = TRUE))
#hispanic-93.39%
hispanic.multiroccurve<-(multiclass.roc(aggregate_pm_census_cdc_test_beds$Deaths, hispanic.pred.fit.glmer,percent = TRUE))


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







#MULTICLASS CONFUSION MATRIX-still problematic
projections<-predict(mode.nb.random.off.main)

table(projections,aggregate_pm_census_cdc_test_beds$pct_blk)
prop.table(table(aggregate_pm_census_cdc_test_beds$Deaths,pred.fit.glmer$pct_blk))

conf_mat<-confusionMatrix(targets=aggregate_pm_census_cdc_test_beds$Deaths, 
                          predictions=pred.fit.glmer,data=aggregate_pm_census_cdc_test_beds)
confusionMatrix(pred.fit.glmer,aggregate_pm_census_cdc_test_beds$Deaths)
confusionMatrix(aggregate_pm_census_cdc_test_beds$Deaths, pred.fit.glmer$pct)

##secondary performance measure, currently non-funcitonal
pr <- prediction(pred.fit.glmer,aggregate_pm_census_cdc_test_beds$Deaths)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

#Prediction- Need to understand better, seems like will 
#predict whether or not someone will die, rather than death count
p <- as.vector(predict(mode.nb.random.off.main, type="response")>.5)
confusion_matrix(aggregate_pm_census_cdc_test_beds$Deaths,p)
mean(p==aggregate_pm_census_cdc_test_beds$Deaths)
table1<-table(p,aggregate_pm_census_cdc_test_beds$Deaths)
plot (p)



##hosmer-lem. p-value over .05 means good fit, but we get neg chi square so the tst stat of Pr will always be above neg chi square
#hoslem.test(aggregate_pm_census_cdc_test_beds$Deaths, fitted(mode.nb.random.off.main), g=10)
#ANOVA for glmer packages, use for F-stat
#anova(mode.nb.random.off.main)

#roccurve<-(roc(aggregate_pm_census_cdc_test_beds$Deaths, pred.fit.glmer))
#auc(roc(aggregate_pm_census_cdc_test_beds$Deaths, pred.fit.glmer))
#AUC of .78, not bad but ideally over .8

#roccurve<-roccurve@y.values[[1]]
#Graph ROC curve
#plot(roccurve)
###Other checks (non functional) + models,
#trying to reveal correlation -> tried correlation graph matrix but crashed (due to large data size?)
'chart.Correlation(aggregate_pm_census_cdc_test_beds$pct_blk,aggregate_pm_census_cdc_test_beds$q_popdensity,aggregate_pm_census_cdc_test_beds$medhouseholdincome, 
                  aggregate_pm_census_cdc_test_beds$education, aggregate_pm_census_cdc_test_beds$date_since_social, aggregate_pm_census_cdc_test_beds$date_since,
                  aggregate_pm_census_cdc_test_beds$beds,aggregate_pm_census_cdc_test_beds$population, histogram=TRUE, pch=19)

cortest<-select_if(aggregate_pm_census_cdc_test_beds,is.numeric)
cor(cortest,method=c('pearson'))


cor(aggregate_pm_census_cdc_test_beds$pct_blk,aggregate_pm_census_cdc_test_beds$q_popdensity,aggregate_pm_census_cdc_test_beds$medhouseholdincome, 
    aggregate_pm_census_cdc_test_beds$education, aggregate_pm_census_cdc_test_beds$date_since_social, aggregate_pm_census_cdc_test_beds$date_since,
    aggregate_pm_census_cdc_test_beds$beds,aggregate_pm_census_cdc_test_beds$population,method=c('pearson'))

#without q_pop- note that this increases ratio of pct_blk but not necessarily better model
mode.nb.random.off.main = glmer.nb(Deaths ~ pct_blk 
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(mode.nb.random.off.main)
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
summary(mode.nb.random.off.main)[10]$coefficients[2,4]

#Both types of ANOVA are significant- p-values should be less than .05.
#ANOVA- linear regression
#Anova(mode.nb.random.off.main,test="LR")

#ANOVA from slides- f test
#Anova(mode.nb.random.off.main, test="F")
########################################################################################################

#Parition data 
Training_data_set<- createDataPartition(y=aggregate_pm_census_cdc_test_beds$Deaths,p=0.7, list=FALSE)
Prediction_data_set<- createDataPartition(y=aggregate_pm_census_cdc_test_beds$Deaths,p=0.3, list=FALSE)


#Partitioned analysis

mode.nb.random.off.main = glmer.nb(Deaths ~ pct_blk + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(mode.nb.random.off.main)
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
summary(mode.nb.random.off.main)[10]$coefficients[2,4]

#PLOT PREDICTION LINE- Must partition data --> call it Prediction_data_set

Prediction_data_set<-seq(0,100,.5)

PredictCases <- predict(mode.nb.random.off.main, list(pct_blk = Prediction_data_set))

lines(Prediction_data_set,exp(PredictCases),lwd=2,col="blue")'

