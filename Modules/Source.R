
##### Load packages ####

# List of packages used:
# tidyverse
# sp
# raster
# dplyr
# sf
# stringr
# ggplot2
# grid
# pBrackets
# gridExtra
# lme4
# maps
# glmmTMB
# gamm4
# MASS
# RCurl
# httr
# data.table
# devtools
# NSAPHutils  # For threading w/ big data
# NSAPHplatform
# lubridate

dependencies <- c("devtools", "lubridate", "data.table", "httr", "RCurl", "tidyverse", "sp", "raster", "dplyr", "sf", "stringr" , "ggplot2", "grid", "pBrackets", "gridExtra", "lme4", "maps", "MASS", "gamm4", "glmmTMB")

# Check and install packages not yet available
install.dependencies <- dependencies[!(dependencies %in% installed.packages()[, "Package"])]
if (length(install.dependencies) > 0) {
  install.packages(install.dependencies)
}

library("tidyverse")
library("sp")
library("raster")
library("dplyr")
library("sf")
library("stringr")
library("ggplot2")
library("grid") 
library("pBrackets") 
library("gridExtra")
library("lme4")
library("maps")
# in analyses...
library("glmmTMB")
library("gamm4")
library("MASS")
# in preprocess...
library("RCurl")
library("httr")
# in additional preprocessing... 
library("data.table")
library("devtools")
if (!require("NSAPHutils")){
  devtools::install_github("NSAPH/NSAPHutils") # need to be accessed via devtools
  library("NSAPHutils")
}
#set_threads()
#devtools::install_github("NSAPH/NSAPHplatform")
#library("NSAPHplatform")
library("lubridate")
library("usmap")
