#!/usr/bin/env bash

declare -a dates_names=("05-05" "05-12" "05-19" "05-26" "06-02" "06-09" "06-16")


fname="combined.R"
#echo `Rscript ./Race_Analyses/$fname  ./Fixed_Date_Time_Series/05-05-2020data.Rds`



for date in "${dates_names[@]}"; do {
  echo `Rscript ./Race_Analyses/$fname  ./Fixed_Date_Time_Series/$date\-2020data.Rds`&
} done

#echo `Rscript Figure.R`