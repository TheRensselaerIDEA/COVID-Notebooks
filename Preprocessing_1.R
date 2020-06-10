knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")

#------------------------------------------------------------------------------------------------------------------------------------------
# COPD datasets

#COPD_national <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/COPD_national.csv"))
#COPD_nys_county <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/COPD_nys_county.csv"))

COPD_national <- read_csv("data/COPD_national.csv")
COPD_nys_county <- read_csv("data/COPD_nys_county.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# High Cholesterol (Hyperlipidemia) datasets

#highcholesterol_data_states <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/highcholesterol_data_states.csv"))
#highcholesterol_data_nyscounty <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/highcholesterol_data_nyscounty.csv"))

highcholesterol_data_states <- read_csv("data/highcholesterol_data_states.csv")
highcholesterol_data_nyscounty <- read_csv("data/highcholesterol_data_nyscounty.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# Age 65+ datasets

#age65plus_data_states <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/age65plus_data_states.csv"))
#age65plus_data_nyscounty <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/age65plus_data_nyscounty.csv"))

age65plus_data_states <- read_csv("data/age65plus_data_states.csv")
age65plus_data_nyscounty <- read_csv("data/age65plus_data_nyscounty.csv")
