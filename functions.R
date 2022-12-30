# ==== DATA FRAME ====

## ---- Check the basic stats of the data ----
check_data <- function(df, plot = FALSE) {
  glimpse(df)
  print(head(df, n = 5))
  print(summary(df))
  if(plot) {
    plot(df) 
  }
  return("DONE")
}

## ---- Export data-frame ----
export_df <- function(data, file_name = "test", directory = "data/", file_type = "Rds", addDateTime = TRUE) {
  # Set file name
  file <- NULL
  if(addDateTime){
    now <- dt_to_str()
    file <- paste(directory, file_name, "_", now, ".", file_type, sep = "")
  }else{
    file <- paste(directory, file_name, ".", file_type, sep = "")
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

# ==== DATE TIME ====

## ---- Convert datetime into string ----
dt_to_str <- function(datetime = Sys.time()) {
  dt <- datetime %>%
    gsub("-", "", .) %>% # Replace a blank between date and time with an under bar
    gsub(" ", "-", .) %>%
    gsub(":", "", .) %>% # Replace ":" with "-"
    as.character()
  return(dt)
}

# ==== For Loop ====

## ---- *Create progress bar on console ----
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

# ==== Machine Learning ====

## ---- *Slit data into training and test
create_train_test <- function(df, size = 0.8) {
  set.seed(42)
  sample <- sample(c(TRUE, FALSE), nrow(df), replace = TRUE, prob = c(size, 1-size))
  train <- df[sample,]
  test <- df[!sample,]
  list <- list(train = train, test = test)
  return(list)
}