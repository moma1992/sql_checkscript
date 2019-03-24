# Variable initi ---------------------------------------------        
rm(list = ls())

# import lib -------------------------------------------------        
library(DBI)
library(RPostgreSQL) 
library(tidyverse)
library(readr)

# import source ----------------------------------------------        
source("./src/con_db.R")
source("./src/common.R")
source("./src/char.R")
source("./src/numeric.R")
source("./src/date.R")

# read list --------------------------------------------------        
test_table <- read_csv("test_table.csv")

# result init ------------------------------------------------        
result <- data.frame()

# common aggregate -------------------------------------------        
for (i in 1:nrow(test_table)) {
  new <- calc_common(test_table$tbl_name[i], test_table$col_name[i])
  result <- rbind(result, new)
  }                             

result