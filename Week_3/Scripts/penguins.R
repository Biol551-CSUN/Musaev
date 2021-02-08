
####Libraries
library(palmerpenguins)
library(tidyverse)

####Plot
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm)) +
  geom_point()
