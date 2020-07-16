#############

#Nationwide GWAS with Negative Binomial Mixed Model
setwd("/data/Social_Determinants")

###dependencies

library(cvms)
library(pracma)


source("Modules/Source.R")
source("GWAS/helper.R")

 ## Get variable in the loop

args <- commandArgs()


interested_var <- c(args[6:length(args)])

interested_var  <- as.name(interested_var)

  ###Data
  
sampledata<-readRDS('Preprocessing_FTS_Outputs/05-03-2020data.Rds')


# `% Hispanic` `% Black` `% Asian` `% Non-Hispanic White` `% Native Hawaiian/Other Pacific Islander` `Median Household Income` 

if (strcmp(sapply(sampledata[[interested_var]], typeof)[1], "character")) {
    In.loop.model=glmer.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                       + factor(q_popdensity)
                       + scale(log(medhouseholdincome))+scale(education) + scale(beds/population)
                       + scale(date_since) 
                       + scale(date_since_mask)
                       + factor([[interested_var]])
                       + (1|state)
                       + offset(log(population)), data = sampledata)
} else {
  In.loop.model=glmer.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                         + factor(q_popdensity)
                         + scale(log(medhouseholdincome))+scale(education) + scale(beds/population)
                         + scale(date_since) 
                         + scale(date_since_mask)
                         + scale([[interested_var]])
                         + (1|state)
                         + offset(log(population)), data = sampledata)
}

GWAS_MRR <- readRDS("GWAS/GWAS_MRR.rds")
GWAS_P <- readRDS("GWAS/GWAS_P.rds")
GWAS_ADJ_P <- readRDS("GWAS/GWAS_ADJ_P.rds")


GWAS_MRR[[interested_var]]   <-summary(In.loop.model)[10]$coefficients[2:13,1]
GWAS_P[[interested_var]]     <-summary(In.loop.model)[10]$coefficients[2:13,4]
GWAS_ADJ_P[[interested_var]] <-p.adjust(summary(In.loop.model)[10]$coefficients[2:13,4], 
                                     method = 'BH', 
                                     n = length(summary(In.loop.model)[10]$coefficients[2:13,4]))

saveRDS(GWAS_ADJ_P, "GWAS/GWAS_ADJ_P.rds")
saveRDS(GWAS_P, "GWAS/GWAS_P.rds")
saveRDS(GWAS_MRR, "GWAS/GWAS_MRR.rds")


