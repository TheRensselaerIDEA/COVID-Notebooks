knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")

aggregated_data <- readRDS('Fixed_Date_Time_Series/06-28-2020data.Rds')

statesplit <- split(aggregated_data, aggregated_data$state)

for (name in names(statesplit)) {
  if (nrow(statesplit[[name]]) < 2){
    statesplit <- statesplit[names(statesplit) != name]
  }
}

states <- names(statesplit)
states

COEF <- c("(Intercept)", "scale(hispanic)", "scale(pct_blk)", "scale(pct_asian)", "scale(pct_white)", "scale(pct_native)", 
         "factor(q_popdensity)2", "factor(q_popdensity)3", "factor(q_popdensity)4", "factor(q_popdensity)5", 
         "scale(log(medhouseholdincome))", "scale(pct_obesity)", "scale(pct_age65)", "scale(pct_diabetes)", 
         "scale(LungCancer)", "scale(AdultChronicLungDisease)", "scale(COPD)", "scale(AdultAsthma)", "scale(PediatricAsthma)", 
         "scale(Despair.death_rate)", "scale(All.Cause.death_rate)", "scale(Cardiovascular.death_rate)")

ALL.C <- data.frame(coefficients=COEF)
ALL.E <- data.frame(coefficients=COEF)

for (name in names(statesplit)) {
  if (name %in% c("AZ", "CT", "DE", "RI"))
  #if (!name %in% c("AR"))
    next
  state_data <- statesplit[[name]]

  state_data <- subset(state_data, select = c(fips, Deaths, hispanic, pct_blk, pct_asian, pct_white, pct_native, 
                                              q_popdensity, medhouseholdincome, pct_obesity, pct_age65, pct_diabetes, 
                                              LungCancer, AdultChronicLungDisease, COPD, AdultAsthma, PediatricAsthma, 
                                              Despair.death_rate, All.Cause.death_rate, Cardiovascular.death_rate, population))
  model <- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                         + factor(q_popdensity)
                         
                         + scale(log(medhouseholdincome))
                         + scale(pct_obesity)
                         + scale(pct_age65)
                         + scale(pct_diabetes)
                         
                         + scale(LungCancer)
                         + scale(AdultChronicLungDisease)
                         + scale(COPD)
                         + scale(AdultAsthma)
                         + scale(PediatricAsthma)
                  
                         + scale(Despair.death_rate)
                         + scale(All.Cause.death_rate)
                         + scale(Cardiovascular.death_rate)
                         
                         + offset(log(population)), data =state_data)
  result <- paste(name, ".summary", sep = "")
  assign(result, summary(model))
  fname = paste("./StateSummaries/",result,".rda",sep="")
  do.call(save, list(result, file=fname))

  if (name %in% c("NY")) {
    c <- exp(summary(model)[13]$coefficients[,1])
    ALL.C$name <- c[match(ALL.C$coefficients, names(c))]
    names(ALL.C)[names(ALL.C) == 'name'] <- name
    e <- summary(model)[13]$coefficients[,4]
    ALL.E$name <- e[match(ALL.E$coefficients, names(e))]
    names(ALL.E)[names(ALL.E) == 'name'] <- name
  } else {
    c <- exp(summary(model)[12]$coefficients[,1])
    ALL.C$name <- c[match(ALL.C$coefficients, names(c))]
    names(ALL.C)[names(ALL.C) == 'name'] <- name
    e <- summary(model)[12]$coefficients[,4]
    ALL.E$name <- e[match(ALL.E$coefficients, names(e))]
    names(ALL.E)[names(ALL.E) == 'name'] <- name
  }
}

saveRDS(ALL.C, file = './StateSummaries/ALL_C.rds')
saveRDS(ALL.E, file = './StateSummaries/ALL_E.rds')
