#!/usr/bin/env bash

echo `Rscript Preprocessing.R`

declare -a file_names=("zero_pct_blk.R" "white.R" "pct_blk_exnyc.R" "pct_blk.R" "native.R" "hispanic.R" "combined.R" "asian_exnyc.R" "asian.R")

for file in "${file_names[@]}"; do {
  echo `Rscript Race_Analyses/$file` &
} done

#echo `Rscript Figure.R`