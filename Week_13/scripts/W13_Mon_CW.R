library(tidyverse)
library(here)

print(paste("The year is", 2000))

years<-c(2015:2021)

for (i in years){
  print(paste("The year is", i)) #i is the index
}

year_data<-data.frame(matrix(ncol = 2, nrow = length(years))) # pre-allocate space by creating an empty dataframe (matrix with 2 columns and number of rows the same as number of values in "years") 

colnames(year_data)<-c("year", "year_name") # assign column names
year_data

for (i in 1:length(years)){ #
  year_data$year_name[i]<-paste("The year is", years[i])
  year_data$year[i]<-years[i]
}
year_data

testdata<-read_csv(here("Week_13", "data", "cond_data","011521_CT316_1pcal.csv"))
glimpse(testdata)

CondPath<-here("Week_13", "data", "cond_data") # set location with files to call on it later
files <- dir(path = CondPath,pattern = ".csv") # list all files in the folder containing .csv

cond_data<-data.frame(matrix(nrow = length(files), ncol = 3)) # pre-allocate space for new data
colnames(cond_data)<-c("filename","mean_temp", "mean_sal") # assign column names
cond_data

raw_data<-read.csv(paste0(CondPath,"/",files[1])) # test by reading in the first file and see if it works. paste0 = no space between pasted values. last part specifies path to each file
head(raw_data)

mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read.csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  cond_data$filename[i]<-files[i]
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
} 
cond_data

1:10 %>% # a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15) %>% # calculate 15 random numbers based on a normal distribution in a list
  map_dbl(mean) # calculate the mean. It is now a vector which is type "double"

1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

1:10 %>% # formula
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)

# Re-load files
CondPath<-here("Week_13", "data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
files

files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE) # get the entire path
files

data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # map everything to a dataframe and put the id in a column called filename
group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data

