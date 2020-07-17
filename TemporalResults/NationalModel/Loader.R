knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")

dates_names = c("03-29", "04-05", "04-12", "04-19", "04-26", "05-03", "05-10", "05-17", "05-24", "05-31", "06-07", "06-14", "06-21", "06-28", "07-05", "07-12")

COEF = c("(Intercept)",
         "scale(`% Hispanic`)","scale(`% Black`)","scale(`% Asian`)","scale(`% Non-Hispanic White`)","scale(`% Native Hawaiian/Other Pacific Islander`)",
         "factor(q_popdensity)2","factor(q_popdensity)3","factor(q_popdensity)4","factor(q_popdensity)5",
         "scale(log(`Median Household Income`))",
         "scale(date_since_social)","scale(date_since)","scale(date_since_reopen)","scale(date_since_reclosure)","scale(date_since_mask)",
         "scale(pct_obesity)","scale(pct_age65)","scale(pct_diabetes)",
         "scale(LungCancer)","scale(COPD)","scale(AdultAsthma)","scale(PediatricAsthma)",
         "scale(All.Cause.death_rate)")

ALL_C = data.frame(coefficients = COEF)
ALL_P = data.frame(coefficients = COEF)
ALL_sig = data.frame(coefficients = COEF)

for (i in 1:length(dates_names)){
  fname <- paste("./TemporalResults/NationalModel/",dates_names[i],".rda",sep="")
  load(fname)
  summ <- eval(as.name(dates_names[i]))
  c <- exp(summ[10]$coefficients[,1])
  p <- summ[10]$coefficients[,4]
  p <- p.adjust(p, method = 'BH', n = length(p))
  
  # merge into master data frame
  ALL_C$date <- c[match(ALL_C$coefficients, names(c))]
  names(ALL_C)[names(ALL_C) == 'date'] <- dates_names[i]
  ALL_P$date <- p[match(ALL_P$coefficients, names(p))]
  names(ALL_P)[names(ALL_P) == 'date'] <- dates_names[i]
}

saveRDS(ALL_C, file = './TemporalResults/NationalModel/ALL_C.rds')
saveRDS(ALL_P, file = './TemporalResults/NationalModel/ALL_P.rds')

ALL_C_sig <- data.frame(coefficients = COEF)
ALL_P_sig <- data.frame(coefficients = COEF)
for (i in 1:length(dates_names)){
  column_C <- c()
  column_P <- c()
  for (j in 1:length(COEF)){
    c <- ALL_C[[dates_names[i]]][j]
    p <- ALL_P[[dates_names[i]]][j]
    if (!is.na(p) & p <= 0.05){
      column_C <- append(column_C, c, after = length(column_C))
      column_P <- append(column_P, p, after = length(column_P))
    }else{
      column_C <- append(column_C, NA, after = length(column_C))
      column_P <- append(column_P, NA, after = length(column_P))
    }
  }
  ALL_C_sig$date <- column_C
  names(ALL_C_sig)[names(ALL_C_sig) == 'date'] <- dates_names[i]
  ALL_P_sig$date <- column_P
  names(ALL_P_sig)[names(ALL_P_sig) == 'date'] <- dates_names[i]
}

ALL_C_sig <- ALL_C_sig[rowSums(is.na(ALL_C_sig)) != ncol(ALL_C_sig)-1, ]
ALL_P_sig <- ALL_P_sig[rowSums(is.na(ALL_P_sig)) != ncol(ALL_P_sig)-1, ]

saveRDS(ALL_C_sig, file = './TemporalResults/NationalModel/ALL_C_sig.rds')
saveRDS(ALL_P_sig, file = './TemporalResults/NationalModel/ALL_P_sig.rds')