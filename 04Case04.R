library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi)   # character string/text processing
library(lubridate)
library(tictoc)


covid_data_tbl <- read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")

covid_data_world_tbl  <- covid_data_tbl%>%
  filter(iso_code== 'OWID_WRL')

covid_cases_world_tbl<- covid_data_world_tbl%>%
  select(date,total_cases)

covid_cases_world_tbl %>%
  ggplot(aes(x = date, y = total_cases, color = total_cases))+
  geom_line(size=2)+
  labs(
    title = "Covid Cases Worldwide",
    subtitle = "Confirmed Covid Cases based on the Data found here: https://covid.ourworldindata.org/",
    x = "Date",
    y = "Covid Cases",
    caption = "Cummulative confirmed Covid-Cases since the outbreak in Wuhan in late 2020"
  )


library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi)   # character string/text processing
library(ggplot2)
library(maps)
library(mapdata)

covid_data_tbl <- read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")

#Mortality Rate

covid_data_selection  <- covid_data_tbl%>%
  select(location,total_cases,total_deaths)%>%
  rename(region=location)%>%
  group_by(region)

covid_mort_data  <- covid_data_selection%>%
  
  summarise(mortality=max(total_deaths, na.rm = TRUE) / max(total_cases, na.rm = TRUE))

world_map <- map_data("world")
mutate(region==case_when(
  region == "United Kingdom" ~ "UK",
  region == "United States" ~ "USA",
  region == "Democratic Republic of Congo" ~ "Democratic Republic of the Congo",
  TRUE ~ location  )) 


#Merging Data
covid_mort_map <- merge(covid_mort_data, world_map, by = 'region')

#Map
ggplot(covid_mort_map, aes(x = long, y = lat, 
                           group = group, 
                           fill=mortality)) +
  geom_polygon(color='gray') +
  scale_fill_gradient2(low='white', high='red') +
  theme_void () +
  ggtitle('Covid Mortality Rates')
  +geom_map(aes(map_id =region,group=group),
            map = world_tbl,
            color = "grey80",
            fill = "grey30",
            size = 0.3)


#world_map <- map_data("world")
#sort(unique(ggplot2::map_data("state")$region))
#ggplot(world_map, aes(x = long, y = lat, group = group, fill=mortality)) +
#  geom_polygon(fill="lightgray", colour = "white")

library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi)   # character string/text processing
library(ggplot2)
library(maps)
library(mapdata)

covid_data_tbl <- read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")

#Mortality Rate

covid_data_selection  <- covid_data_tbl%>%
  select(location,total_cases,total_deaths)%>%
  rename(region=location)%>%
  group_by(region)

covid_mort_data  <- covid_data_selection%>%
  
  summarise(mortality=max(total_deaths, na.rm = TRUE) / max(total_cases, na.rm = TRUE))

world_map <- map_data("world")


#Merging Data
covid_mort_map <- merge(covid_mort_data, world_map, by = 'region')

#Map

ggplot(covid_mort_map, aes(map_id = region)) +
  geom_map(aes(fill = mortality), map = world_map) +
  expand_limits(x = world_map$long, y = world_map$lat) +
  scale_fill_gradient2(low='white', high='red')




















#Mortality Rate Asia

covid_data_asia_tbl  <- covid_data_tbl%>%
  filter(continent== 'Asia')
covid_mort_asia_tbl<- covid_data_asia_tbl%>%
  select(date,total_deaths,total_cases,location)%>%
  mutate(mortality=total_deaths/total_cases)%>%
  select(date, mortality, location)

covid_data_SA_tbl <- covid_data_tbl%>%
  filter(continent== 'South America')
covid_mort_SA_tbl<- covid_data_SA_tbl%>%
  select(date,total_deaths,total_cases,location)%>%
  mutate(mortality=total_deaths/total_cases)%>%
  select(date, mortality, location)

covid_data_NA_tbl <- covid_data_tbl%>%
  filter(continent== 'North America')
covid_mort_NA_tbl<- covid_data_NA_tbl%>%
  select(date,total_deaths,total_cases,location)%>%
  mutate(mortality=total_deaths/total_cases)%>%
  select(date, mortality, location)

covid_data_Africa_tbl <- covid_data_tbl%>%
  filter(continent== 'Africa')
covid_mort_Africa_tbl<- covid_data_Africa_tbl%>%
  select(date,total_deaths,total_cases,location)%>%
  mutate(mortality=total_deaths/total_cases)%>%
  select(date, mortality, location)

covid_data_europe_tbl <-covid_data_tbl%>%
  filter(continent== 'Europe')
covid_mort_Europe_tbl <- covid_data_europe_tbl%>%
  select(date,total_deaths,total_cases,location)%>%
  mutate(mortality=total_deaths/total_cases)%>%
  select(date, mortality, location)

world <- map_data("world")%>%
  rename(
    location = region) 

combined_data_asia <- merge(x = covid_mort_asia_tbl, y = world, 
                       by    = "location", 
                       all.x = TRUE, 
                       all.y = FALSE)

combined_data_SA <- merge(x = covid_mort_SA_tbl, y = world, 
                            by    = "location", 
                            all.x = TRUE, 
                            all.y = FALSE)

combined_data_NA <- merge(x = covid_mort_NA_tbl, y = world, 
                            by    = "location", 
                            all.x = TRUE, 
                            all.y = FALSE)

combined_data_Africa <- merge(x = covid_mort_Africa_tbl, y = world, 
                            by    = "location", 
                            all.x = TRUE, 
                            all.y = FALSE)

combined_data_Europe <- merge(x = covid_mort_Europe_tbl, y = world, 
                            by    = "location", 
                            all.x = TRUE, 
                            all.y = FALSE)

plot_data %>% ggplot( ... ) +
  geom_map(aes(map_id = world), map = world, ... ) +
  ...
