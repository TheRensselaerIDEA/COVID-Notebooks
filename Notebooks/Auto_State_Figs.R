
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

#source("./Modules/Source.R")

library(ggfortify)
library("ggplot2")

#args <- commandArgs()


#states <- c(args[6:length(args)])

states <- c("AL", "AR", "AZ", "CA", "CT","CO", "DE", "FL", "GA", "IA", "ID", "IL", "IN", "KS", "KY",
            "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NV", 
            "NY", "OH", "OK", "OR", "PA", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")
fname <- paste("./StateSummaries/",states[1],".summary.rda",sep="")
load(fname)
b <- paste(states[1], ".summary", sep="")
model_output <- eval(as.name(b))
number_params <- length(c(model_output$coefficients[,1]))



state_RRs <- array(dim = c(length(states),as.integer(number_params)))
state_lowers <- array(dim = c(length(states),as.integer(number_params)))
state_uppers <- array(dim = c(length(states),as.integer(number_params)))
state_pvals <- array(dim = c(length(states),as.integer(number_params)))
names <- array(dim=as.integer(number_params))

for ( i in 1:length(states)) {
  state <- states[i]
  fname <- paste("./StateSummaries/",state,".summary.rda",sep="")
  load(fname)
  b <- paste(state, ".summary", sep= "")
  model_output <- eval(as.name(b))
  model_output
  model_output$coefficients[,1]
  
  
  
  this_state_RR <- model_output$coefficients[,1]
  this_state_lowers <- model_output$coefficients[,1] - 1.96*model_output$coefficients[,2]
  this_state_uppers <- model_output$coefficients[,1] + 1.96*model_output$coefficients[,2]
  this_state_pvals <- model_output$coefficients[,4]
  
  names <- names(this_state_RR)
  if (length(this_state_RR) != 13) {
    print(state) 
    next
  }
  state_RRs[i,]    <- unname(this_state_RR)
  state_lowers[i,] <- unname(this_state_lowers)
  state_uppers[i,] <- unname(this_state_uppers)
  state_pvals[i,] <- unname(this_state_pvals) 
  
}

t1 <- state_pvals[,]

# CREATE A TABLE FOR SIGNIFICANCE VALUES (P-Vals)
library(knitr)
library(kableExtra)
library(formattable)
library(dplyr)
library(tidyverse)

t1

cols <- (c("Intercept", "Black",
           "q_2", "q_3", "q_4", "q_5",
           "householdincome", "education", "beds", 
           "obesity", "COPD", "age65", "diabetic"))


rows <- states
length(t1)
length(t1[,1])
length(t1[1,])
length(rows)
output_name <- paste("./StateFigs/state621.txt")
write.table(t1, file = output_name, append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = rows,
            col.names = cols, qmethod = c("escape", "double"),
            fileEncoding = "")


output_name <- paste("./StateFigs/state621.txt")
t1 <- read.table(file = output_name, sep = "", quote = "\"'", header= T,
                 dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss") ,
                 colClasses = c("character", "double","double","double","double","double",
                                "double","double","double","double","double",
                                "double","double","double"), row.names = 1)

#t1 <- t(t1)


color_format <- function(x, na.rm = TRUE) {
  
  ifelse(x >0.10,
         cell_spec(x, "html", background = "#FF0000"),
         ifelse(x>0.05,
                cell_spec(x, "html", background ="#FF5733"),
                ifelse(x>0.01,
                       cell_spec(x, "html", background ="#FFFF00"),
                       cell_spec(x, "html", background ="#00FFFF"))))
  
}
rounder <- function(x, na.rm = TRUE) {
  round(x, digits = 3)
}

t1
t2 <- as_tibble(t1)
t2
t2 %>%
  mutate(state= rows) %>%
  mutate_if(is.double, rounder, na.rm = TRUE) %>%
  mutate_if(is.double, color_format, na.rm = TRUE) %>%
  kable(format = "html", escape = F, row.names = TRUE) %>%
  kable_styling(full_width = T) %>%
  save_kable(file = "./StateFigs/state621.html", self_contained = T)

t2


#significance = formatter("span",
#                         style = x ~ style(color = ifelse(x > 0.05, "red", ifelse(x>0.01, "yellow","green"))))
#t1 <- formattable(t1, formatter = significance)
#t1 <- formattable( t1, align = l, c, c, c, c, c, c, c, c, c, c, c, c, c)
t1
stop()



stop() 
for (i in 2:length(names)) {
  title = names[i]
  data <- data.frame(method = c(dates),
                     RR = (c((date_RRs[,i]))
                     ),
                     lower_CI = (c((date_lowers[,i]))
                     ),
                     upper_CI = (c((date_uppers[,i]))
                     ),
                     Methods = c(1:length(dates)))
  
  #print(data)
  #stop()
  output_name = paste("./Figs/combined_temporal_", title, ".pdf", sep="")
  graph_title = paste("Effect of ", title, " on Covid Mortality Rate Over Time", sep="")
  #print(output_name)
  #print(graph_title)
  pdf(output_name, width = 4 * length(dates), height = 11)
  maxy = max(data$upper_CI[1:length(dates)])
  #print(maxy)
  #stop()
  p1 <- ggplot(data[1:length(dates),], aes(x=Methods, y=RR),size= 1) + 
    ylab("Mortality Rate Ratios") +
    ggtitle(graph_title) + 
    geom_point(aes(size = 1)) +
    geom_errorbar(aes(ymin=lower_CI, ymax=upper_CI), width=.2,size=1) +
    geom_hline(yintercept = 1.0, linetype="dashed", size=0.8)  +
    annotate(geom = "text", x = seq_len(nrow(data)), y = 0-.05, label = data$method, size = 10) +
    coord_cartesian(ylim = c(0.0, maxy+0.5), xlim = c(0.5, 13.5), expand = FALSE, clip = "off")  +
    theme_bw() +
    theme(plot.margin = unit(c(3, 2, 4, 1), "lines"),
          axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_text(size=16*2),
          axis.title.y = element_text(size = 20*2),
          plot.title = element_text(size = 20*2),
          legend.position = "none")
  plot(p1)
  output_name = paste("./Figs/combined_temporal_", title, ".jpeg", sep="")
  #print(output_name)
  #png(output_name, height = 1024*0.6*2, width = 1024*4)
  #plot(p1)
  
  dev.off()
  #stop()
}
