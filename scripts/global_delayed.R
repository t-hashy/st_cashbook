# ==== Functions ====
# DATA FRAME ----
## Check the basic stats of the data ----
check_data <- function(df, plot = FALSE) {
  glimpse(df)
  print(head(df, n = 5))
  print(summary(df))
  if(plot) {
    plot(df) 
  }
  return("DONE")
}

## Export data-frame ----
export_df <- function(data, file_name = "test", directory = "data", file_type = "Rds", addDateTime = TRUE) {
  # Set file name
  file <- NULL
  if(addDateTime){
    now <- dt_to_str()
    file <- glue("{directory}/{file_name}_{now}.{file_type}")
  }else{
    file <- glue("{directory}/{file_name}.{file_type}")
  }
  # Convert into file
  if(file_type == "Rds"){
    saveRDS(data, file = file)  
  }else if(file_type == "csv"){
    write.csv(x = data, file = file, fileEncoding = "shift-jis")
  }
  # Return
  return(file)
}

# DATE TIME ----

## Convert datetime into string ----
dt_to_str <- function(datetime = Sys.time()) {
  dt <- datetime %>%
    gsub("-", "", .) %>% # Replace a blank between date and time with an under bar
    gsub(" ", "-", .) %>%
    gsub(":", "", .) %>% # Replace ":" with "-"
    as.character()
  return(dt)
}

# For Loop ----

## Create progress bar on console ----
# 1. load package with "library(progress)"
# 2. BEFORE the for-loop, write "pb <- create_new_pb(length)"
# 3. INSIDE the for-loop, write "pb$tick()"
create_new_pb <- function(length)  {
  library(progress)
  progress_bar$new(
    format = "(:spin) [:bar] :percent [Elaspsed time: :elapsedfull || Estimated time remaining: :eta]",
    total = length,
    complete = "=",
    incomplete = "-",
    current = ">",
    clear = FALSE,
    width = 100
  )
}

# Machine Learning ----

## Slit data into training and test ----
create_train_test <- function(df, size = 0.8) {
  set.seed(42)
  sample <- sample(c(TRUE, FALSE), nrow(df), replace = TRUE, prob = c(size, 1-size))
  train <- df[sample,]
  test <- df[!sample,]
  list <- list(train = train, test = test)
  return(list)
}

# Data Sync ----
## Import data from Google sheets ----
syncWithGSS <-  function(){
  
  df_rds <- df_all
  
  # Read google sheets ----
  message("Read data from google sheets")
  df_dt <- read_sheet(shtID, sheet = shtName_data)
  df_ctg <- read_sheet(shtID, sheet = shtName_ctg)
  df_mail <- read_sheet(shtID, sheet = shtName_mail)
  df_plc <- read_sheet(shtID, sheet = shtName_place)
  df_sec <- read_sheet(shtID, sheet = shtName_sec)
  df_evt <- read_sheet(shtID, shtName_ev)
  
  # Merge Google sheets ----
  df_sht <- merge(df_dt, df_mail, by = "email", all.x = TRUE) %>%
    merge(.,df_ctg, by = "id_category", all.x = TRUE) %>%
    merge(., df_evt, by = "id_event", all.x = TRUE) %>%
    merge(., df_plc, by = "id_place", all.x = TRUE) %>%
    merge(., df_sec, by = "id_section", all.x = TRUE) %>%
    select(c("id_ex", "date","amount", "name", "category", "event", "place", "section"))
  
  # Shape types of the data
  df_sht$date <- as.Date(df_sht$date, format="%y-%m-%d")
  colnames(df_sht)[1] <- "uid"
  for(col in c("name", "category", "event", "place", "section")){
    df_sht[,col] <- fct_infreq(df_sht[,col])
  }
  
  # Merge rds and Google sheet ----
  df_all <- rbind(df_sht, df_rds) %>% unique()
  
  # ==== Export the data ====
  export_df(df_all, file_name = "data", directory = "./R/data", addDateTime = FALSE)
}