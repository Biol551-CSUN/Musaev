### Week 3 Wednesday ###
### Feb 10, 2020 ###

##### Load Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins)

##### Plotting #####
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ #have to be in specific order
  geom_point()+
  geom_smooth(method = "lm")+ #regression line
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)"
       )+
  #scale_color_viridis_d()+#color blind-friendly palette
  scale_color_manual(values = c("orange", "purple", "green")
                     )+
  #scale_x_continuous(breaks = c(14,17,21),
                    # labels = c("low","medium","high")
                    # )+
  scale_y_continuous(limits = c(0,50))
  


