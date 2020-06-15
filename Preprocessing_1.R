knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "./")

source("./Modules/Source.R")

#------------------------------------------------------------------------------------------------------------------------------------------
# COPD datasets

COPD_national <- read_csv("Data/COPD_data_states.csv")

COPD_nys_county <- read_csv("Data/COPD_data_nyscounty.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# High Cholesterol (Hyperlipidemia) datasets

highcholesterol_data_states <- read_csv("Data/highcholesterol_data_states.csv")

highcholesterol_data_nyscounty <- read_csv("Data/highcholesterol_data_nyscounty.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# Age 65+ datasets

age65plus_data_states <- read_csv("Data/age65plus_data_states.csv")

age65plus_data_nyscounty <- read_csv("Data/age65plus_data_nyscounty.csv")

age65plus_data_uscounty <- read_csv("Data/age65plus_data_uscounty.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# Heart Disease / Cardiovascular Disease

heartdisease_deaths_data_states <- read_csv("Data/HeartDisease_DeathRate_States_CDC_2015.csv")

heartdisease_deaths_data_nyscounty <- read_csv("Data/heartdiseasedeaths_data_nyscounty.csv")

heartdisease_data_nyscounty <- read_csv("Data/heartdisease_data_nyscounty.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# Adult Obesity

obesity_data_states <- read_csv("Data/obesity_data_states.csv")

obesity_data_nyscounty <- read_csv("Data/diabetesobesity_data_nyscounty.csv")
obesity_data_nyscounty <- subset(obesity_data_nyscounty, select = -c(pct_Adults_with_Diabetes))

obesity_data_uscounty <- read_csv("Data/adultobesity_data_uscounty.csv")

#------------------------------------------------------------------------------------------------------------------------------------------
# Diabetes

diabetes_data_states <- read_csv("Data/diabetes_data_states.csv")

diabetes_data_nyscounty <- read_csv("Data/diabetesobesity_data_nyscounty.csv")
diabetes_data_nyscounty <- subset(diabetes_data_nyscounty, select = -c(pct_Adults_with_Obesity))

diabetes_data_uscounty <- read_csv("Data/diabetes_data_uscounty.csv")
