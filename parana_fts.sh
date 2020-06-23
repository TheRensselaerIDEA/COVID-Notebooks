#!/usr/bin/env bash

#declare -a dates_names=("05-05" "05-12" "05-19" "05-26" "06-02" "06-09" "06-16")
declare -a dates_names=("03-29" "04-05" "04-12" "04-19" "04-26" "05-03" "05-10" "05-17" "05-24" "05-31" "06-07" "06-14" "06-21")

fname="combined.R"
#echo `Rscript ./Race_Analyses/$fname  ./Fixed_Date_Time_Series/05-05-2020data.Rds`



for date in "${dates_names[@]}"; do {
  #echo `Rscript ./Race_Analyses/$fname  ./Fixed_Date_Time_Series/$date\-2020data.Rds`&
  echo `Rscript ./Preprocessing.R  $date`&
} done

#echo `Rscript Figure.R`