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

### Part 2 ###
penguins %>%
  filter (sex == "female") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_mass)%>%
  ggplot(aes(x = species, 
             y = log_mass)
  ) + 
  geom_violin() +
  geom_jitter(
    aes(x = species,
        y = log_mass,
        color = island),
    position = position_jitterdodge(dodge = 0.1)
  ) +
  labs(title = "Penguin log of Body Mass by Species", #custom labels
       subtitle = "On Biscoe, Dream and Torgersen Islands",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Species",
       y = "log of Body Mass, grams",
       color = "Island"
  )+
  scale_color_manual(labels = c("Biscoe","Dream","Torgersen"), #custom colors
                     values = c("red3","mediumblue","limegreen")
  )+
  theme_bw()
