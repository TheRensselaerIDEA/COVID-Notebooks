knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

# cli
mode.nb.random.off.symptom = glmer.nb(Deaths ~ mean_pm25 + factor(q_popdensity)
                                      + scale(poverty)  + scale(log(medianhousevalue))
                                      + scale(log(medhouseholdincome)) + scale(pct_owner_occ) 
                                      + scale(education) + scale(pct_blk) + scale(hispanic)
                                      + scale(older_pecent) + scale(prime_pecent) + scale(mid_pecent) 
                                      + scale(date_since_social) + scale(date_since)
                                      + scale(beds/population) 
                                      + scale(obese) + scale(smoke)
                                      + scale(mean_summer_temp) + scale(mean_winter_temp) + scale(mean_summer_rm) + scale(mean_winter_rm)
                                      + scale(cli)  
                                      + (1|Province_State)
                                      + offset(log(population)), data = (aggregate_pm_census_cdc_test_beds)) 
summary(mode.nb.random.off.symptom)
exp(summary(mode.nb.random.off.symptom)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.symptom)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.symptom)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.symptom)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.symptom)[10]$coefficients[2,2])
summary(mode.nb.random.off.symptom)[10]$coefficients[2,4]
