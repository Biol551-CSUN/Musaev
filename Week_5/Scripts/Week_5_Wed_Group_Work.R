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
  mutate(date = ymd_hms(date))%>% #convert to standard date format
  mutate(date = round_date(date, "10 sec")) #round the time to match the other dataset
         
DepthData <- DepthData %>%
  mutate(date = ymd_hms(date))%>% #convert to standard date format
  mutate(date = round_date(date, "10 sec")) #round the time to match the previous dataset

FullData<-inner_join(CondData, DepthData) #combine only overlapping data from both sets
#view(FullData)

FullData<-FullData %>% 
mutate(time = paste(hour(date), #extract time into separate column
                    minute(date),
                    sep = ":") #hour and min separated by ":"
       )
#view(FullData)

##### Calculations #####

FullData<-FullData %>%
  group_by(time) %>% #assign time values as the "backbone" for mean calcs
  summarize(Mean_temp = mean(TempInSitu),
            Mean_salinity = mean(SalinityInSitu_1pCal),
            Mean_pressure = mean(AbsPressure), 
            Mean_depth = mean(Depth)) #calculate means for each variable in separate columns

view(FullData) #verify data before plotting

##### Plot #####
ggplot(data = FullData, #select data set
       mapping = aes(x = Mean_depth,
                     y = Mean_temp))+ #set axes
  geom_point()+ #add simple dot for each reading
  labs(x = "Depth, m", #labels for x axis
       y = "Temperature, °C", #label for y axis
       title = "Water temperature at different depths", #title on the top
       caption = "Becker and Silbiger (2020)")+ #reference as caption
  theme_bw() #better background

ggsave(here("Week_5","Output","Wed_group.jpg"),#save plot
       width = 7, height = 5) #set aspect ratio