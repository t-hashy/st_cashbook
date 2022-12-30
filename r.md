# Tips in R

----

## Load

### Import functions from functions.R
```
# Prep
# First to create "functions.R" in the current working directory.

# Import functions in the sheet
source( paste( "path/of/the/directory", sep = ""))
```

### Feather files
```
# Loading
# install.packages("arrow")
library(arrow)

# Export data as feather file 
write_feather(data, "path/to/the/file.feather")

# Import a feather file as a list
lst <- read_feather('path/to/the/file.feather')

```
----

## Loop

### Show progress bar in for-loop
```
# Prep
# Note that loading my functions from functions.R

# Right before the for-loops
# Set a progress-bar. (nrow(df) is the total number of the for-loop.)
pb <- create_new_pb(nrow(df))

# Inside  and the top part of the for-loops, put the below one
pb$tick()
```

----

## Plot

### Plot multiple variables
```
# Loading
library(tidyverse) # Handling df
library(ggplot2) # Plotting data
library(dplyr) # Filtering df
library(GGallay) # Plotting data

# Select columns and plot
df %>%
  dplyr::select(colname1, colname2, colname3) %>% #Describe WITHOUT doble quotation("). IF you include all columns, drop this row.
  ggpairs(
    mapping = aes(color = factor_col_name, alpha = 0.6), # Describe factor col name that shows as color variation (also write without double-quotation)
    lower = list(continuous = "smooth", combo = "facetdensity"),
    diag = list(continuous = "barDiag")
  )
```

### Plot Image Files
```
# Loading
library(imager)

# Import image file
img <- load.image(file_path)  
```

----

## Data Frame

### Merge 2 tables
```
# Merge 2 tables (df1, df2) using id columns(id1, id2)
merge(df1, df2, by.x = "id1", by.y = "id2", all.x = T)

# Options
# the id names are described with double-quotations(").
# If ids have the same name, use `by = 'id'`.
# When including all the columns, "all = T". when all ones of first table and not of second one, "all.x = T", and the opposite, "all.y = T" (*T = TRUE).
```
----

## Performance

### Calcurate Time Spending
```
system.time(expr) 
# expr: expressions to go like 'read.csv("file.csv")'.
```

----

## Date Time

### Get now
```
Sys.time()
# Returns values in full-time string: e.g."2022-11-23 08:11:11 JST".
```
