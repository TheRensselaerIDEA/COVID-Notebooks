knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

#WHITE-MRR=.077, 95% CI=(.048,.122), p val is sig.
white = glmer.nb(Deaths ~ pct_white + factor(q_popdensity)
                                         + scale(log(medhouseholdincome))+scale(education)
                                         + scale(date_since_social) + scale(date_since)
                                         + (1|state)+ scale(beds/population) 
                                         + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
#summary(mode.nb.random.off.white)
#MRR_pct_white<-exp(summary(mode.nb.random.off.white)[10]$coefficients[2,1])
#MRR_pct_white
#exp(summary(mode.nb.random.off.white)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.white)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.white)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.white)[10]$coefficients[2,2])
#summary(mode.nb.random.off.white)[10]$coefficients[2,4]

mode.nb.random.off.white = white

save(white, "./Race_Analyses/models/white.RData")
save.image()
unlink("./Race_Analyses/models/white.RData")