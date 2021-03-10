

install.packages("ggmap") # for ggmaps
install.packages("ggsn") # to add scale bars and compass arrows
library(ggmap)
library(tidyverse)
library(here)
library(ggsn)

ChemData<-read_csv(here("Week_7","data","chemicaldata_maunalua.csv"))
glimpse(ChemData)
