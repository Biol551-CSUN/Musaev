##### Feb 22, 2021 #####
##### Classwork #####


##### Load Libraries #####
library(tidyverse)
library(here)


##### Load Data #####
# Environmental data from each site
EnviroData<-read_csv(here("Week_5","data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData<-read_csv(here("Week_5","data","Topt_data.csv"))

### Check Data ###
glimpse(EnviroData)
#view(EnviroData) 

glimpse(TPCData)
#view(TPCData)
