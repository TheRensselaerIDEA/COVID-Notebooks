
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
# eatGet      # Saving glmer models to memory
#~~~~~~~~~~~~~~~ From Shayom's code
# caret
# blmeco
# pROC
# VineCopula
# PerformanceAnalytics
# ggfortify
# foreign
# psych
# ResourceSelection
# ROCR
# klaR
# heplots
# hermite
# lattice
# plyr
# boot
# DescTools
# car
# multcompView
# emmeans
# pscl
# rcompanion
# robust
# AER


dependencies <- c("AER" ,"robust", "rcompanion", "pscl",  "emmeans", "multcompView", "car", "DescTools", "boot", "plyr", "lattice", "hermite", "heplots", "klaR", "ROCR", "ResourceSelection", "psych", "foreign", "ggfortify", "PerformanceAnalytics", "VineCopula", "pROC", "blmeco", "caret", "eatGet","devtools", "lubridate", "data.table", "httr", "RCurl", "tidyverse", "sp", "raster", "dplyr", "sf", "stringr" , "ggplot2", "grid", "pBrackets", "gridExtra", "lme4", "maps", "MASS", "gamm4", "glmmTMB")

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



library('caret')
library('blmeco')
library(pROC)
library(VineCopula)
library("PerformanceAnalytics")

library(ggfortify)
library(foreign)
library(psych)
library(ResourceSelection)
library(ROCR)

library(klaR)
library(heplots)
library(hermite)
library(lattice)
library(plyr)
library(boot)
library(DescTools)
library(car)
library(multcompView)
library(emmeans)
library(pscl)
library(rcompanion)
library(robust)
library(AER)
