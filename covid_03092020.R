# load libraries
library(tidyverse) # for wrangling and plotting
library(runner) # to run moving average (and get rolling average values)
library(lubridate) #setting of dates

#read data from github
coronavirus.sept <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')
# notice some warning. But will not use those data

#EDA
coronavirus.sept %>%
  head()

#wrangle data - select confirmed cases from Mal, Ind, Thai, Sg
coronavirus.sept2 <- coronavirus.sept %>% 
  filter(type == 'confirmed', 
         country %in% c('Malaysia', 'Indonesia', 'Thailand', 'Singapore', 'Korea, South'),
         date > '2020-02-15')

coronavirus.sept2 %>% count(type)

## confirmed cases per country
coronavirus.sept2 %>% 
  ggplot(aes(y = cases, x = date)) + 
  #geom_bar(stat = 'identity') + 
  geom_line() +
  ggtitle("Daily Confirmed New COVID19 Cases") +
  xlab("Date") + ylab("Confirmed New Cases") +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  stat_smooth(method = 'loess', span = 0.2) + 
  facet_wrap(~ country, ncol = 1, scales = 'free') +
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 16)) +
  labs(caption = "Epid and Stat Modelling Team, USM")
  
