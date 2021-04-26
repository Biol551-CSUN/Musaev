PoolsPath<-here("Week_13", "data", "homework") # set location with files to call on it when loading each file
files <- dir(path = PoolsPath,pattern = ".csv") # list all files in the folder containing .csv

pools_data<-data.frame(matrix(nrow = length(files), ncol = 5)) # pre-allocate space for new data
colnames(pools_data)<-c("orig_file", "mean_temp", "SD_temp", "mean_lux", "SD_lux") # assign column names
#glimpse(pools_raw) # check the new empty data frame

### Method 1: Loop ###

for (i in 1:length(files)){ # for each file ...
  pools_raw<-read_csv(paste0(PoolsPath,"/",files[i])) %>% # read it as csv from the pre-set path
    mutate(Intensity.lux = as.numeric(Intensity.lux)) # convert Intensity values to numeric (originally string)
  pools_data$orig_file[i]<-files[i] # populate column for original file
  pools_data$mean_temp[i]<-mean(pools_raw$Temp.C, na.rm =TRUE)
  pools_data$SD_temp[i]<-sd(pools_raw$Temp.C, na.rm =TRUE)
  pools_data$mean_lux[i]<-mean(pools_raw$Intensity.lux, na.rm =TRUE)
  pools_data$SD_lux[i]<-sd(pools_raw$Intensity.lux, na.rm =TRUE)
} # do the 4 sets of calculation for mean and SD
glimpse(pools_data) # check completion
write_csv(pools_data, here("Week_13","output","W13_Mon_Lab_Loop.csv")) #write stats to file

### Method 2: map() ###

# Clear environment because some function names are reused
rm(list = ls(all.names = TRUE))
# Reload original files and get full paths
PoolsPath<-here("Week_13", "data", "homework") # set location with files to call on it when loading each file
files <- dir(path = PoolsPath,pattern = ".csv", full.names = TRUE) # list all files in the folder containing .csv

data<-files %>% 
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # map everything to a dataframe and put the id in a column called filename
  mutate(Intensity.lux = as.numeric(Intensity.lux)) %>% # convert Intensity values to numeric (originally string)
  group_by(filename) %>%
  summarise(mean_temp = mean(Temp.C, na.rm = TRUE),
            SD_temp = sd(Temp.C,na.rm = TRUE),
            mean_lux = mean(Intensity.lux, na.rm = TRUE),
            SD_lux = sd(Intensity.lux, na.rm = TRUE)
  )
#glimpse(data) # check output
write_csv(data, here("Week_13","output","W13_Mon_Lab_Purrr.csv")) #write stats to file