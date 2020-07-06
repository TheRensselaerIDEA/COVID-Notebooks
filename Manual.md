# Overview

Preprocessing --> Analysis --> Visualization

# Preprocessing.R

1. Read
2. Format (subset, rename, calculation)
3. Merge datasets on FIPS code
4. Save

```R
saveRDS(aggregate_chr_cdc_lung, file = 'Fixed_Date_Time_Series/06-28-2020data.Rds')
```

# Analysis

1. Read in data from files saved in Preprocessing.R. 

```R
aggregated_data <- readRDS('Fixed_Date_Time_Series/06-28-2020data.Rds')
```

2. Run Analysis

  - Nation Analysis
  - State Analysis

3. Save results

```R
s <- summary(model)
save(s, file = "summary.rda")
```

# Visualization

# Import Library

When importing libraries, do it in Source.R and include this line in every R file you create.

```R
source("./Modules/Source.R")
```
# Parallelism

