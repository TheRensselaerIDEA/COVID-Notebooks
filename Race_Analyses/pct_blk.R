knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregate_pm_census_cdc_test_beds <- readRDS("./PM25data.Rds")

# Main- mixed effects negative binomial, deaths from percent black to identify risk to specific race
mode.nb.random.off.pct_blk = glmer.nb(Deaths ~ pct_blk + factor(q_popdensity)
                                   + scale(log(medhouseholdincome))+scale(education)
                                   + scale(date_since_social) + scale(date_since)
                                   + (1|state)+ scale(beds/population) 
                                   + offset(log(population)), data = aggregate_pm_census_cdc_test_beds)
#summary(mode.nb.random.off.main)
#MRR_pct_blk<-exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1])
#MRR_pct_blk
#exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
#exp(summary(mode.nb.random.off.main)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.main)[10]$coefficients[2,2])
#ssummary(mode.nb.random.off.main)[10]$coefficients[2,4]


save(mode.nb.random.off.pct_blk, "./Race_Analyses/models/pct_blk.RData")
save.image()
unlink("./Race_Analyses/models/pct_blk.RData")

# To load in file : 4
#  load("./Analyses_2/models/pct_blk.RData")
#  object already attached to mode.nb.random.off.pct_blk