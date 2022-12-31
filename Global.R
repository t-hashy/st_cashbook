# ==== LOADINGS ====
# Basics
library(tidyverse) # Data frames handling
library(dplyr) # Data base management
library(forcats) # Factoers in data frames
library(glue) # Paste strings and variables
library(lubridate) # Manupulate date time easily
library(nycflights13) # Change Date time into table columns with e.g. year, month, date, etc.
library(ggplot2) # Plotting
library(GGally) # Multiple variables
# Interactive plotting
library(DT) # Interactive data table
library(plotly) # Interactive plotting
# Google
library(googlesheets4) # Google sheet
# Shiny
library(shiny) # Shiny

# ==== Methodology ====
e <- sum(rep(1,100)/factorial(0:99))

# ==== Google Sheet ====
shtID <- "1mt5h1BqQyojIZRxdNsPQSHivm8jZTPUmnx-Cd579YzE"
shtName_data <- "Data"
shtName_mail <- "lstEmails"
shtName_place <- "lstPlaces"
shtName_ctg <- "lstCategories"
shtName_sec <- "lstSections"
shtName_ev <- "lstEvents"