# Overview

Preprocessing --> Analysis --> Visualization

# Preprocessing.R

1. Read
2. Format (subset, rename, calculation)
3. Merge datasets on FIPS code
4. Save

```R
saveRDS(aggregate_chr_cdc_lung, file = 'Preprocessing_FTS_Outputs/06-28-2020data.Rds')
```

# Analysis

1. Read in data from files saved in Preprocessing.R. 

```R
aggregated_data <- readRDS('Preprocessing_FTS_Outputs/06-28-2020data.Rds')
```

2. Run Analysis -- "./Analyses"

  - National Analysis
    - "./NationalModel.R"
    - glmer.nb()
    
  - State Analysis
    - "./SingleState.R"
    - glm.nb()

3. Save results

  - National Analysis
    - Save summary for national result

```R
s <- summary(model)
save(s, file = "summary.rda")
```

  - State Analysis
    - Save summary for every single state
    - Dataframes for comparison

# Visualization

# Import Library

When importing libraries, do it in "Modules/Source.R"" and include this line in every R file you create.

```R
source("./Modules/Source.R")
```
# Parallelism

