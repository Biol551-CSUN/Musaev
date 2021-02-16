##### Feb 15, 2021 #####
##### Group work #####

##### Load Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins) #check that data is loaded

##### Analysis #####
### Part 1 ###

mean_and_var <- penguins %>% #create pipeline for calculating mean and variance
  group_by(species, island, sex) %>% #assign groups to work with
  drop_na(sex, body_mass_g, island, species) %>% #exclude NA variables
  summarise (mean_mass = mean(body_mass_g, na.rm = TRUE),
             var_mass = var(body_mass_g, na.rm = TRUE)#create and populate columns for mean and variance
  )
view(mean_and_var)#check mean and variance calculations

### Part 2 ###
penguins %>% #create pipeline for next set of calculations and plotting
  filter (sex == "female") %>% #select females only
  mutate(log_mass = log(body_mass_g)) %>% #calculate log of mass for each penguin
  select(species, island, sex, log_mass)%>% #assign variables to plot
  ggplot(aes(x = species, 
             y = log_mass)#create plot background and assign axes
  ) + 
  geom_violin() + #add simple violin plot
  geom_jitter( #add individual datapoints...
    aes(x = species,
        y = log_mass, #... on the same axes as the background...
        color = island), #...using different colors for different islands
    position = position_jitterdodge(dodge = 0.1)#optimize datapoints' x shift
  ) +
  labs(title = "Penguin log of Body Mass by Species", #main figure lable
       subtitle = "On Biscoe, Dream and Torgersen Islands", #secondary lable
       caption = "Source: Palmer Station LTER / palmerpenguins package", #bottom lable
       x = "Species", 
       y = "log of Body Mass, grams",#axes lables
       color = "Island" #legend lable
  )+
  scale_color_manual(labels = c("Biscoe","Dream","Torgersen"), #legend text for each island and color
                     values = c("red3","mediumblue","limegreen")#select colors for each island
  )+
  theme_bw() #change plot background for better visuals
