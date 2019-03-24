# import lib -------------------------------------------------        
library(DBI)
library(RPostgreSQL) 
library(tidyverse)
library(glue)

# function definition ----------------------------------------       
calc_char <- function(tbl_name, col_name){
  
  # feach tbl
  tbl_name <- ("trn_sales")
  data <- tbl(con, tbl_name )
  
  # count
  count_all <- data %>% 
    dplyr::select(item_name) %>% 
    dplyr::summarise(count_all = n()) %>% 
    dplyr::collect()
  
  # count group
  count_group <- data %>% 
    dplyr::select(item_name) %>%
    dplyr::group_by(item_name) %>%
    dplyr::summarise(count_group = n()) %>% 
    dplyr::collect() %>% 
    as.data.frame()
  
  # ratio
  ratio <- count_group %>% 
    dplyr::mutate(ratio = count_group / as.numeric(count_all)*100)

  #ToDo returnの処理結果の形式を考える
  
}