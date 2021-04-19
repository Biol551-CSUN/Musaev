
#Install today's packages
install.packages('tidytext')
install.packages('wordcloud2')
install.packages('janeaustenr')
install.packages("stopwords")

#Load libraries
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

#Demonstrations
words<-"This is a string"
words

words_vector<-c("Apples", "Bananas","Oranges")
words_vector

paste("High temp", "Low pH")

paste("High temp", "Low pH", sep = "-")

paste0("High temp", "Low pH")

shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

str_length(shapes)

seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA

str_sub(seq_data, start = 3, end = 3) <- "A" # add an A in the 3rd position
seq_data

str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string

badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments

str_trim(badtreatments) # this removes both

str_trim(badtreatments, side = "left") # this removes left

str_pad(badtreatments, 5, side = "right") # add a white space to the right side after the 5th character

str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side after the 5th character

x<-"I love R!"
str_to_upper(x)

str_to_lower(x)

str_to_title(x)

data<-c("AAA", "TATA", "CTAG", "GCTT")
# find all the strings with an A
str_view(data, pattern = "A")

str_detect(data, pattern = "A")

str_detect(data, pattern = "AT")

vals<-c("a.b", "b.c","c.d")

#string, pattern, replace
str_replace(vals, "\\.", " ")

vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")

#string, pattern, replace
str_replace_all(vals, "\\.", " ")

val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")

str_count(val2, "[aeiou]")

# count any digit
str_count(val2, "[0-9]")

strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")

phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
# Which strings contain phone numbers?
str_detect(strings, phone)

# subset only the strings with phone numbers
test<-str_subset(strings, phone)
test

#Challenge!
clean_strings <- strings
  gsub("." , "-", clean_strings)

view(clean_strings)
#Did not work :(

#Answer:
test %>%
  str_replace_all(pattern = "\\.", replacement = "-") %>% # replace periods with -
  str_replace_all(pattern = "[a-zA-Z]|\\:", replacement = "") %>% # remove all the things we don't want
  str_trim() # trim the white space

