knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")

#------------------------------------------------------------------------------------------------------------------------------------------
# COPD datasets

#COPD_national <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/COPD_national.csv"))
#COPD_nys_county <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/COPD_nys_county.csv"))

COPD_national <- read_csv("data/COPD_national.csv")
COPD_national$FIPS <- fips(COPD_national$State)

COPD_nys_county <- read_csv("data/COPD_nys_county.csv")
COPD_nys_county$FIPS <- fips("NY", COPD_nys_county$County)

#------------------------------------------------------------------------------------------------------------------------------------------
# High Cholesterol (Hyperlipidemia) datasets

#highcholesterol_data_states <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/highcholesterol_data_states.csv"))
#highcholesterol_data_nyscounty <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/highcholesterol_data_nyscounty.csv"))

highcholesterol_data_states <- read_csv("data/highcholesterol_data_states.csv")
highcholesterol_data_states$FIPS <- fips(highcholesterol_data_states$`State Name`)

highcholesterol_data_nyscounty <- read_csv("data/highcholesterol_data_nyscounty.csv")
highcholesterol_data_nyscounty$FIPS[highcholesterol_data_nyscounty$County != "New York City"] <- fips("NY", highcholesterol_data_nyscounty$County)
highcholesterol_data_nyscounty$FIPS[highcholesterol_data_nyscounty$County == "New York City"] <- 'NA'

#------------------------------------------------------------------------------------------------------------------------------------------
# Age 65+ datasets

#age65plus_data_states <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/age65plus_data_states.csv"))
#age65plus_data_nyscounty <- read_csv(text=getURL("https://raw.githubusercontent.com/Mouhongkiii/COVID-Notebooks/PM_COVID/data/age65plus_data_nyscounty.csv"))

age65plus_data_states <- read_csv("data/age65plus_data_states.csv")
age65plus_data_states$FIPS <- fips(age65plus_data_states$Geography)

age65plus_data_nyscounty <- read_csv("data/age65plus_data_nyscounty.csv")
age65plus_data_nyscounty$FIPS[age65plus_data_nyscounty$County != "New York" & !is.na(age65plus_data_nyscounty$County)] <- fips("NY", age65plus_data_nyscounty$County)
