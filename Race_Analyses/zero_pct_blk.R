knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")


glmmTMB.off.main.zero_pct_blk = glmmTMB(Deaths ~ pct_blk + factor(q_popdensity)
                           + scale(log(medhouseholdincome))+scale(education)
                           + scale(date_since_social) + scale(date_since)
                           + (1|state) + scale(beds/population) 
                           + offset(log(population)), data = aggregate_pm_census_cdc_test_beds,
                           family = nbinom2, ziformula  = ~ 1)
#summary(glmmTMB.off.main)
#exp(summary(glmmTMB.off.main)[6]$coefficients$cond[2,1])
#exp(summary(glmmTMB.off.main)[6]$coefficients$cond[2,1] - 1.96*summary(glmmTMB.off.main)[6]$coefficients$cond[2,2])
#exp(summary(glmmTMB.off.main)[6]$coefficients$cond[2,1] + 1.96*summary(glmmTMB.off.main)[6]$coefficients$cond[2,2])
#summary(glmmTMB.off.main)[6]$coefficients$cond[2,4]



save(glmmTMB.off.main.zero_pct_blk, "./Race_Analyses/models/zero_pct_blk.RData")
save.image()
unlink("./Race_Analyses/models/zero_pct_blk.RData")
