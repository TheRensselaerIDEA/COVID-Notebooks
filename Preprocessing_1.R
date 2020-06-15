knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")

#------------------------------------------------------------------------------------------------------------------------------------------
# COPD datasets

COPD_national <- read_csv("Data/COPD_data_states.csv")

COPD_nys_county <- read_csv("Data/COPD_data_nyscounty.csv")
COPD_nys_county <- subset(COPD_nys_county, select = -c(`DSRIP Region Sort Key`))

#------------------------------------------------------------------------------------------------------------------------------------------
# High Cholesterol (Hyperlipidemia) datasets

highcholesterol_data_states <- read_csv("Data/highcholesterol_data_states.csv")
highcholesterol_data_states <- subset(highcholesterol_data_states, select = -c(Rank))

highcholesterol_data_nyscounty <- read_csv("Data/highcholesterol_data_nyscounty.csv")
highcholesterol_data_nyscounty <- subset(highcholesterol_data_nyscounty, select = -c(`DSRIP Region Sort Key`))
#------------------------------------------------------------------------------------------------------------------------------------------
# Age 65+ datasets

age65plus_data_states <- read_csv("Data/age65plus_data_states.csv")
age65plus_data_states$Percent <- age65plus_data_states$PopulationEstJuly2018_65plus/age65plus_data_states$PopulationEstJuly2018*100


age65plus_data_nyscounty <- read_csv("Data/age65plus_data_nyscounty.csv")
age65plus_data_nyscounty <- subset(age65plus_data_nyscounty, select = -c(State))
age65plus_data_nyscounty <- rename(age65plus_data_nyscounty, c(Percent = `% 65 and over`))

age65plus_data_uscounty <- read_csv("Data/age65plus_data_uscounty.csv")
age65plus_data_uscounty <- rename(age65plus_data_uscounty, c(Percent = `% 65 and over`))

#------------------------------------------------------------------------------------------------------------------------------------------
# Heart Disease / Cardiovascular Disease

heartdisease_deaths_data_states <- read_csv("Data/HeartDisease_DeathRate_States_CDC_2015.csv")

heartdisease_deaths_data_nyscounty <- read_csv("Data/heartdiseasedeaths_data_nyscounty.csv")

heartdisease_data_nyscounty <- read_csv("Data/heartdisease_data_nyscounty.csv")
heartdisease_data_nyscounty <- subset(heartdisease_data_nyscounty, select = -c(`DSRIP Region Sort Key`))

#------------------------------------------------------------------------------------------------------------------------------------------
# Adult Obesity

obesity_data_states <- read_csv("Data/obesity_data_states.csv")
obesity_data_states <- rename(obesity_data_states, c(Percent = pct_Adults_with_Obesity))

obesity_data_nyscounty <- read_csv("Data/diabetesobesity_data_nyscounty.csv")
obesity_data_nyscounty <- subset(obesity_data_nyscounty, select = -c(pct_Adults_with_Diabetes, no_Food_Insecure, pct_Food_Insecure))
obesity_data_nyscounty <- rename(obesity_data_nyscounty, c(Percent = pct_Adults_with_Obesity))

obesity_data_uscounty <- read_csv("Data/adultobesity_data_uscounty.csv")
obesity_data_uscounty <- rename(obesity_data_uscounty, c(Percent = `% Adults with Obesity`))

#------------------------------------------------------------------------------------------------------------------------------------------
# Diabetes

diabetes_data_states <- read_csv("Data/diabetes_data_states.csv")
diabetes_data_states <- rename(diabetes_data_states, c(Percent = pct_Adults_with_Diabetes))

diabetes_data_nyscounty <- read_csv("Data/diabetesobesity_data_nyscounty.csv")
diabetes_data_nyscounty <- subset(diabetes_data_nyscounty, select = -c(pct_Adults_with_Obesity, no_Food_Insecure, pct_Food_Insecure))
diabetes_data_nyscounty <- rename(diabetes_data_nyscounty, c(Percent = pct_Adults_with_Diabetes))

diabetes_data_uscounty <- read_csv("Data/diabetes_data_uscounty.csv")
diabetes_data_uscounty <- rename(diabetes_data_uscounty, c(Percent = `% Adults with Diabetes`))
