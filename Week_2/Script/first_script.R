# first script to import data
# date: Feb 3, 2021
#############################

#### Load libraries ####
library(tidyverse)
library(here)

#### Read in data ####
WeightData<-read_csv(here("Week_2","Data","weightdata.csv"))

#### Data Analysis ####
head(WeightData)
tail(WeightData)
view(WeightData)

