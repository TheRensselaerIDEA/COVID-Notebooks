knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "../")

source("./Modules/Source.R")

aggregated_data <- readRDS('Fixed_Date_Time_Series/06-21-2020data.Rds')

statesplit <- split(aggregated_data, aggregated_data$state)

for (name in names(statesplit)) {
  if (nrow(statesplit[[name]]) < 2){
    statesplit <- statesplit[names(statesplit) != name]
  }
}

states <- names(statesplit)

for (name in names(statesplit)) {
  if (name %in% c("NM", "RI"))
    next
  state_data <- statesplit[[name]]
  state_data <- subset(state_data, select = c(fips, Deaths, COPD, pct_blk, q_popdensity, medhouseholdincome, education, beds, population, pct_obesity, pct_age65, pct_diabetes))
  model <- glm.nb(Deaths ~ scale(pct_blk) + factor(q_popdensity)
                       + scale(log(medhouseholdincome))+scale(education)
                       + scale(beds/population)+scale(pct_obesity)
                       + scale(COPD)
                       + scale(pct_age65)+scale(pct_diabetes)
                       + offset(log(population)), data=state_data)
  result <- paste(name, ".summary", sep = "")
  assign(result, summary(model))
  fname = paste("./StateSummaries/",result,".rda",sep="")
  do.call(save, list(result, file=fname))
}

#coefficient.matrix<-exp(summary[["coefficients"]][1:13])