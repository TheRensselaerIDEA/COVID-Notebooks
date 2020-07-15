#!/usr/bin/env bash


# removed variables:
# "fips" "Admin2" "Country_Region" "Combined_Key" "X" "date" "lastUpdateEt" "dateModified" "checkTimeEt" "fips.y" "hash" "Abbrev"

declare -a var_names=("Province_State" "mean_pm25" "mean_winter_temp" "mean_summer_temp" "mean_winter_rm" "mean_summer_rm"
                        "Last_Update" "Lat" "Long_" "Confirmed" "Deaths" "Recovered" "Active" 
                      "Incidence_Rate" "Case.Fatality_Ratio"  "year" "poverty" "popdensity" "medianhousevalue" "pct_blk"
                      "medhouseholdincome" "pct_owner_occ" "hispanic" "education" "population" "pct_asian" "pct_native" "pct_white"
                      "q_popdensity" "obese" "smoke" "Population" "older_pecent" "young_pecent" "prime_pecent" "mid_pecent" "state"
                       "positive" "negative" "pending" "hospitalizedCurrently" "hospitalizedCumulative" "inIcuCurrently"
                      "inIcuCumulative" "onVentilatorCurrently" "onVentilatorCumulative" "recovered" "dataQualityGrade"
                       "death" "hospitalized" "dateChecked" "positiveTestsViral"
                      "positiveCasesViral" "deathConfirmed" "deathProbable"  "positiveIncrease" "negativeIncrease" "total"
                      "totalTestResults" "totalTestResultsIncrease" "posNeg" "deathIncrease" "hospitalizedIncrease" 
                      "commercialScore" "negativeRegularScore" "negativeScore" "positiveScore" "score" "grade"  "stay_at_home"
                      "reopen" "reclosure" "mask" "date_since_social" "date_since_reopen" "date_since_reclosure" "date_since_mask" "beds"
                      "date_since" "2013 code" "pct_diabetes" "pct_obesity" "pct_age65" "death_rate" "All.Cause.death_rate" 
                      "Assault.death_rate" "Cancer.death_rate" "Cardiovascular.death_rate" "Despair.death_rate" "PediatricAsthma" 
                      "AdultAsthma" "COPD" "AdultChronicLungDisease" "LungCancer")

fname="NBGWAS.R"


for var in "${var_names[@]}"; do {
  echo `Rscript $fname var`&
}

