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
View(data2)

data3<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000,
              bill_ratio = bill_length_mm/bill_depth_mm
              ) #calc bill length to depth ratios in new column
View(data3)

data4<- mutate(.data = penguins,
               after_2008 = ifelse( year>2008, "After 2008", "Before 2008")
               ) #assign After 2008 or Before 2008 in new column
View(data4)

data5<- mutate(.data = penguins,
               fl_lgth_and_mass = flipper_length_mm+body_mass_g
               )
View(data5)

data6<- mutate(.data = penguins,
               sex_to_caps = ifelse(sex == "male", "Male","Female")
               )
View(data6)

