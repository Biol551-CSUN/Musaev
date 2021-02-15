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

### Dataframe practice
penguins %>% #pipe
  filter (sex == "female") %>%
  mutate (log_mass = log (body_mass_g)) %>% #adds a column with a calculated value
  select (Species = species, island, sex, log_mass)#select function allows to rename columns

penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE)#calcs mean, removes NA values
            )
penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE)
            )  #calcs mean and minimum in separate columns

penguins %>%
  group_by(island) %>% #cannot be used alone,only "prepares" for the next line
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE)
            ) #like pivot table in excel

penguins %>%
  group_by(island, sex) %>% #can group by two parameters at once
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE)
            )

penguins %>%
  drop_na(sex) #simply removes rows with NA for sex
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)
            )
  
penguins %>%
  drop_na(sex) %>% 
  ggplot(aes(x = sex, y = flipper_length_mm)
         ) +
  geom_boxplot() #piping into ggplot