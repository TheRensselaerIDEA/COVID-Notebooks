knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

#NATIVE- MMR=3.18, 95% CI=(.899,11.28),p-value=.07, not sig.
mode.nb.random.off.native = glmer.nb(Deaths ~ pct_native + factor(q_popdensity)
                                          + scale(log(medhouseholdincome))+scale(education)
                                          + scale(date_since_social) + scale(date_since)
                                          + (1|state)+ scale(beds/population) 
                                          + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
#summary(mode.nb.random.off.native)
#MRR_pct_native<-exp(summary(mode.nb.random.off.native)[10]$coefficients[2,1])
#MRR_pct_native
#exp(summary(mode.nb.random.off.native)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.native)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.native)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.native)[10]$coefficients[2,2])
#summary(mode.nb.random.off.native)[10]$coefficients[2,4]

save(mode.nb.random.off.native, "./Race_Analyses/models/native.RData")
save.image()
unlink("./Race_Analyses/models/native.RData")