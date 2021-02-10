### Week 3 Wednesday ###
### Feb 10, 2020 ###

##### Load Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)

##### Load Data #####
glimpse(penguins)

##### Plotting #####
plot1<-ggplot(data=penguins, #assign the current plot to a name, "plot1"
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ #have to be in specific order
  geom_point()+
  geom_smooth(method = "lm")+ #regression line
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)"
       )+
  scale_color_viridis_d()+#color blind-friendly palette
  scale_color_manual(values = c("orange", "purple", "green") #c=concactenate, indicates vector
                     )+
  scale_x_continuous(breaks = c(14,17,21),
                     labels = c("low","medium","high") #assign low, med, high to respective values above
                     )+
  scale_y_continuous(limits = c(0,50))+
  #scale_color_manual(values = beyonce_palette(10))+ #failed to install, need to troubleshoot
  theme_bw()+
  theme(axis.title = element_text(size = 20,#changing theme elements
                                  color = "red"),
        panel.background = element_rect(fill = "linen")
        )+ 
ggsave(here("Week_3","Output","Penguin.png"),#save to path
       width = 7, height = 5) #dimensions in inches by default


  


