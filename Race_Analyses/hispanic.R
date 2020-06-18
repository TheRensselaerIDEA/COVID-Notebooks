knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

#HISPANIC- MRR- 1.10, 95% CI= (1.09,1.10), p-value is sig.
mode.nb.random.off.hispanic = glmer.nb(Deaths ~ hispanic + factor(q_popdensity)
                                            + scale(log(medhouseholdincome))+scale(education)
                                            + scale(date_since_social) + scale(date_since)
                                            + (1|state)+ scale(beds/population) 
                                            + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
#summary(mode.nb.random.off.hispanic)
#hispanicMRR<-exp(summary(mode.nb.random.off.hispanic)[10]$coefficients[2,1])
#hispanicMRR
#exp(summary(mode.nb.random.off.hispanic)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.hispanic)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.hispanic)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.hispanic)[10]$coefficients[2,2])
#summary(mode.nb.random.off.hispanic)[10]$coefficients[2,4]

save(mode.nb.random.off.hispanic, "./Race_Analyses/models/hispanic.RData")
save.image()
unlink("./Race_Analyses/models/hispanic.RData")