# WEBSCRAPING ----

# 1.0 LIBRARIES ----

library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi)   # character string/text processing

url_home          <- "https://www.rosebikes.de/fahrr%C3%A4der/e-bike"
html_home         <- read_html(url_home)

bike_names_tbl <- html_home %>%
  html_elements(css = ".catalog-category-bikes__price-title , .catalog-category-bikes__title-text") %>%
  html_text(trim=TRUE) %>%
  discard(.p = ~stringr::str_detect(.x,"ab|\200")) %>%
  enframe(name = "Position", value = "Name") %>%
  #matrix(ncol = 2)%>%
  as.data.frame(stringsAsFactors=FALSE) 

bike_prizes_tbl <- html_home %>%
  html_elements(css = ".catalog-category-bikes__price-title , .catalog-category-bikes__title-text") %>%
  html_text(trim=TRUE) %>%
  discard(.p = ~stringr::str_detect(.x,"ab|\200", negate=TRUE)) %>%
  str_replace("ab","") %>%
  str_replace("\200","") %>%
  #str_extract("[0-9]+")%>%
  enframe(name="Position", value="Price") %>%
  mutate(price_num = Price %>% readr::parse_number()) %>%
  as.data.frame() 

  
bike_ebike_prizes_tbl <- left_join(bike_names_tbl, bike_prizes_tbl, by = "Position")

bike_ebike_prizes_tbl
  