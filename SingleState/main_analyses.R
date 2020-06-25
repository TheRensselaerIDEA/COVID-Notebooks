knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./Fixed_Date_Time_Series/06-21-2020data.Rds")
#choice <- "CA"
#aggregate_pm_census_cdc_test_beds <- subset(aggregate_pm_census_cdc_test_beds, state == "CA")

# Main
mode.nb.random.off.main = glmer.nb(Deaths ~ state + factor(q_popdensity)
                                   + scale(poverty)  + scale(log(medianhousevalue))
                                   + scale(log(medhouseholdincome)) + scale(pct_owner_occ) 
                                   + scale(education) + scale(pct_blk) + scale(hispanic)
                                   + scale(older_pecent) + scale(prime_pecent) + scale(mid_pecent) 
                                   + scale(date_since_social) + scale(date_since)
                                   + scale(beds/population) 
                                   + scale(obese) + scale(smoke)
                                   + scale(mean_summer_temp) + scale(mean_winter_temp) + scale(mean_summer_rm) + scale(mean_winter_rm)
                                   + (1|state)
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
summary(mode.nb.random.off.main)
s <- summary(mode.nb.random.off.main)
save(s, file = "StateSummaries/California_0621.rda")
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
summary(mode.nb.random.off.main)[10]$coefficients[2,4]
