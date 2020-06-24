
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

#source("./Modules/Source.R")

library(ggfortify)
library("ggplot2")

# Figure 1 the US PM2.5 and COVID-19 death maps
#us<-map_data('state')

args <- commandArgs()


dates = c(args[6:length(args)])

fname = paste("./Race_Analyses/models/combined/",dates[1],".rda",sep="")
load(fname)
model_output <- eval(as.name(dates[1]))
number_params = length(c(model_output[10]$coefficients[,1]))



date_RRs = array(dim = c(length(dates),as.integer(number_params)))
date_lowers = array(dim = c(length(dates),as.integer(number_params)))
date_uppers = array(dim = c(length(dates),as.integer(number_params)))
date_pvals = array(dim = c(length(dates),as.integer(number_params)))
names = array(dim=as.integer(number_params))

for ( i in 1:length(dates)) {
  date = dates[i]
  fname = paste("./Race_Analyses/models/combined/",date,".rda",sep="")
  load(fname)
  model_output <- eval(as.name(date))
  model_output[10]
  model_output[10]$coefficients[,1]
  

  
  this_date_RR <- model_output[10]$coefficients[,1]
  this_date_lowers <- model_output[10]$coefficients[,1] - 1.96*model_output[10]$coefficients[,2]
  this_date_uppers <- model_output[10]$coefficients[,1] + 1.96*model_output[10]$coefficients[,2]
  this_date_pvals <- model_output[10]$coefficients[,4]
  
  names <- names(this_date_RR)
  
  date_RRs[i,]    <- unname(this_date_RR)
  date_lowers[i,] <- unname(this_date_lowers)
  date_uppers[i,] <- unname(this_date_uppers)
  date_pvals[i,] <- unname(this_date_pvals) 

}



# CREATE A TABLE FOR SIGNIFICANCE VALUES (P-Vals)
library(expss)
library(dplyr)
library(formattable)

t1 <- date_pvals[,]
output_name = paste("./Figs/combined_temporal.txt")
write.table(t1, file = output_name, append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = FALSE, qmethod = c("escape", "double"),
            fileEncoding = "")


output_name = paste("./Figs/combined_temporal.txt")
cols = (c("(Intercept)", "hispanic", "pct_blk", "pct_asian", "pct_white", "pct_native",
          "factor(q_popdensity)2", "factor(q_popdensity)3", "factor(q_popdensity)4", "factor(q_popdensity)5",
          "scale(log(medhouseholdincome))", "scale(education)", "scale(date_since_social)", "scale(date_since)", "scale(beds/population)"))
rows = (c("03-29", "04-05", "04-12", "04-19", "04-26", "05-03", "05-05", "05-12", "05-19", "05-26", "06-02", "06-09", "06-16"))
t1 <- read.table(file = output_name, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names = rows, col.names = cols, )
t1 <- t(t1)
significance = formatter("span",
                         style = x ~ style(color = ifelse(x > 0.05, "red", ifelse(x>0.01, "yellow","green"))))
t1 <- formattable(t1, formatter = significance)
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
