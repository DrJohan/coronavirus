## loading necessary packages for this exercise

library(tidyverse)
library(runner)
library(coronavirus)
library(formattable)
library(plotly)

## import latest dataset from github

covid_latest <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv")

## as alternatives we can use dataset from coronavirus packages. 
## But always update the dataset using update_dataset() function

## using built in dataset from coronavirus package 
## glimpse(coronavirus)
##view(covid_latest)
glimpse(covid_latest)
covid19 <- as_tibble(covid_latest) # converting to tibble


covid_sea <- covid19 %>% 
  filter(type== "confirmed", country %in% c("Malaysia", "Thailand", "Singapore", "Indonesia", "Philippines", "Vietnam"))

covid_mal <- covid_sea %>% 
  filter(country == "Malaysia") %>% 
  mutate(one_week = runner(
    x = cases,
    k = "1 week",
    idx = date, 
    f = mean
    
  ))

covid19_weekly <- covid_sea %>% group_by(country) %>%
  group_modify(~ data.frame(weekly = runner(
    x = .x$cases, 
    k = "1 week",
    idx = .x$date, 
    f = mean
  )))

covid_sea2 <- bind_cols(covid_sea, covid19_weekly)

covid_sea2 <- covid_sea2 %>% select(-country...8) %>% 
  rename(country = country...3)
formattable(covid_sea2)

# plot daily cases
ggplot(covid_sea2, aes(x = date, y = cases, colour = country)) +
  geom_line()

#plot daily case + rolling weekly average
ggplot(covid_sea2, aes(x = date, y = cases, colour = country)) +
  geom_line() +
  geom_line(aes(x = date, y = weekly, group = country), colour = "red")


# plot daily case + rolling weekly by country
covid_plot <- ggplot(covid_sea2) + 
  geom_line(aes(x = date, y = cases), colour = "green") +
  geom_line(aes(x = date, y = weekly), colour = "orange") + facet_grid(~ country)

#adding labels and graph title
covid_plot + xlab("Date") + ylab("Cases") +
  ggtitle("Number of Covid19 confirmed cases by country \n : Daily(green) and 7-day rolling average (orange)") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5))

covid_interactive <- ggplotly(covid_plot)
covid_interactive
