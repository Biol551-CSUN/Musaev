##### Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins)

##### Clean Up Data#####
penguins_clean<-drop_na(penguins)

##### Plotting #####
ggplot(data=penguins_clean,
       mapping = aes(x = island,
                     y = body_mass_g)
                     )+
  #geom_violin()+
  
  geom_boxplot()+
  
  geom_jitter(data=penguins_clean,
              aes(x=island,
                  y=body_mass_g,
                  color=sex),
              position=position_jitterdodge(dodge = 0.5, jitter.width=0.9)
  )+
  
  labs(title = "Penguin Body Mass by Sex",
       subtitle = "For Biscoe, Dream and Torgersen Islands",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Island",
       y = "Body Mass, grams",
       color = "Sex"
  )+
  scale_color_manual(labels = c("Female","Male"),
                     values = c("green","blue")
                     )+
  theme_classic()


  
         