##### Week 5 Wednesday Classwork #####
##### Feb 24, 2021 #####

##### Install new package #####
#install.packages("lubridate")

##### Load Libraries #####
library(tidyverse)
library(here)
library(lubridate)

##### Practice with dates #####
#now()
ymd("21-02-24")
ymd_hms("21-02-24 9:14:30 AM")

datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")

datetimes <- mdy_hms(datetimes) 

day(datetimes)

wday(datetimes, label = TRUE)
month(datetimes, label = TRUE, abbr = FALSE)

hour(datetimes) 
minute(datetimes) 
second(datetimes)

datetimes + hours (36) +days(1000)

round_date(datetimes, "3 mins")


##### Data processing #####
### Load data ###
CondData<-read_csv(here("Week_5","data","CondData.csv")) %>%
mutate(Datetime = mdy_hms(date))
view(CondData)
