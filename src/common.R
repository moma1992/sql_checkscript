# import lib -------------------------------------------------        
library(DBI)
library(RPostgreSQL) 
library(tidyverse)

# function definition ----------------------------------------       
calc_common <- function(tbl_name, col_name){
  
  # feach tbl 
  data <- tbl(con, tbl_name )
  
  # count 
  count_all <- data %>% 
    dplyr::select(!!sym(col_name)) %>% 
    dplyr::summarise(count_all = n()) %>% 
    dplyr::collect() %>% 
    as.numeric()
  
  # count distinct 
  count_distinct <- data %>% 
    dplyr::select(!!sym(col_name)) %>%
    dplyr::filter(!is.na(!!sym(col_name))) %>% 
    dplyr::distinct(!!sym(col_name)) %>%
    dplyr::summarise(count_distinct = n()) %>% 
    dplyr::collect() %>% 
    as.numeric()
  
  # null 
  count_null <- data %>% 
    dplyr::select(!!sym(col_name)) %>%
    dplyr::filter(is.na(!!sym(col_name))) %>% 
    dplyr::summarise(count_null = n()) %>% 
    dplyr::collect() %>% 
    as.numeric()
  
  # ratio null 
  ratio_null <- (count_null / count_all)*100
  
  # result 
  return(result_common <- data.frame(tbl_name,
                              col_name,
                              count_all,
                              count_distinct,
                              count_null,
                              ratio_null)
  )
}