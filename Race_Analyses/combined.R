knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

combined = glmer.nb(Deaths ~ hispanic + pct_blk + pct_asian + pct_white + pct_native
                                            + factor(q_popdensity)
                                            + scale(log(medhouseholdincome))+scale(education)
                                            + scale(date_since_social) + scale(date_since)
                                            + (1|state)+ scale(beds/population) 
                                            + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
#summary(mode.nb.random.off.combined)
#CombinedMRR<-exp(summary(mode.nb.random.off.combined)[10]$coefficients[2,1])
#CombinedMRR
#exp(summary(mode.nb.random.off.combined)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.combined)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.combined)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.combined)[10]$coefficients[2,2])
#summary(mode.nb.random.off.combined)[10]$coefficients[2,4]

mode.nb.random.off.combined = combined

save(combined, "./Race_Analyses/models/combined.RData")
save.image()
unlink("./Race_Analyses/models/combined.RData")