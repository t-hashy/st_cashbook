# ==== LOADINGS: Needed when initial loading ====
# Interactive plotting
library(DT) # Interactive data table
library(plotly) # Interactive plotting
# Data handling
library(tidyverse) # Data frames handling
library(dplyr) # Data base management# Data handling
library(forcats) # Factors in data frames
library(glue) # Paste strings and variables
library(stringr) # Strings manipulation
library(lubridate) # Manipulate date time easily
library(nycflights13) # Change Date time into table columns with e.g. year, month, date, etc.
library(ggplot2) # Plotting
library(GGally) # Multiple variables
# Google
library(googlesheets4) # Google sheet
# Shiny
# library(shiny) # Shiny : can't deplow without comment this out.
library(shinymanager) # Configuration
library(fontawesome) # Fontawesome(fa)
library(htmltools) # Arrange html

# ==== Environmental Variables ====
# Credentials
credentials <- data.frame(
  user = c(Sys.getenv("user1_name"), Sys.getenv("user2_name")),
  password = c(Sys.getenv("user1_pwd"), Sys.getenv("user2_pwd")),
  start = c("2022-01-01"),
  admin = c(TRUE, FALSE),
  comment = "Simple and secure authentification mechanism for sugle 'Shiny' applications.",
  stringsAsFactors = FALSE
)
# Methodology
e <- sum(rep(1,100)/factorial(0:99))

# ==== Data Import ====
df_all <- read_rds("./R/data/data.Rds")