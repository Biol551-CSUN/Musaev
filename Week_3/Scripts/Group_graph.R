##### Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins)

##### Clean Up Data#####
penguins_clean<-drop_na(penguins) #remove NA datapoints, call it "clean"

##### Plotting #####
ggplot(data=penguins_clean, #using the data without NA, "clean"
       mapping = aes(x = island,
                     y = body_mass_g)
                     )+
  #geom_violin()+ #decided to go with boxplot
  
  geom_boxplot(outlier.shape = NA)+ #remove the outlier mark made by the boxplot, as it is already present from the jitter
  
  geom_jitter(data=penguins_clean, #again, "clean" data is used without NA points
              aes(x=island,
                  y=body_mass_g,
                  color=sex),
              position=position_jitterdodge(dodge = 0.0, jitter.width=0.9),
              size = 0.8 #had to play around to make it look good in exported plot
  )+
  
  labs(title = "Penguin Body Mass by Sex", #custom labels
       subtitle = "For Biscoe, Dream and Torgersen Islands",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Island",
       y = "Body Mass, grams",
       color = "Sex"
  )+
  scale_color_manual(labels = c("Female","Male"), #custom colors
                     values = c("red3","mediumblue")
                     )+
  theme_classic()

ggsave(here("Week_3","Output","Group_graph.jpg"), #export image
       width = 7, height = 5 #fixed size
       )
  

  
         