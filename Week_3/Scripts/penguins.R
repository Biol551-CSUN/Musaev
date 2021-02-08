
####Libraries
library(palmerpenguins)
library(tidyverse)

####Plot
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
                     shape = species,
                     size = body_mass_g,
                     alpha = flipper_length_mm
                     )) +
  geom_point()+
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adele, Chinstrap and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+
scale_color_viridis_d()



