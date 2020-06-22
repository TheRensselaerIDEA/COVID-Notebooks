load("~/COVID-Notebooks/Race_Analyses/models/combined/05-05.rda")
load("~/COVID-Notebooks/Race_Analyses/models/combined/05-12.rda")
load("~/COVID-Notebooks/Race_Analyses/models/combined/05-19.rda")
load("~/COVID-Notebooks/Race_Analyses/models/combined/05-26.rda")
load("~/COVID-Notebooks/Race_Analyses/models/combined/06-02.rda")
load("~/COVID-Notebooks/Race_Analyses/models/combined/06-09.rda")
load("~/COVID-Notebooks/Race_Analyses/models/combined/06-16.rda")
s <- get("06-14")
mrr <- s[10]$coefficients[2,1]
mrr
p <- s[10]$coefficients[2,4]
p
#"03-29" "04-05" "04-12" "04-19" "04-26" 
#"05-03" "05-10" "05-17" "05-24" "05-31" 
#"06-07" "06-14"