knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./Fixed_Date_Time_Series/06-21-2020data.Rds")

# non-linear pm
gamm.off.main.spm25 = gamm4(Deaths ~ s(mean_pm25) + factor(q_popdensity)
                            + scale(poverty)  + scale(log(medianhousevalue))
                            + scale(log(medhouseholdincome)) + scale(pct_owner_occ) 
                            + scale(education) + scale(pct_blk) + scale(hispanic) 
                            + scale(older_pecent) + scale(prime_pecent) + scale(mid_pecent) 
                            + scale(date_since_social) + scale(date_since)
                            + scale(beds/population) 
                            + scale(obese) + scale(smoke)
                            + scale(mean_summer_temp) + scale(mean_winter_temp) + scale(mean_summer_rm) + scale(mean_winter_rm)
                            + offset(log(population)) + s(Lat) + s(Long_), data = aggregate_pm_census_cdc_test_beds, 
                            family=negbin(1), random = ~(1|state))
summary(gamm.off.main.spm25)
