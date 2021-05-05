# Data Science at TUHH ------------------------------------------------------
# SALES ANALYSIS ----

# 1.0 Load libraries ----

library(tidyverse)
#  library(tibble)    --> is a modern re-imagining of the data frame
#  library(readr)     --> provides a fast and friendly way to read rectangular data like csv
#  library(dplyr)     --> provides a grammar of data manipulation
#  library(magrittr)  --> offers a set of operators which make your code more readable (pipe operator)
#  library(tidyr)     --> provides a set of functions that help you get to tidy data
#  library(stringr)   --> provides a cohesive set of functions designed to make working with strings as easy as possible
#  library(ggplot2)   --> graphics

## ── Attaching packages ──────────────────────────────── tidyverse 1.3.0 ──
## ✓ ggplot2 3.3.0     ✓ purrr   0.3.4
## ✓ tibble  3.0.1     ✓ dplyr   0.8.5
## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
## ── Conflicts ───────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()

# Excel Files
library(readxl)

# 2.0 Importing Files ----

# 2.0 Importing Files ----
# A good convention is to use the file name and suffix it with tbl for the data structure tibble
bikes_tbl      <- read_excel(path = "00_data/01_raw_data/bikes.xlsx")
orderlines_tbl <- read_excel("00_data/01_raw_data/orderlines.xlsx")

# Not necessary for this analysis, but for the sake of completeness
bikeshops_tbl  <- read_excel("00_data/01_raw_data/bikeshops.xlsx")


# 3.0 Examining Data ----
# Method 1: Print it to the console
orderlines_tbl
# Method 2: glimpse
glimpse(orderlines_tbl)

# 4.0 Joining Data ----
left_join(orderlines_tbl, bikes_tbl, by = c("product.id" = "bike.id"))


# Chaining commands with the pipe and assigning it to order_items_joined_tbl

bike_orderlines_joined_tbl <- orderlines_tbl %>%
  left_join(bikes_tbl, by = c("product.id" = "bike.id")) %>%
  left_join(bikeshops_tbl, by = c("customer.id" = "bikeshop.id"))

# Examine the results with glimpse()
bike_orderlines_joined_tbl %>% glimpse()


# 5.0 Wrangling Data ----


# 6.0 Business Insights ----
# 6.1 Sales by Year ----

# Step 1 - Manipulate

# Step 2 - Visualize


# 6.2 Sales by Year and Category 2 ----

# Step 1 - Manipulate

# Step 2 - Visualize



# 7.0 Writing Files ----

# 7.1 Excel ----

# 7.2 CSV ----

# 7.3 RDS ----
