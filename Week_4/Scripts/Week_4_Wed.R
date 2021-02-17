##### Week 4, Wed Class Work #####
##### Feb 17, 2021 #####

##### Load Libraries #####
library(tidyverse)
library(here)

##### Load Data #####
ChemData<-read_csv(here("Week_4","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

##### Analysis #####
ChemData_clean<-ChemData %>%
  filter(complete.cases(.) #remove rows with incomplete data
         )
view(ChemData_clean) #verify the filter command


separate(col = Tide_time, #underscore splits a value in two separate values
         into = c("Tide","Time"), #populate two columns with split values generated above
         sep = "_", #character to separate with
         remove = FALSE #in case we do not want to remove the original column
)
head(ChemData_clean) #verify the separation command


unite(col = "Site_Zone", #create new column
       c(Site,Zone), #designate columns to unite
       sep = ".", #character to put between the joined values
       #remove = FALSE) #if we want to keep the original
)
head(ChemData_clean)

#Pivot data:
ChemData_long <-ChemData_clean %>% #create pipeline for pivoting
  pivot_longer(cols = Temp_in:percent_sgd, #select cols temp_in through percent_sgd
               names_to = "Variables", #name of the column to generate for temp_in through percent_sgd designations
               values_to = "Values" #name of the column to generate for the values for each
               ) 

ChemData_long %>%
  group_by(Variables, Site) %>% #select variables and site
  summarise(Param_means = mean(Values, na.rm = TRUE), #generate column param_means, populate with means for each site
            Param_vars = var(Values, na.rm = TRUE)  #generate column param_vars, populate with variance for each site
            )

ChemData_long %>%
  group_by(Variables, Site, Zone, Tide_time) %>% #select site, zone and tide_time to work with
  summarise(Param_means = mean(Values, na.rm = TRUE), #generate means in a column for every category selected...
            Param_vars = var(Values, na.rm = TRUE), #...variances...
            Param_stdev = sd (Values, na.rm = TRUE) #...and standard deviations
            )

### Generate Plot ###
ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+ #generate axes
  geom_boxplot()+ #generate boxplot with the values
  facet_wrap(~Variables, scales = "free"  #facet plot for each value
             )

ChemData_wide<-ChemData_long %>% #pivot data back to wide
  pivot_wider(names_from = Variables, #"widen" from rows
              values_from = Values) #populate with
#view(ChemData_wide)

ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #remove rows with NAs
  separate(col = Tide_time, #select column to separate
           into = c("Tide","Time"), #separate it into
           sep = "_", #separate by underscore
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, #columns to pivot
               names_to = "Variables", #generate new row for each of 
               values_to = "Values") %>% #populate with values from column
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% #group outputs
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% #pivot the outputs wide
  write_csv(here("Week_4","Output","Summary.csv")) #save to file

         


#view(ChemData_clean)

