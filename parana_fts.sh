#!/usr/bin/env bash

# declare dates we want to go through
# mask: 4/10   |   reopen: 4/24   |   reclosure: 6/26
# declare -a dates_names=("03-29" "04-05")
# declare -a dates_names=("04-12" "04-19")
# declare -a dates_names=("04-26" "05-03" "05-10" "05-17" "05-24" "05-31" "06-07" "06-14" "06-21")
# declare -a dates_names=("06-28" "07-05" "07-12")
declare -a dates_names=("03-29" "04-05" "04-12" "04-19" "04-26" "05-03" "05-10" "05-17" "05-24" "05-31" "06-07" "06-14" "06-21" "06-28" "07-05" "07-12")

# declare R files we want to run
fname="Preprocessing.R"

# Preprocessing
for date in "${dates_names[@]}"; do {
  echo `Rscript ./Preprocessing/$fname  $date`&
} done

# Analyses
# for date in "${dates_names[@]}"; do {
#   echo `Rscript ./Analyses/$fname  ./Preprocessing_FTS_Outputs/$date\-2020data.Rds`&
# } done


# Visualization
# echo `Rscript ./Auto_Figures.R ${dates_names[@]}`

# echo `Rscript Figure.R`