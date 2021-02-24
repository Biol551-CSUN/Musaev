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
#glimpse(EnviroData)
#view(EnviroData) #open data in a tab to review its structure
#glimpse(TPCData)
#view(TPCData) #open data in a tab to review its structure


##### Script #####
### Data formatting ###
EnviroData_wide <- EnviroData %>% #start pipeline for pivoting
  pivot_wider(names_from = parameter.measured, #put types of parameters measured in the columns...
              values_from = values #...and populate rows with "values"
  ) %>% #pass pipeline once more to arrange command on the next line
  arrange(site.letter) #arrange by site identifier
#View(EnviroData_wide) #verify pivoting and arranging

FullData_left<- left_join(TPCData, EnviroData_wide) #merge EnviroData_wide into TPCData, omitting sites absent in EnviroData_wide
#head(FullData_left) #demonstrate the merging

FullData_left<- left_join(TPCData, EnviroData_wide) %>% #pipeline to relocate
  relocate(where(is.numeric), .after = where(is.character)) #move columns with strings to the left, numeric data to the right
#head(FullData_left)#demonstrate relocation

### Statistics ###
#view(FullData_left) #open new tab with data to be processed
FullData_long <- FullData_left %>% #create pipeline for pivoting
  pivot_longer(cols = E:Topt, #select all numeric data columns (light through substrate.cover)
               names_to = "Variables", #create column for each variable type
               values_to = "Values" #populate column withreadings for each data type
  )
#view(FullData_long) #verify proper pivoting

FullData_stats <- FullData_long %>% #create pipeline for stats calcs
  group_by (Variables, site.letter) %>% #select parameters to group by
  summarize(site_mean = mean(Values, na.rm = TRUE), #calc means in new column site_mean
            site_var = var(Values, na.rm = TRUE) #calc variances in new column site_var
            #          ) %>%
            #pivot_wider (names_from = "site.letter", "Variables",
            #             values_from = "site_mean", "site_var"
  )
#view(FullData_stats)

### Tibble ###
