# 1.0 Libraries
# Tidyverse
library(tidyverse)
library(vroom)

# Data Table
library(data.table)
library(vroom)

# Counter
library(tictoc)

# 2.0 DATA IMPORT ----

# 2.1 Assignee Data ----

col_types_a <- list(
  assignee_id = col_character(),
  type = col_character(),
  organization = col_character()
)

assignee_data <- vroom(
  file       = "assignee.tsv", 
  delim      = "\t", 
  col_types  = col_types_a,
  col_names  = names(col_types_a),
  na         = c("", "NA", "NULL")
)

# 2.1 Patent Assignee Data ----

col_types_pa <- list(
  patent_id = col_character(),
  assignee_id = col_character()
)

patent_assignee_data <- vroom(
  file       = "patent_assignee.tsv", 
  delim      = "\t", 
  col_types  = col_types_pa,
  col_names  = names(col_types_pa),
  na         = c("", "NA", "NULL")
)

# 2.1 Patent Data ----

col_types_patent <- list(
  patent_id = col_character(),
  date = col_date("%Y-%m-%d"),
  num_claims = col_double()
)

patent_data <- vroom(
  file       = "patent.tsv", 
  delim      = "\t", 
  col_types  = col_types_patent,
  col_names  = names(col_types_patent),
  na         = c("", "NA", "NULL")
)

# 2.1 USPC Data ----

col_types_uspc <- list(
  patent_id = col_character(),
  mainclass_id = col_character(),
  sequence = col_character()
)

uspc_data <- vroom(
  file       = "uspc.tsv", 
  delim      = "\t", 
  col_types  = col_types_uspc,
  col_names  = names(col_types_uspc),
  na         = c("", "NA", "NULL")
)

# Convert to DataTable
# 3.1 Assignee Data ----
setDT(assignee_data)

assignee_data %>% glimpse()

# 3.2 Patent Assignee Data ----

setDT(patent_assignee_data)

patent_assignee_data %>% glimpse()

# 3.3 Patent Data ----

setDT(patent_data)

patent_data %>% glimpse()

# 3.4 USPC Data ----

setDT(uspc_data)

uspc_data %>% glimpse()

# 4.0 DATA WRANGLING ----

# 4.1 Joining / Merging Data Case01 ----

tic()
combined_data_c1 <- merge(x = patent_assignee_data, y = assignee_data, 
                       by    = "assignee_id", 
                       all.x = TRUE, 
                       all.y = FALSE)
toc()

combined_data_c1 %>% glimpse()

# Preparing the Data Table

setkey(combined_data_c1, "assignee_id")
key(combined_data_c1)

?setorder()
setorderv(combined_data_c1, c("assignee_id"))
combined_data_c1 %>% glimpse()

# 4.2 Joining / Merging Data Case02 ----

tic()
combined_data_c2 <- merge(x = combined_data_c1, y = patent_data,
                          by    = "patent_id", 
                          all.x = TRUE, 
                          all.y = FALSE)
toc()

combined_data_c2 %>% glimpse()

# Preparing the Data Table

setkey(combined_data_c2, "patent_id")
key(combined_data_c2)

?setorder()
setorderv(combined_data_c2, c("patent_id", "date"))
combined_data_c2 %>% glimpse()

# 4.3 Joining / Merging Data Case03 ----

tic()
combined_data_c3 <- merge(x = combined_data_c1, y = uspc_data,
                          by    = "patent_id", 
                          all.x = TRUE, 
                          all.y = FALSE)
toc()

combined_data_c3 %>% glimpse()

# Preparing the Data Table

setkey(combined_data_c3, "patent_id")
key(combined_data_c3)

?setorder()
setorderv(combined_data_c3, c("patent_id", "date"))
combined_data_c3 %>% glimpse()

# 5.1 How many Patents per organization----
tic()
combined_data_c1[!is.na(organization), .N, by = organization]
toc()

tic()
combined_data_c1 %>%
  filter(!is.na(organization)) %>%
  count(organization) %>%
  arrange(desc(n)) %>%
  slice_head(n=10)
toc()

# 5.2 How many Patents per organization in August 2014 ----

tic()
combined_data_c2[!is.na(organization), .N, by = organization]
toc()

tic()
combined_data_c2 %>%
  filter(!is.na(date), lubridate::month(date) == 08) %>%
  count(organization) %>%
  arrange(desc(n)) %>%
  slice_head(n=10)
toc()

# 5.3 Innovation in Tech ----

tic()
combined_data_c3 %>%
  filter(!is.na(mainclass_id)) %>%
  count(mainclass_id) %>%
  arrange(desc(n)) %>%
  slice_head(n=5)
toc()

