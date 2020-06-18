knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

# exclude NY Metro- slighlty lower MMR for pct_blk, possibly due to high pct_blk incidence in high mortality area like nyc
nyc_blk = glmer.nb(Deaths ~ pct_blk + factor(q_popdensity)
                                  + scale(log(medhouseholdincome))+scale(education)
                                  + scale(date_since_social) + scale(date_since)
                                  + (1|state) + scale(beds/population)
                                  + offset(log(population)),data = subset(aggregate_pm_census_cdc_test_beds,!(fips %in% c("09001","42089","36111","09009","36059","36103","34013",
                                                                                                                          "36079","36081",  "36085",  "36087",  "36119",  "36027",                                                                                                                           "36071",  "09005",  "34021"))))
#summary(mode.nb.random.off.nyc_blk)
#exp(summary(mode.nb.random.off.nyc_blk)[10]$coefficients[2,1])
#exp(summary(mode.nb.random.off.nyc_blk)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.nyc_blk)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.nyc_blk)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.nyc_blk)[10]$coefficients[2,2])
#summary(mode.nb.random.off.nyc_blk)[10]$coefficients[2,4]


mode.nb.random.off.nyc_blk = nyc_blk

save(nyc_blk, "./Race_Analyses/models/pct_blk_exnyc.RData")
save.image()
unlink("./Race_Analyses/models/pct_blk_exnyc.RData")