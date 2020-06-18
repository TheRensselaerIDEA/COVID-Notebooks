knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

#ASIAN--> huge 95% CI (52.9,63989), MRR= 1840, p val sig.
mode.nb.random.off.asian = glmer.nb(Deaths ~ pct_asian + factor(q_popdensity)
                                         + scale(log(medhouseholdincome))+scale(education)
                                         + scale(date_since_social) + scale(date_since)
                                         + (1|state)+ scale(beds/population) 
                                         + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
#summary(mode.nb.random.off.asian)
#MRR_pct_asian<-exp(summary(mode.nb.random.off.asian)[10]$coefficients[2,1])
#MRR_pct_asian
#exp(summary(mode.nb.random.off.asian)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.asian)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.asian)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.asian)[10]$coefficients[2,2])
#summary(mode.nb.random.off.asian)[10]$coefficients[2,4]

save(mode.nb.random.off.asian, "./Race_Analyses/models/asian.RData")
save.image()
unlink("./Race_Analyses/models/asian.RData")