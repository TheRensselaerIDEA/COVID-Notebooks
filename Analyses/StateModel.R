knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")

# Read in data
aggregated_data <- readRDS('Preprocessing_FTS_Outputs/06-28-2020data.Rds')

# Split the data on state
statesplit <- split(aggregated_data, aggregated_data$state)

# Ignore states with less than 2 counties
for (name in names(statesplit)) {
  if (nrow(statesplit[[name]]) < 2){
    statesplit <- statesplit[names(statesplit) != name]
  }
}

states <- names(statesplit)
states

# names of coefficients for indexing
COEF <- c("(Intercept)", "scale(hispanic)", "scale(pct_blk)", "scale(pct_asian)", "scale(pct_white)", "scale(pct_native)", 
         "factor(q_popdensity)2", "factor(q_popdensity)3", "factor(q_popdensity)4", "factor(q_popdensity)5", 
         "scale(log(medhouseholdincome))", "scale(pct_obesity)", "scale(pct_age65)", "scale(pct_diabetes)", 
         "scale(LungCancer)", "scale(COPD)", "scale(AdultAsthma)", "scale(PediatricAsthma)", 
         "scale(All.Cause.death_rate)")

# master data frame of MRR and p-value
ALL.C <- data.frame(coefficients=COEF)
ALL.P <- data.frame(coefficients=COEF)
ALL.merged <- data.frame(coefficients=COEF)

for (name in names(statesplit)) {
  # Ignore states having issues
  if (name %in% c("AZ", "CT", "DE", "RI"))
    next
  state_data <- statesplit[[name]]
  
  state_data <- subset(state_data, select = c(fips, Deaths, hispanic, pct_blk, pct_asian, pct_white, pct_native, 
                                              q_popdensity, medhouseholdincome, pct_obesity, pct_age65, pct_diabetes, 
                                              LungCancer, AdultChronicLungDisease, COPD, AdultAsthma, PediatricAsthma, 
                                              Despair.death_rate, All.Cause.death_rate, Cardiovascular.death_rate, population))
  
  model <- glm.nb(Deaths ~ scale(hispanic) + scale(pct_blk) + scale(pct_asian) + scale(pct_white) + scale(pct_native)
                         + factor(q_popdensity)
                         + scale(log(medhouseholdincome))
                         +scale(pct_obesity)
                         +scale(pct_age65)
                         +scale(pct_diabetes)
                         +scale(LungCancer)
                         +scale(COPD)
                         +scale(AdultAsthma)
                         +scale(PediatricAsthma)
                         +scale(All.Cause.death_rate)
                         + offset(log(population)), data =state_data)
  
  # save model summary of single state
  result <- paste(name, ".summary", sep = "")
  assign(result, summary(model))
  fname = paste("./StateSummaries/",result,".rda",sep="")
  do.call(save, list(result, file=fname))
  
  # NY model summary stores coefficients on 13th element while all others on 12nd
  if (name %in% c("NY")) {
    c <- exp(summary(model)[13]$coefficients[,1])
    p <- summary(model)[13]$coefficients[,4]
  } else {
    c <- exp(summary(model)[12]$coefficients[,1])
    p <- summary(model)[12]$coefficients[,4]
  }
  
  p <- p.adjust(p, method = 'BH', n = length(p))
  
  # merge into master data frame
  ALL.C$state <- c[match(ALL.C$coefficients, names(c))]
  names(ALL.C)[names(ALL.C) == 'state'] <- name
  ALL.P$state <- p[match(ALL.P$coefficients, names(p))]
  names(ALL.P)[names(ALL.P) == 'state'] <- name
  
  ALL.merged$state_c <- c[match(ALL.merged$coefficients, names(c))]
  ALL.merged$state_p <- p[match(ALL.merged$coefficients, names(p))]
  name_c = paste(name, '_c', sep = '')
  name_p = paste(name, '_p', sep = '')
  names(ALL.merged)[names(ALL.merged) == 'state_c'] <- name_c
  names(ALL.merged)[names(ALL.merged) == 'state_p'] <- name_p
  
}

saveRDS(ALL.C, file = './AdjustedStateSummaries/ALL_C.rds')
saveRDS(ALL.P, file = './AdjustedStateSummaries/ALL_P.rds')
saveRDS(ALL.merged, file = './AdjustedStateSummaries/ALL_merged.rds')

ALL.pair <- data.frame(states=names(ALL.C)[2:45])

for (i in 1:19){
  column <- c()
  for (name in ALL.pair$states){
    c <- ALL.C[[name]][i]
    p <- ALL.P[[name]][i]
    if (!is.na(p) & p <= 0.05){
      pair <- c(c, p)
    }else{
      pair <- c(NA,NA)
    }
    #pair <- c(c, p)
    column <- append(column, pair, after = length(column))
  }
  x <- seq_along(column)
  column <- split(column, ceiling(x/2))
  ALL.pair$coef <- column
  names(ALL.pair)[names(ALL.pair) == 'coef'] <- COEF[i]
}

#replace(ALL.pair, ALL.pair==c(NA,NA), 0)

saveRDS(ALL.pair, file = './AdjustedStateSummaries/Significant.rds')
