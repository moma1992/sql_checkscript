# import lib -------------------------------------------------        
library(DBI)
library(RPostgreSQL) 
library(tidyverse)
library(glue)

# function definition ----------------------------------------       
calc_numeric <- function(tbl_name, col_name){
  
  # feach tbl         
  data <- tbl(con, tbl_name )
  
  # min 
  min <- data %>% 
    dplyr::select(sales_number) %>% 
    dplyr::summarise(min = min(sales_number, na.rm = TRUE)) %>% 
    dplyr::collect()
  
  # max 
  max <- data %>% 
    dplyr::select(sales_number) %>% 
    dplyr::summarise(max = max(sales_number, na.rm = TRUE)) %>% 
    dplyr::collect()
  
  # mean 
  mean <- data %>% 
    dplyr::select(sales_number) %>% 
    dplyr::summarise(mean = mean(sales_number, na.rm = TRUE)) %>% 
    dplyr::collect()
  
  # median 
  median_sql <- glue("SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sales_number) FROM {tbl_name}")
  median <- dbGetQuery(con, median_sql)
  
  # mode 
  get_mode <- function(x) {  
    names(which.max(table(x)))
    }
  
  mode <- data %>% 
    dplyr::select(sales_number) %>% 
    collect() %>% 
    get_mode()  
  
  # result 
  return(result_numelic <- data.frame(tbl_name,
                                     col_name,
                                     min,
                                     max,
                                     mean,
                                     median,
                                     mode
                                     )
  )
  }