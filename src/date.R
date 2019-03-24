# import lib -------------------------------------------------        
library(DBI)
library(RPostgreSQL) 
library(tidyverse)
library(glue)


# feach tbl --------------------------------------------------        
tbl_name <- ("trn_sales")
data <- tbl(con, tbl_name )

# min --------------------------------------------------------
min <- data %>% 
  dplyr::select(sales_date) %>% 
  dplyr::summarise(min = min(sales_date, na.rm = TRUE)) %>% 
  dplyr::collect()

# max --------------------------------------------------------
max <- data %>% 
  dplyr::select(sales_date) %>% 
  dplyr::summarise(max = max(sales_date, na.rm = TRUE)) %>% 
  dplyr::collect()

# count ------------------------------------------------------
count_all <- data %>% 
  dplyr::select(sales_date) %>% 
  dplyr::summarise(count_all = n()) %>% 
  dplyr::collect()

# count group ------------------------------------------------
count_group <- data %>% 
  dplyr::select(sales_date) %>%
  dplyr::group_by(sales_date) %>%
  dplyr::summarise(count_group = n()) %>% 
  dplyr::collect() %>% 
  as.data.frame()

# ratio ----- ------------------------------------------------
ratio <- count_group %>% 
  dplyr::mutate(ratio = count_group / as.numeric(count_all)*100)
  