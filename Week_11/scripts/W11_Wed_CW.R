##### WHeatmap #####

library(devtools)
install_github('zwdzwd/wheatmap')
library(wheatmap)
library(here)
mtcars_matrix <- as.matrix(mtcars)
head(mtcars_matrix)
mtcars_scale <- scale(mtcars_matrix)
head(mtcars_scale)
heatmap <- both.cluster(mtcars_scale) #cluster data
heatmap$mat[,1:4]

BaseHeatmap <- WHeatmap(heatmap$mat, name='h1',  #create the heatmap and name it h1
                           yticklabels = TRUE, yticklabel.side = 'b', yticklabel.fontsize=11, #add axis labels
                           xticklabels = TRUE, xticklabel.side = 'b', xticklabel.fontsize = 20, #add axis labels
                           cmp = CMPar(brewer.name = 'BuPu')) #change color palette
BaseHeatmap

### Exercise 1 ###
BaseHeatmap1 <- WHeatmap(heatmap$mat, name='Exercise1',  #create the heatmap and name it h1
                        yticklabels = TRUE, yticklabel.side = 'b', yticklabel.fontsize=11, #add axis labels
                        xticklabels = TRUE, xticklabel.side = 'a', xticklabel.fontsize = 20, #add axis labels
                        cmp = CMPar(brewer.name = 'Spectral')) #change color palette
BaseHeatmap1

### Exercise 2 ###
Dendrogram <- BaseHeatmap + #add axis labels
  WDendrogram(heatmap$column.clust, 
              TopOf('h1'), #placement of dendrogram
              facing='bottom') 
Dendrogram

### Exercise 3 ###
Legend <- Dendrogram + 
  WLegendV('h1', BottomLeftOf('h1', h.pad=-0.5), 'l1') #add legend

Legend

### Exercise 4 ###
Highlight <- Legend +
  WRect('h1',c(2,5),c(2,3),col='yellow') #highlight cells

Highlight

### Resources
#[Cran Package](https://cran.r-project.org/web/packages/wheatmap/)  
#[Vignette](https://cran.r-project.org/web/packages/wheatmap/vignettes/wheatmap.html)  
#[Github](https://github.com/zwdzwd/wheatmap)  
#[R Color Brewers](https://www.r-graph-gallery.com/38-rcolorbrewers-palettes.html)
#background-image: url(https://i.kym-cdn.com/photos/images/facebook/001/240/860/528.png)




##### WeNaturalist #####
library(rinat)
#queary=_text here_ to search for any text
get_inat_obs(query = "Parrotfishes", # any entry that mentions Parrotfishes 
             quality = "research") # only research grade observations

get_inat_obs(query = "kelp forest")

#taxon_name=_taxon_ search for taxon

get_inat_obs(taxon_name = "Isocoma menziesii", # search for Coastal Goldenbush using species name
             quality = "research") # only research grade observations

#taxon_id= #search for taxon by id

get_inat_obs(taxon_id = 53353, # id number from iNaturalist
             quality = "research") # only research grade observations

Mule_deer<- get_inat_obs(query = "Mule Deer", # Search for Mule deer 
                         bounds = c(38.44047, -125, 40.86652, -121.837)) # Creating a bounding box of Northern California

library(tidyverse)
Mule_deer <- get_inat_obs(query = "Mule Deer", # Search for Mule deer 
                          bounds = c(38.44047, -125, 40.86652, -121.837), # In Northern California
                          quality = "research", # research grade observations
                          year = 2019) 

plot(Mule_deer$longitude, Mule_deer$latitude)

#get_inat_obs_project() #gets all data from a project

#get_inat_obs_user() #gets all data from a user

data <- get_inat_obs_project("los-angeles-city-biodiversity-initiative", # project name
                             type="observations") # gets the project observations

info <- get_inat_obs_project("los-angeles-city-biodiversity-initiative", 
                             type="info", # gets the project information
                             raw = FALSE) 

get_inat_obs_user(username = "a_wandering_ecologist")

#get stats:
#Of a taxa get_inat_taxon_stats()

#Of a user get_inat_user_stats()

#Taxon stats of a location

# get the total number of species logged
place_stats[["total"]]

# get the top 5 species and their stats and info
place_stats[["species_counts"]][["taxon"]] # gives by the species name

place_stats[["species_counts"]][["taxon"]][["default_name"]] # gives by the common name

place_stats[["species_counts"]][["taxon"]][["name"]] # get the species names

place_stats[["species_counts"]][["taxon"]][["iconic_taxon_name"]] # get their higher taxa

place_stats[["species_counts"]][["taxon"]][["conservation_status_name"]] # get their conservation status

place_stats[["rank_counts"]]

#User stats
project_user_stats <- get_inat_user_stats(project="los-angeles-city-biodiversity-initiative")

project_user_stats[["total"]] # total number of users
#place_stats <- get_inat_taxon_stats(place = 123751)


### Mapping
library(here) 
library(maps)
library(ggplot2)

inat_map(data, 
         map = NULL, 
         subregion = NULL,
         plot = FALSE)

lizard <- get_inat_obs(taxon_name = "Sceloporus occidentalis", 
                       maxresults = 300) # Selecting only 300 results for the Sceloporus species

lizard_map <- inat_map(lizard) # Mapping the previous data

sceloporus <- get_inat_obs(taxon_name = "Sceloporus occidentalis", # Choosing species of interest
                           quality = "research", # Limiting to research grade quality 
                           place_id = 962, # Limiting to the Los Angeles area
                           maxresults = 500) # Limiting to most recent 500 results only

glimpse(sceloporus)

squirrel <- get_inat_obs(taxon_name = "Sciurus niger", # Selecting our species of interest
                         quality = "research", # Limiting to research grade quality
                         place_id = 962, # Limiting to the Los Angeles area
                         maxresults = 500) # Limiting to the 500 most recent observations

glimpse(squirrel)

bee <- get_inat_obs(taxon_name = "Apis mellifera", # Selecting our species of interest
                    quality = "research", # Limiting to only research grade quality
                    place_id = 962, # Limiting to observations in the Los Angeles area only
                    maxresults = 500) # Limiting to only the 500 most recent observations

glimpse(bee)

animals <- rbind(bee, squirrel, sceloporus) # Using the row bind function to combine all three data sets
animals

ggplot(data = animals, aes(x = longitude,
                           y = latitude,
                           colour = scientific_name)) + # Setting up the basis of the plot with appropriate data
  geom_polygon(data = map_data("usa"), # Making a map using the USA map
               aes(x = long, y = lat, group = group), # Setting up appropriate parameters
               fill = "grey95",
               color = "gray40",
               size = 0.1) + # Editing the map to be an appropriate color and fill
  geom_point(size = 1, alpha = 0.5)+ # Adding points to indicate individual species
  theme_bw() # Selecting basic black/white theme


ggplot(data = animals, aes(x = longitude,
                           y = latitude,
                           colour = scientific_name)) + # Setting up the basis of the plot with appropriate data
  geom_polygon(data = map_data("usa"), # Making a map using the USA map
               aes(x = long, y = lat, group = group),
               fill = "grey95",
               color = "gray40",
               size = 0.1) + # Editing the map to be an appropriate color and fill
  geom_point(size = 1, alpha = 0.5)+ # Adding points to indicate individual species
  coord_fixed(xlim = range(animals$longitude, na.rm = TRUE),
              ylim = range(animals$latitude, na.rm = TRUE))+ # Limiting the map space based on latitude and longitude from the data set
  theme_bw() # Selecting basic black/white theme


##### Janitor #####
install.packages("janitor")
library(janitor)
library(tidyverse)
library(here)
library(readxl)
library(kableExtra)

coralgrowth<-read_csv(here("project", "Data", "CoralGrowth.csv"))
corals_messy <- read_csv(here("project", "Data", "coraldata.csv"))

clean_names()
tabyl()
remove_empty()
get_dupes()
excel_numeric_to_date()

corals_messy%>%
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>% #  Theme of the table
  kable_styling() %>% 
  scroll_box(width = "700px", height = "300px")# Table dimensions

corals<-clean_names(corals_messy)%>% ## function we are looking at ##
  write_csv(here("project", "output", "clean_names_corals.csv"))

corals %>%
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>% # the theme of the table
  kable_styling() %>%
  scroll_box(width = "700px", height = "300px") # table dimensions 

tabyl(corals, change_mg_cm2)%>% #we can put the object into a frequency table
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>% # theme of the table
  kable_styling() %>% 
  scroll_box(width = "300px", height = "300px")# table dimensions

corals %>%
  tabyl(change_mg_cm2)%>%  ### The pipe version ###
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>% # theme of table
  kable_styling() %>%
  scroll_box(width = "300px", height = "300px")# table dimensions

#first make a simple data frame 
a <- data.frame(v1 = c(7, 6, 4, 5),
                v2 = c(NA, NA, NA, NA),
                v3 = c("a", "b", "c", "d"), 
                v4 = c(6, 5, 8, 10))
a %>% #data frame name
  kbl()%>% #make a table in RMarkdown
  kable_classic()%>% #classic theme
  kable_styling(full_width = FALSE, position = "left")

a_clean<-a %>% #rename data frame
  remove_empty(c("rows", "cols")) #checks for empty columns and rows, removes them!
a_clean%>%  #data frame name 
  kbl()%>% #make a table in RMarkdown
  kable_classic()%>% #classic theme
  kable_styling(full_width = FALSE, position = "left")

coralgrowth %>% # data frame name
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>%
  kable_styling() %>%
  scroll_box(width = "700px", height = "300px")# classic theme

coralgrowth_clean<-coralgrowth %>%  #rename data set
  remove_empty(c("rows", "cols")) #remove any rows or columns with all NAs

coralgrowth_clean %>% # data frame name
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>%
  kable_styling() %>%
  scroll_box(width = "700px", height = "300px")# classic theme

corals %>%
  get_dupes("change_mg_cm2")%>%  ## the function we are using ##
  arrange(dupe_count)%>%  # arranged it by dupe count to make it organized 
  kbl() %>% # make a table in RMarkdown
  kable_classic()%>% # table theme
  kable_styling() %>%
  scroll_box(width = "700px", height = "300px")# table dimensions 

#convert dates from excel to R
excel_numeric_to_date(41104)
## [1] "2012-07-14"
excel_numeric_to_date(41105)
## [1] "2012-07-15"
excel_numeric_to_date(41106)
## [1] "2012-07-16"
excel_numeric_to_date(41107)
## [1] "2012-07-17"


##### Plotly #####
library(tidytuesdayR)
library(tidyverse)
library(here)

# clear environment
rm(list = ls())
# load Tidy Tuesday data
tuesdata <- tidytuesdayR::tt_load('2020-02-18')

# assign data to dataframe
food.data<-tuesdata$food_consumption
fig <- plot_ly(data = food.data, 
               x = ~co2_emmission, 
               y = ~consumption,
               color = ~food_category)
figglimpse(food.data)

# save csv file in local Data folder
write_csv(food.data,here("Data","food_consumption.csv"))

install.packages('plotly')
library(plotly)

fig <- plot_ly(data = food.data, 
               x = ~co2_emmission, 
               y = ~consumption)
fig

fig <- plot_ly(data = food.data, 
               x = ~co2_emmission, 
               y = ~consumption,
               color = ~food_category)
fig

fig <- plot_ly(data = food.data, 
               x = ~co2_emmission, 
               y = ~consumption,
               color = ~co2_emmission,
               colors = "viridis")
fig

fig <- plot_ly(data = food.data, 
               x = ~co2_emmission, 
               y = ~consumption,
               color = ~food_category,
               colors = "viridis",
               marker = list(size = 10), #change the marker size
               text = ~paste("CO2 emission:", co2_emmission, #change the hover data labels
                             "<br>Consumption:", consumption, #<br> moves the label to a new line
                             "<br>Food category:", food_category)) %>% #must PIPE to the layout 
  layout(title = 'CO2 Emissions and Food Consumption by Food Type', #add a title
         xaxis = list(title = "CO2 Emission"), #change the axes titles
         yaxis = list(title = "Consumption"),
         legend = list(title = list(text = 'Food Category'))) #add a legend title
fig

fig <- plot_ly(data = food.data, 
               x = ~co2_emmission, 
               y = ~consumption,
               color = ~food_category,
               colors = "viridis",
               mode = 'lines', #change to lines
               text = ~paste("CO2 emission:", co2_emmission, 
                             "<br>Consumption:", consumption, 
                             "<br>Food category:", food_category)) %>% 
  layout(title = 'CO2 Emissions and Food Consumption by Food Type', 
         xaxis = list(title = "CO2 Emission"), 
         yaxis = list(title = "Consumption"),
         legend = list(title = list(text = 'Food Category'))) 

fig

### Bar chart ###
bar <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China", #select countries
         food_category == "Beef") #select 1 food category

bar <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China",
         food_category == "Beef") %>%
  plot_ly(x = ~country, #create bar chart showing beef consumption by country
          y = ~consumption,
          type = "bar")

bar

#stacked bar chart
bar_stacked <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China") #filter out 3 countries of interest

bar_stacked <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China") %>% 
  group_by(country) %>% 
  mutate(total_consumption = (sum(consumption)),
         percent_consumption = ((consumption/total_consumption)*100)) #calculate amount of each food consumed as percent of total consumption

bar_stacked <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China") %>% 
  group_by(country) %>% 
  mutate(total_consumption = (sum(consumption)),
         percent_consumption = ((consumption/total_consumption)*100)) %>%
  plot_ly(x = ~country, #countries on x-axis
          y = ~percent_consumption, #percent consumption on y-axis
          color = ~food_category, #color by type of food
          type = "bar") #make it a bar chart

bar_stacked

bar_stacked <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China") %>% 
  group_by(country) %>% 
  mutate(total_consumption = (sum(consumption)),
         percent_consumption = ((consumption/total_consumption)*100)) %>%
  plot_ly(x = ~country,
          y = ~percent_consumption,
          color = ~food_category,
          text = ~paste("Total consumption:", total_consumption, "kg/person/year"), #customize hover label text
          type = "bar")

bar_stacked

bar_stacked <- food.data %>%
  filter(country == "USA" | country == "United Kingdom" | country == "China") %>% 
  group_by(country) %>% 
  mutate(total_consumption = (sum(consumption)),
         percent_consumption = ((consumption/total_consumption)*100)) %>%
  plot_ly(x = ~country,
          y = ~percent_consumption,
          color = ~food_category,
          text = ~paste("Total consumption:", total_consumption, "kg/person/year"),
          type = "bar") %>% 
  layout(barmode = "stack", #stack bars
         title = "Percent of food comsumed by country", #change plot title
         xaxis = list(title = "Country"), #change x-axis title
         yaxis = list(title = "Percent of total consumption")) #change y-axis title

bar_stacked


#Drop-down menu
dropdown <- food.data %>%
  filter(country == "USA") %>% #filter out USA
  plot_ly(x = ~food_category) #plot with food category on x-axis

dropdown

dropdown <- food.data %>%
  filter(country == "USA") %>%
  plot_ly(x = ~food_category) %>%
  add_bars(y = ~consumption, name = "Food Consumption") #create bar graph

dropdown

dropdown <- food.data %>%
  filter(country == "USA") %>%
  plot_ly(x = ~food_category) %>%
  add_bars(y = ~consumption, name = "Food Consumption") %>%
  add_bars(y = ~co2_emmission, name = "CO2 Emissions", visible = FALSE) #create second bar graph, make invisible

dropdown

dropdown <- food.data %>%
  filter(country == "USA") %>%
  plot_ly(x = ~food_category) %>%
  add_bars(y = ~consumption, name = "Food Consumption") %>%
  add_bars(y = ~co2_emmission, name = "CO2 Emissions", visible = FALSE) %>%
  layout(updatemenus = list(list(y = 0.6, #set vertical position of menu
                                 x = -0.2, #set horizontal position of menu
                                 buttons = list(list(method = "restyle", #use "buttons" to add the 2 different menu options
                                                     args = list("visible", list(TRUE, FALSE)), #show first plot, hide second plot
                                                     label = "Consumption"),
                                                list(method = "restyle",
                                                     args = list("visible", list(FALSE, TRUE)), #hide first plot, show second plot
                                                     label = "CO2 Emissions")))))

dropdown

#Chloropleth Map
# Load food data
tuesdata <- tidytuesdayR::tt_load('2020-02-18')

food.data<-tuesdata$food_consumption

# Load plotly map code dataframe
map.codes <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
glimpse(map.codes)

food.data <- map.codes %>% 
  rename(country = COUNTRY) %>% # rename column heading for easier join
  right_join(food.data) %>%  # join to food.data dataframe by 'country'
  select(-GDP..BILLIONS.)

# check if any countries were unsuccessfully joined
food.data %>% 
  mutate(na_col = is.na(food.data$CODE)) %>% 
  filter(na_col == TRUE) %>% 
  distinct(country)

US <- food.data %>% 
  filter(country == "USA") %>% 
  mutate(CODE = 'USA',
         country = 'United States')

# Add recoded USA to dataframe and summarize mean CO2 emmissions
food.data <- food.data %>% 
  full_join(US) %>% 
  drop_na()

# Get mean CO2 Emission values for each country
co2.data <- food.data %>% 
  group_by(country, CODE) %>% 
  summarise(mean_co2 = mean(co2_emmission)) %>% 
  ungroup()

full.data <- food.data %>% 
  select(-consumption) %>% 
  left_join(co2.data)

wide.data <- full.data %>%
  pivot_wider(names_from = food_category, values_from = co2_emmission) %>%
  drop_na()

plot_geo(wide.data) # create the world map using our dataframe

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2) # Colors data points by the values given

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2) # Distributes color within each location boundary

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~country) # Display country names with data value

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans)) # Display CO2 emission values for specific categories

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}')) # remove the top line showing value from z

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("grey63"), width = 0.5))) # Sets location boundary color and thickness

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) # Sets location boundary color and thickness

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions') # add title

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions', # add title
         geo = list(showframe = F)) # remove box border around map

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions', # add title
         geo = list(showframe = F, # remove box border around map
                    showcoastlines = F)) # If F, removes all other outlines not included in our location list

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions', # add title
         geo = list(showframe = F, # remove box border around map
                    showcoastlines = T, # If F, removes all other outlines not included in our location list
                    showocean = T, oceancolor="LightBlue")) # Includes ocean boundaries in map and fills in color

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions', # add title
         geo = list(showframe = F, # remove box border around map
                    showcoastlines = T, # If F, removes all other outlines not included in our location list
                    showocean = T, oceancolor="LightBlue", # Includes ocean boundaries in map and fills in color
                    showlakes=T, lakecolor="Blue",
                    showrivers=T, rivercolor="Blue"))  # set map projection

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions', # add title
         geo = list(showframe = F, # remove box border around map
                    showcoastlines = T, # If F, removes all other outlines not included in our location list
                    showocean = T, oceancolor="LightBlue", # Includes ocean boundaries in map and fills in color
                    projection = list(type = 'mercator')))  # set map projection

plot_geo(wide.data) %>% # create the world map using our dataframe
  add_trace(locations = ~CODE, # Spatial coordinates; distributes data points by location
            color = ~mean_co2, # Colors data points by the values given
            z = ~mean_co2, # Distributes color within each location boundary
            text = ~paste(country,
                          "<br>Mean CO2 emission:", mean_co2, #change the hover data labels
                          "<br>Pork:", Pork, #<br> moves the label to a new line
                          "<br>Poultry:", Poultry,
                          "<br>Beef:", Beef,
                          "<br>Fish:", Fish,
                          "<br>Eggs:", Eggs,
                          "<br>Soybeans:", Soybeans), 
            hovertemplate = paste('%{text}'),
            marker = list(line = list(color = toRGB("black"), width = 1))) %>% # Sets location boundary color and thickness
  layout(title = 'Global Annual Carbon Emmissions', # add title
         geo = list(showframe = F, # remove box border around map
                    showcoastlines = T, # If F, removes all other outlines not included in our location list
                    showocean = T, oceancolor="LightBlue", # Includes ocean boundaries in map and fills in color
                    projection = list(type = 'robinson'))) %>% # set map projection
  colorbar(title = 'CO2 Emmissions<br />(kg CO2/person/year)') # legend title (added break line)