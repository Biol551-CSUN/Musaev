##### Feb 15, 2021 #####

##### Load Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins)

##### Data Manipulation #####
### Filter practice
filter(.data = penguins, year == 2008|2009 )
filter(.data = penguins, island !="Dream" )
filter(.data = penguins, species == "Adelie"|"Gentoo")

### Mutate Practice
data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000
              ) #mass in g to kg

data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000,
              bill_ratio = bill_length_mm/bill_depth_mm
              ) #calc bill length to depth ratios in new column

View(data2)
