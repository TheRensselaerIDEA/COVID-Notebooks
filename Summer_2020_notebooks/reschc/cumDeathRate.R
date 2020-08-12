library(tidyverse)
library(sp)
library("raster")
library("dplyr")
library("sf")
library("stringr")
library("ggplot2")
library(grid) 
library(pBrackets) 
library(gridExtra)
library("lme4")
library("maps")
library("rgdal")
library(raster)

# Figure 1 the US PM2.5 and COVID-19 death maps
us<-map_data('state')

#Plot prevalence of COVID-19
#states <- shapefile("./Summer_2020_notebooks/reschc/cb_2017_us_county_500k/cb_2017_us_county_500k.shp")
#states <- readOGR("./Summer_2020_notebooks/reschc", layer = "cb_2017_us_county_500k")
states <- st_read("./Summer_2020_notebooks/reschc/cb_2017_us_county_500k/cb_2017_us_county_500k.shp", drivers="ESRI Shapefile")

aggregate_pm_census_cdc_test_beds$fips = str_pad(aggregate_pm_census_cdc_test_beds$fips, 5, pad = "0")
covid_us <- mutate(aggregate_pm_census_cdc_test_beds,
                   STATEFP = str_sub(fips, 1, 2),
                   COUNTYFP = str_sub(fips, 3, 5))
str(covid_us)
str(states)
states$STATEFP=as.character(states$STATEFP)
states$COUNTYFP=as.character(states$COUNTYFP)
statesCOVID <- left_join(states, covid_us, by = c("STATEFP", "COUNTYFP"))
statesCOVID$mortality = statesCOVID$Deaths/statesCOVID$population*10^6
statesCOVID$logmortality = log10(statesCOVID$Deaths/statesCOVID$population*10^6)
statesCOVID$logmortality[statesCOVID$logmortality < 0] = -1
statesCOVID$logmortality[is.na(statesCOVID$logmortality)] = -1

g1<-ggplot(statesCOVID)+
  xlim(-125,-65)+ylim(25,50)+
  #  geom_sf(aes(fill = PD_p),color=NA,size=0.025)+
  geom_sf(aes(fill = logmortality),color='grey',size=0.005)+
  #  scale_fill_viridis_c(option="magma",begin=0.4)+
  scale_fill_gradient2(expression(paste("# COVID-19 deaths per 1 million")),low  = "#1e90ff", mid="#ffffba", high = "#8b0000",midpoint = 1,
                       breaks = c(-1,0,1,2,3),
                       labels = c("0","1","10","100","1000+"),limits = c(-1,3.4) , na.value = "white") +
  # labs(title = expression(paste("Cumulative Deaths Related to COVID-19 until March 30, 2020"))) +
  theme_minimal() +
  theme(plot.title = element_text(size = 24*2,hjust = 0.5),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        line = element_blank(),
        axis.title = element_blank(),
        legend.position = "bottom",
        legend.direction = "horizontal", 
        legend.text = element_text(angle = 60,  size = 20*2),
        legend.text.align = 0.75,
        legend.title = element_text(size = 10*2),
        legend.key.width = unit(40*2, "points"),
        panel.grid.major = element_line(colour = "transparent"))

png("county_covid.jpeg", height = 1024*0.6*2, width = 1024*2)
print(g1)
dev.off()
