library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi)   # character string/text processing

covid_data_tbl <- read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")

covid_data_world_tbl  <- covid_data_tbl%>%
  filter(iso_code== 'OWID_WRL')

covid_cases_world_tbl<- covid_data_world_tbl%>%
  select(date,total_cases)

plot(covid_cases_world_tbl)

'

world_mortality <- covid_data_world_tbl%>%
  select()

world_tbl <- map_data("world")

world_mortality %>% ggplot(aes(x = long, y = lat))+
  geom_map(aes(map_id = region,group = group),
           map = world_tbl,
           color = "grey80", 
           fill = "grey30",
           size = 0.3
  )+ 
  geom_polygon(aes(group= group, fill = group), color = "#2C3E50")
'