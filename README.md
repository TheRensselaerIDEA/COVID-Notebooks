# Social Determinants of COVID-19 mortality in the United States
This is the data repository for publicly available code and data to reproduce analyses created by IDEA HEALTH INCITE @ RPI during the summer of 2020.

<b>Code: </b><br>
[`Prepossing.R`](https://github.com/TheRensselaerIDEA/COVID-Notebooks/tree/PM_COVID/Preprocessing.R) includes the code to extract all necessary data and prepocess data for statistical analyses.

[`Analyses.R`](https://github.com/TheRensselaerIDEA/COVID-Notebooks/tree/PM_COVID/Analyses.R) includes the code to implement negative binomial mixed models in primary, secondary and sensitivity analyses.

[`Figure.R`](https://github.com/TheRensselaerIDEA/COVID-Notebooks/tree/PM_COVID/PM_Notebook/*.Rmd) 
includes all relavent R Notebooks to be used for figure generation.


[`additional_preprocessing_code`](https://github.com/wxwx1993/PM_COVID/tree/master/additional_preprocessing_code) contains markdown files with code demonstrating the methodology we used to aggregate our zip code level data to the county level.


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


<b>Data: </b><br>
county_pm25.csv: the county-level PM2.5 exposure data averaged across the period 2000-2016 and averaged across grid cells in each county. For more source information see Additional Data Source section.

temp_seasonal_county.csv: the county-level seasonal temperature and relative humidity data, summer and winter averaged across the period 2000-2016 and averaged across grid cells in each county. For more source information see Additional Data Source section.

census_county_interpolated.csv: the county-level socioeconomic and demographic variables from 2012-2016 American Community Survey (https://www.census.gov/programs-surveys/acs/data.html).

county_base_mortality.txt, county_old_mortality.txt: additional county-level socioeconomic and demographic variables from 2009-2016 
US CDC Compressed Mortality Data (https://wonder.cdc.gov/cmf-ICD10.html).

brfss_county_interpolated.csv: the county-level behavioral risk factor variables for 2011 US CDC Behavioral Risk Factor Surveillance System (https://www.cdc.gov/brfss/).

statecode.csv: A map between state name and state abbreviations.

<b>Additional Data Source: </b><br>
The county-level PM2.5 exposure data can be created via PM2.5 predictions from The Atmospheric Composition Analysis Group at Dalhouse University (http://fizz.phys.dal.ca/~atmos/martin/). Please visit the detailed instructions below

The seasonal temperature and relative humidity data can be created via 4km × 4km temperature and relative humidity predictions from Gridmet via google earth engine (https://developers.google.com/earth-engine/datasets/catalog/IDAHO_EPSCOR_GRIDMET).

We thank John Abatzoglou and members of the Climatology Lab at University of Idaho for providing the GRIDMET open-source datasets. 

* Johns Hopkins University the Center for Systems Science and Engineering (CSSE) Coronavirus Resource Center: https://coronavirus.jhu.edu/ <br>
* Homeland Infrastructure Foundation- Level Data (HIFLD): https://hifld-geoplatform.opendata.arcgis.com/datasets/hospitals <br>
* The COVID tracking project: https://covidtracking.com/ <br>

