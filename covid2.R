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
library(formattable)
coronavirus::update_dataset()
####---- get coronavirus data ----####
data(coronavirus)

####---- EDA ----####
glimpse(coronavirus)
summary(coronavirus)
covid19 <- as_tibble(coronavirus)
covid19

####---- save R file ----####

# ref: https://cran.r-project.org/web/packages/coronavirus/coronavirus.pdf

## TAHNIAH !!!! 

####---- save date ---####

# write to csv and name it coronavirus.csv 
write_csv(coronavirus, 'coronavirus.csv')

# Select Malaysia for country 
MYS_covid <- coronavirus %>% filter(country == "Malaysia")
MYS_covid19 <- covid19 %>% filter(country == "Malaysia")


# Make a simple line plot to look for trend
MYS_covid %>% ggplot(aes(y = cases, x = date, color = country)) + geom_line()
# Make a simple column plot to look for trend
MYS_covid19 %>% ggplot(aes(y = cases, x = date)) + geom_col()
formattable(MYS_covid19)
# selected countries
corona_sea <- coronavirus %>% 
  filter(country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia"))

corona_sea2 <- coronavirus %>% 
  filter(country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia")) %>% 
  filter(type == "confirmed")
  
corona_sea3 <- coronavirus %>% 
  filter(country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia")) %>% 
  filter(type == "recovered")

corona_sea4 <- coronavirus %>% 
  filter(country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia")) %>% 
  filter(type == "death")



## confirmed cases per country
corona_sea %>% ggplot(aes(y = cases, x = date, color = country)) + geom_col() +
  facet_grid(~ country)

corona_sea2 %>% ggplot(aes(y = cases, x = date, fill = country)) + geom_col() +
  facet_grid(~ country)

corona_sea %>% ggplot(aes(y = cases, x = date, fill = type)) + geom_bar(stat = "identity") +
  labs(title= "Cumulative Number of COVID-19 Cases in Selected South East Asia Country",
       y="Number of Cases", x = "Date") + facet_grid(~ country)


