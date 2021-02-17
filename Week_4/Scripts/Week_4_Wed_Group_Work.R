##### Week 4, Wed Group Work #####
##### Feb 17, 2021 #####

##### Load Libraries #####
library(tidyverse)
library(here)

##### Load Data #####
ChemData<-read_csv(here("Week_4","data", "chemicaldata_maunalua.csv")) #path to data file
glimpse(ChemData) #verify data is loaded
#View(ChemData) #view full data if necessary

##### Script #####
ChemData_clean<-ChemData %>% #create pipeline for cleaning and formatting
  filter(complete.cases(.)) %>% #remove rows with NAs to clean data
  separate(col = Tide_time, #select column to split
         into = c("Tide","Time"), #split into new columns Tide and Time
         sep = "_", #separate values by underscore
         remove = FALSE #keep original column
)
#view(ChemData_clean) #view full clean data in necessary



