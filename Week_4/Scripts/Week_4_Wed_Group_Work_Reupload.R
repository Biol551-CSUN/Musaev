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
### Clean, format and select subset of data ###
ChemData_clean<-ChemData %>% #create pipeline for cleaning and formatting
  filter(complete.cases(.)) %>% #remove rows with NAs to clean data
  separate(col = Tide_time, #select column to split
           into = c("Tide","Time"), #split into new columns Tide and Time
           sep = "_", #separate values by underscore
           remove = FALSE #keep original column
  )
#view(ChemData_clean) #view full clean data in necessary

ChemData_spring<-ChemData_clean %>% #filter out a subset
  filter(Season == "SPRING") #only use data for spring

spring_long <-ChemData_spring %>% #pivot spring data
  pivot_longer(cols = Temp_in:percent_sgd, #pivot all...
               names_to = "Variables", #...variables into separate rows...
               values_to = "Values" #...and populate with values from columns
  ) 

### Statistics ###
spring_long %>% #create pipeline for stats
  group_by(Variables, Site) %>% #select site, zone and tide_time to work with
  summarise(Mean = mean(Values, na.rm = TRUE), #generate means in a column for every category selected...
            Variance = var(Values, na.rm = TRUE), #...variances...
            StDev = sd (Values, na.rm = TRUE) #...and standard deviations
  ) %>%
  write_csv(here("Week_4","Output","Group_work.csv")) #write stats to file
#view(spring_long)

### Plot ###
spring_wide<-spring_long %>% #pivot data back to wide for plotting
  pivot_wider(names_from = Variables, #"widen" from rows
              values_from = Values) #populate with values from
#view(spring_wide)

spring_wide %>%
  ggplot(aes(x = pH, y = TA))+ #generate axes
  geom_point(aes(color = Site), #create scatterplot
  )+
  labs(title = "pH vs Total Alkalinity in Spring", #add title
       subtitle = "For sites W and BP", #add subtitle
       caption = "Maunalua, Hawaii", #add caption
       x = "pH", #add X axis label
       y = "Total Alkalinity, umol/Kg", #add Y axis label
       color = "Site" #add legend label
  )
theme_bw()#change theme of the plot background 
