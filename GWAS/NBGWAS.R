#############

#Nationwide GWAS with Negative Binomial Mixed Model
setwd("/data/Social_Determinants")

###dependencies
library("MASS")
library("lme4")
library("glmmTMB")
library("gamm4")
library('caret')
library('blmeco')
library(pROC)
library(VineCopula)
library("PerformanceAnalytics")
library(glmmTMB)
library(ggplot2)
library(cvms)
library(sgof)
library(tidyverse)
library(kableExtra)
library(cvms)
library(pracma)


#source("Modules/Source.R")
#source("GWAS/helper.R")

 ## Get variable in the loop

args <- commandArgs()


interested_var <- c(args[6:length(args)])

interested_var  <- as.name(interested_var)

  ###Data
  
sampledata<-readRDS('Preprocessing_FTS_Outputs/07-12-2020data.Rds')

#for (name in colnames(sampledata)) {
x <- c(34,35,43,47,52,53,61,62,68,69,70,76,82,94,95,106,119,120, 131,132,153,160,163,165,167,169,176,182,183, 184, 185, 186, 187, 188,200,208,216,236,238,240,256,288, 289, 
       290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304)
for ( i in x) {
  name = colnames(sampledata)[i]
  s <- paste("\"",name, "\" ", sep = "")
  cat(s)
}

#print (interested_var)
# For now: hand select the interested_var before runnign parallelization script
interested_var = "young_pecent"

sub_sampledata <- subset(sampledata, select = c ("Deaths","% Hispanic", "% Black", "% Asian", "% Non-Hispanic White", "% American Indian & Alaska Native", "q_popdensity", "Median Household Income", 
                                                 "education", "beds", "population", "date_since", "date_since_mask", "State", `interested_var`))

colnames(sub_sampledata)[ncol(sub_sampledata)] = "i_var"

# Debugging printouts:
#head(sub_sampledata)
#sapply(sub_sampledata, typeof)
#unname(sapply(sub_sampledata, typeof)[ncol(sub_sampledata)])
#strcmp(unname(sapply(sub_sampledata, typeof)[ncol(sub_sampledata)]), "character")

if (strcmp(unname(sapply(sub_sampledata, typeof)[ncol(sub_sampledata)]), "character")) {
    In.loop.model=glmer.nb(Deaths ~ scale(`% Hispanic`) + scale(`% Black`) + scale(`% Asian`) + scale(`% Non-Hispanic White`) + scale(`% American Indian & Alaska Native`)
                       + factor(q_popdensity)
                       + scale(log(`Median Household Income`))+scale(education) + scale(beds/population)
                       + scale(date_since) 
                       + scale(date_since_mask)
                       + factor(i_var)
                       + (1|State)
                       + offset(log(population)), data = sub_sampledata)
} else {
    In.loop.model=glmer.nb(Deaths ~ scale(`% Hispanic`) + scale(`% Black`) + scale(`% Asian`) + scale(`% Non-Hispanic White`) + scale(`% American Indian & Alaska Native`)
                       + factor(q_popdensity)
                       + scale(log(`Median Household Income`))+scale(education) + scale(beds/population)
                       + scale(date_since) 
                       + scale(date_since_mask)
                       + scale(i_var)
                       + (1|State)
                       + offset(log(population)), data = sub_sampledata)
}

GWAS_MRR <- readRDS("GWAS/GWAS_MRR.rds")

GWAS_P <- readRDS("GWAS/GWAS_P.rds")
GWAS_ADJ_P <- readRDS("GWAS/GWAS_ADJ_P.rds")

# Interleaving here between threads could leave some columns out... make sure to check after para. done
#summary(In.loop.model)[10]$coefficients[2:16,1]
#summary(In.loop.model)

GWAS_MRR[[interested_var]]   <- summary(In.loop.model)[10]$coefficients[2:16,1]
GWAS_P[[interested_var]]     <- summary(In.loop.model)[10]$coefficients[2:16,4]

GWAS_ADJ_P[[interested_var]] <- p.adjust(summary(In.loop.model)[10]$coefficients[2:16,4], 
                                     method = 'BH', 
                                     n = length(summary(In.loop.model)[10]$coefficients[2:16,4]))

# Intialize RDS files:
#GWAS_P = data.frame(matrix(ncol = 1, nrow = 15))
#row.names(GWAS_P) <- c("% Hispanic", "% Black", "% Asian", "% White", "% Native", "q_pop_dens 2", "q_pop_dens 3", "q_pop_dens 4", "q_pop_dens 5",
#                        "Median Household Income", "Education", "Beds/Population", "Date_Since", "Date_Since_Mask", "Interested_Variable")


saveRDS(GWAS_ADJ_P, "GWAS/GWAS_ADJ_P.rds")
saveRDS(GWAS_P, "GWAS/GWAS_P.rds")
saveRDS(GWAS_MRR, "GWAS/GWAS_MRR.rds")


