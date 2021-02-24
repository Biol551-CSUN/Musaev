##### Week 5 Wednesday Group Work #####
##### Feb 24, 2021 #####

##### Load Libraries #####
library(tidyverse)
library(here)
library(lubridate)

##### Load Data #####
CondData<-read_csv(here("Week_5","data","CondData.csv")) #conductivity data
DepthData<-read_csv(here("Week_5","data","DepthData.csv")) #depth data

##### Format Data #####
CondData <- CondData %>%
  mutate(date = ymd_hms(date))%>%
  mutate(date = round_date(date, "10 sec"))
         
DepthData <- DepthData %>%
  mutate(date = ymd_hms(date))%>%
  mutate(date = round_date(date, "10 sec"))

FullData<-inner_join(CondData, DepthData)
#view(FullData)

FullData<-FullData %>%
mutate(time = paste(hour(date),
                    minute(date),
                    sep = ":")
       )
#view(FullData)

FullData<-FullData %>%
  group_by(time) %>%
  summarize(mean(TempInSitu),
            mean(SalinityInSitu_1pCal),
            mean(AbsPressure), 
            mean(Depth))

view(FullData)