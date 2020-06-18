knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

#source("./Modules/Source.R")


library("lme4")
# in analyses...

args <- commandArgs()

datafile = args[6]


#datafile = "./Fixed_Date_Time_Series/05-05-2020data.Rds"
aggregate_pm_census_cdc_test_beds <- readRDS(datafile)

"Reading in Datafile = "
datafile

mode.nb.random.off.combined = glmer.nb(Deaths ~ hispanic + pct_blk + pct_asian + pct_white + pct_native
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

summary(mode.nb.random.off.combined)
s <- summary(mode.nb.random.off.combined)
date = substr(datafile, 26,30)
fname = paste("./Race_Analyses/models/combined",date,".rda",sep="")
save(s, file = fname)
save.image()
unlink(fname)

