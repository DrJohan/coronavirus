## loading necessary packages for this exercise

library(tidyverse)
library(runner)
library(coronavirus)

## import latest dataset from github

covid_latest <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv")

## as alternatives we can use dataset from coronavirus packages. 
## But always update the dataset using update_dataset() function

## using built in dataset from coronavirus package 
## glimpse(coronavirus)
##view(covid_latest)

covid19 <- as_tibble(covid_latest) # converting to tibble


covid_sea <- covid19 %>% 
  filter(type== "confirmed", country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia", "Philippines", "Vietnam"))

