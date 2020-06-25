knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./Fixed_Date_Time_Series/06-21-2020data.Rds")
#mode.nb.random.off <- mode.nb.random.off

# main analysis with category PM
aggregate_pm_census_cdc_test_beds$q_pm = 1
quantile_pm = quantile(aggregate_pm_census_cdc_test_beds$mean_pm25,c(0.2,0.4,0.6,0.8))
aggregate_pm_census_cdc_test_beds$q_pm[aggregate_pm_census_cdc_test_beds$mean_pm25<=quantile_pm[1]] = 1
aggregate_pm_census_cdc_test_beds$q_pm[aggregate_pm_census_cdc_test_beds$mean_pm25>quantile_pm[1] &
                                         aggregate_pm_census_cdc_test_beds$mean_pm25<=quantile_pm[2]] = 2
aggregate_pm_census_cdc_test_beds$q_pm[aggregate_pm_census_cdc_test_beds$mean_pm25>quantile_pm[2] &
                                         aggregate_pm_census_cdc_test_beds$mean_pm25<=quantile_pm[3]] = 3
aggregate_pm_census_cdc_test_beds$q_pm[aggregate_pm_census_cdc_test_beds$mean_pm25>quantile_pm[3] &
                                         aggregate_pm_census_cdc_test_beds$mean_pm25<=quantile_pm[4]] = 4
aggregate_pm_census_cdc_test_beds$q_pm[aggregate_pm_census_cdc_test_beds$mean_pm25>quantile_pm[4]] = 5

mode.nb.random.off.catepm = glmer.nb(Deaths ~ factor(q_pm) + factor(q_popdensity)
                                     + scale(poverty)  + scale(log(medianhousevalue))
                                     + scale(log(medhouseholdincome)) + scale(pct_owner_occ) 
                                     + scale(education) + scale(pct_blk) + scale(hispanic)
                                     + scale(older_pecent) + scale(prime_pecent) + scale(mid_pecent) 
                                     + scale(date_since_social) + scale(date_since)
                                     + scale(beds/population) 
                                     + scale(obese) + scale(smoke)
                                     + scale(mean_summer_temp) + scale(mean_winter_temp) + scale(mean_summer_rm) + scale(mean_winter_rm)
                                     + (1|state)
                                     + offset(log(population)), data = (aggregate_pm_census_cdc_test_beds)) 
#<<<<<<< HEAD
summary(mode.nb.random.off.catepm)
#=======
#methods(class="merMod")
#profile(mode.nb.random.off.catepm)
#head(model.frame(mode.nb.random.off.catepm))
#summary(model.frame(mode.nb.random.off.catepm))
#summary(mode.nb.random.off.catepm)
#plot(mode.nb.random.off.catepm)
#getSlots(mode.nb.random.off.catepm)
#formula(mode.nb.random.off.catepm)
#predict(mode.nb.random.off.catepm)
#head((mode.nb.random.off.catepm)[10])

#>>>>>>> 2dc19a6d8c23e33000e8d7a08851c8139049f271
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[2,2])
summary(mode.nb.random.off.catepm)[10]$coefficients[2,4]

exp(summary(mode.nb.random.off.catepm)[10]$coefficients[3,1])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[3,1] - 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[3,2])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[3,1] + 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[3,2])
summary(mode.nb.random.off.catepm)[10]$coefficients[3,4]

exp(summary(mode.nb.random.off.catepm)[10]$coefficients[4,1])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[4,1] - 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[4,2])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[4,1] + 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[4,2])
summary(mode.nb.random.off.catepm)[10]$coefficients[4,4]

exp(summary(mode.nb.random.off.catepm)[10]$coefficients[5,1])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[5,1] - 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[5,2])
exp(summary(mode.nb.random.off.catepm)[10]$coefficients[5,1] + 1.96*summary(mode.nb.random.off.catepm)[10]$coefficients[5,2])
summary(mode.nb.random.off.catepm)[10]$coefficients[5,4]

