#!/usr/bin/env bash

declare -a var_names=("% Fair or Poor Health" "Average Number of Physically Unhealthy Days" "% Smokers" "% With Access to Exercise Opportunities" 
"# Chlamydia Cases" "Chlamydia Rate" "% Uninsured" "# Primary Care Physicians" "# Mental Health Providers" "Mental Health Provider Rate" "Mental Health Provider Ratio"
"Preventable Hosp. Rate (White)" "% Screened (White)" "Labor Force" "% Unemployed" "# Households" "Average Daily PM2.5" "Presence of Water Violation" 
"# Workers who Drive Alone" "% Long Commute - Drives Alone" "infant_deaths" "% Frequent Physical Distress" "# HIV Cases" "# Food Insecure" "# Limited Access" 
"# Drug Overdose Deaths" "# Motor Vehicle Deaths" "MV Mortality Rate (White)" "% Insufficient Sleep" "# Uninsured_1" "% Uninsured_1" "# Uninsured_2" "% Uninsured_2" 
"Other Primary Care Provider Rate" "Average Grade Performance (White)_1" "Segregation index" "suicide_deaths" "# Homeowners" "# Households with Severe Cost Burden" 
"# less than 18 years of age" "% Not Proficient in English" "reclosure" "mask" "date_since_social" "date_since_reopen" "date_since_reclosure" "date_since_mask" "beds" 
"date_since" "All.Cause.death_rate" "Assault.death_rate" "Cancer.death_rate" "Cardiovascular.death_rate" "Despair.death_rate" "PediatricAsthma" "AdultAsthma" "COPD" 
"AdultChronicLungDisease"  )

fname="NBGWAS.R"


for var in "${var_names[@]}"; do {
  echo `Rscript $fname var`&
} done
