knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")


# exclude NY Metro
mode.nb.random.off.nyc = glmer.nb(Deaths ~ mean_pm25 + factor(q_popdensity)
                                  + scale(poverty)  + scale(log(medianhousevalue))
                                  + scale(log(medhouseholdincome)) + scale(pct_owner_occ) 
                                  + scale(education) + scale(pct_blk) + scale(hispanic)
                                  + scale(older_pecent) + scale(prime_pecent) + scale(mid_pecent) 
                                  + scale(date_since_social) + scale(date_since)
                                  + scale(beds/population) 
                                  + scale(obese) + scale(smoke)
                                  + scale(mean_summer_temp) + scale(mean_winter_temp) + scale(mean_summer_rm) + scale(mean_winter_rm)
                                  + (1|state)
                                  + offset(log(population)),data = subset(aggregate_pm_census_cdc_test_beds,!(fips %in% c("09001","42089","36111","09009","36059","36103","34013",
                                                                                                                          "34019","34027","34037","34039","42103","34023","34025","34029",
                                                                                                                          "34035", "34003", "34017", "34031","36005","36047","36061",
                                                                                                                          "36079","36081",  "36085",  "36087",  "36119",  "36027", 
                                                                                                                          "36071",  "09005",  "34021"))))
summary(mode.nb.random.off.nyc)
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
summary(mode.nb.random.off.nyc)[10]$coefficients[2,4]