####---- what we will do this session ----####

# 1. file -> new file -. R script
# 2. install packages 
# 3. load libraries
# 4. run function to download covid-19 data
# 5. save this file

####---- install packages ---- ####
#install.packages('tidyverse', dependencies = TRUE) # need to only run this once
#install.packages('coronavirus', dependencies = TRUE) # need to only run this once

####---- load libraries ----####

library(tidyverse)
library(coronavirus)

####---- get coronavirus data ----####
data(coronavirus)

####---- EDA ----####
glimpse(coronavirus)
summary(coronavirus)

####---- save R file ----####

# ref: https://cran.r-project.org/web/packages/coronavirus/coronavirus.pdf

## TAHNIAH !!!! 

####---- save date ---####

# write to csv and name it coronavirus.csv 
write_csv(coronavirus, 'coronavirus.csv')

# Select Malaysia for country 
MYS_covid <- coronavirus %>% filter(country == "Malaysia")

# Make a simple line plot to look for trend
MYS_covid %>% ggplot(aes(y = cases, x = date)) + geom_line()
# Make a simple column plot to look for trend
MYS_covid %>% ggplot(aes(y = cases, x = date)) + geom_col()

# selected countries
corona_sea <- coronavirus %>% 
  filter(country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia"))

## confirmed cases per country
corona_sea %>% ggplot(aes(y = cases, x = date)) + geom_col() +
  facet_grid(~ country)
 
