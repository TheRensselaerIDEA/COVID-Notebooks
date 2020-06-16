knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")
aggregated_data <- readRDS("./PM25data.Rds")

# main analysis
mode.nb.random.off.obesity = glmer.nb(Deaths ~ pct_obesity + factor(q_popdensity)
                                    + scale(log(medhouseholdincome))+scale(education)
                                    + scale(date_since_social) + scale(date_since)
                                    + (1|state)+ scale(beds/population) 
                                    + offset(log(population)), data = aggregated_data)
summary(mode.nb.random.off.obesity)
exp(summary(mode.nb.random.off.obesity)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.obesity)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.obesity)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.obesity)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.obesity)[10]$coefficients[2,2])
summary(mode.nb.random.off.obesity)[10]$coefficients[2,4]

# zero inflated
glmmTMB.off.obesity = glmmTMB(Deaths ~ pct_obesity + factor(q_popdensity)
                            + scale(log(medhouseholdincome))+scale(education)
                            + scale(date_since_social) + scale(date_since)
                            + (1|state)+ scale(beds/population) 
                            + offset(log(population)), data = aggregated_data, 
                            family = nbinom2, ziformula  = ~ 1)
exp(summary(glmmTMB.off.obesity)[6]$coefficients$cond[2,1])
exp(summary(glmmTMB.off.obesity)[6]$coefficients$cond[2,1] - 1.96*summary(glmmTMB.off.obesity)[6]$coefficients$cond[2,2])
exp(summary(glmmTMB.off.obesity)[6]$coefficients$cond[2,1] + 1.96*summary(glmmTMB.off.obesity)[6]$coefficients$cond[2,2])
summary(glmmTMB.off.obesity)[6]$coefficients$cond[2,4]

# exclude NY Metro
mode.nb.random.off.nyc = glmer.nb(Deaths ~ pct_obesity + factor(q_popdensity)
                                  + scale(log(medhouseholdincome))+scale(education)
                                  + scale(date_since_social) + scale(date_since)
                                  + (1|state)+ scale(beds/population) 
                                  + offset(log(population)),data = subset(aggregated_data,!(fips %in% c("09001","42089","36111","09009","36059","36103","34013",
                                                                                                        "34019","34027","34037","34039","42103","34023","34025","34029",
                                                                                                        "34035", "34003", "34017", "34031","36005","36047","36061",
                                                                                                        "36079","36081",  "36085",  "36087",  "36119",  "36027", 
                                                                                                        "36071",  "09005",  "34021"))))
summary(mode.nb.random.off.nyc)
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] - 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
exp(summary(mode.nb.random.off.nyc)[10]$coefficients[2,1] + 1.96*summary(mode.nb.random.off.nyc)[10]$coefficients[2,2])
summary(mode.nb.random.off.nyc)[10]$coefficients[2,4]