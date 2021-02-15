##### Feb 15, 2021 #####
##### Group work #####

##### Load Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins)

##### Analysis #####
### Part 1 ###
mean_and_var <- penguins %>%
  group_by(species, island, sex) %>%
  drop_na(sex, body_mass_g, island, species) %>%
  summarise (mean_mass = mean(body_mass_g, na.rm = TRUE),
             var_mass = var(body_mass_g, na.rm = TRUE)
             )
view(mean_and_var)
