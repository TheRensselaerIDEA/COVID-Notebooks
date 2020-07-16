#!/usr/bin/env bash


declare -a dates_names=("03-29" "04-05" "04-12" "04-19" "04-26" "05-03" "05-10" "05-17" "05-24" "05-31" "06-07" "06-14" "06-21" "06-28" "07-05" "07-12")
#declare -a dates_names=("05-10" "05-17" "05-24" "05-31" "06-07" "06-14")

#fname="combined.R"
#echo `Rscript ./Race_Analyses/$fname  ./Fixed_Date_Time_Series/05-05-2020data.Rds`

for date in "${dates_names[@]}"; do {
  echo `Rscript ./Preprocessing/Preprocessing.R  $date`&
} done



# Add a line to wait for all Preprocessing code to finish...

#for date in "${dates_names[@]}"; do {
#  echo `Rscript ./Race_Analyses/$fname  ./Fixed_Date_Time_Series/$date\-2020data.Rds`&
#}

#echo `Rscript ./Auto_Figures.R ${dates_names[@]}`

#echo `Rscript Figure.R`