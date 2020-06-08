#!/usr/bin/env bash

echo `Rscript Preprocessing.R`

declare -a file_names=("aggregate_beds.R" "log_pop.R" "smoking_bmi.R" "lt_10_confirmed.R" "spatial_correlation_gamm.R" "beds.R" "main_analyses.R" "temp_humidity.R" "cli.R" "non_linear_pm.R" "tested.R" "exclude_NY_metro.R" "nonlog_pop.R" "urban.R" "fixed_NB.R" "outbreak.R" "zero_inflated.R")

for file in "${file_names[@]}"; do {
  echo `Rscript Analyses/$file` &
} done
