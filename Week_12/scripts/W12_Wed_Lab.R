library(tidyverse)
library(here)
library(janitor)

raw_data <- read_csv(here("Week_12","data","intertidaldata.csv")) %>% # Load raw data from file into a dataframe
clean_names() # remove spaces from column names to make them referenceable 

### Method 1: Cleaning and ordering data using str_replace, then assigning factors ###
### Preferred method as it fixes a range of typos ###
clean_data <- raw_data %>% # new pipe to clean up typos
  mutate(quadrat = str_replace_all(quadrat, "[^[:alpha:]]", "")
         ) # remove all non-alphabetical characters in the Quadrat column

data_w_fct <- clean_data %>% # pipe to order data
  mutate(quadrat = fct_lump(quadrat)
         ) # convert Quadrat entries into factors

#view(data_w_fct) # check that typos are removed
#head(data_w_fct) # check that Quadrat entries are now factors


### Method 2: Assigning factors without cleaning up typos first ###
### Uses techniques from today's class, however it only removes specified typos ###
factor_cleaned_data <- raw_data %>%
  mutate(quadrat = fct_recode(quadrat, "Mid" = "Mid  1")
         ) %>%
  mutate(quadrat = fct_recode(quadrat, "Low" = "Low  .")
         ) %>% # use a factor function to remove particular typos: "Mid 1" and "Low ." as well as spaces
  clean_names() # remove spaces from column names

#view(factor_cleaned_data) # check typo removal
#head(factor_cleaned_data) # check factor assignment



### Plot data ###
### Uses data cleaned with method 1 ###

data_w_fct$quadrat <- factor(data_w_fct$quadrat,
                                     levels = c("Low", "Mid", "High")
                                     ) # reorder quadrats in a specified order for plotting and write to quadrat column in the dataframe

data_w_fct %>%
  ggplot(aes(x = quadrat,
             y = bare_rock)
         )+ # specify axes
  geom_violin() + # add violin plot
  labs(x = "Quadrat", 
       y = "Percentage of bare rock", 
       title = "Percentage of bare rocks during 3 tide levels"
       ) + # add labels
  ggsave(here("Week_12","output","Rock_vs_tide.jpg"),
         width = 5, height = 7) #save to file and adjust size