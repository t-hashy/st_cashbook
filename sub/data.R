# ==== Import data from Google sheets ====
df_dt <- read_sheet(shtID, sheet = shtName_data)
df_ctg <- read_sheet(shtID, sheet = shtName_ctg)
df_mail <- read_sheet(shtID, sheet = shtName_mail)
df_plc <- read_sheet(shtID, sheet = shtName_place)
df_sec <- read_sheet(shtID, sheet = shtName_sec)
df_evt <- read_sheet(shtID, shtName_ev)

# ==== Merge sheets =====
df_all <- merge(df_dt, df_mail, by = "email", all.x = TRUE) %>%
  merge(.,df_ctg, by = "id_category", all.x = TRUE) %>%
  merge(., df_evt, by = "id_event", all.x = TRUE) %>%
  merge(., df_plc, by = "id_place", all.x = TRUE) %>%
  merge(., df_sec, by = "id_section", all.x = TRUE) %>%
  select(c("id_ex", "date","amount", "name", "category", "event", "place", "section"))
colnames(df_all)[1] <- "uid"
for(col in c("name", "category", "event", "place", "section")){
  df_all[,col] <- fct_infreq(df_all[,col]) %>%
    fct_lump_n(15)
}

# ==== Check the data ====

# Basic check
check_data(df_all, plot = TRUE)

# Multiple variables
df_all %>%
  select(!c(uid,place,name, event)) %>%
  ggpairs(
    mapping = aes(color = category, alpha = 0.6), # Describe factor col name that shows as color variation (also write without double-quotation)
    lower = list(continuous = "smooth", combo = "facetdensity"),
    diag = list(continuous = "barDiag")
  )

# Plotly
ggplotly(ggplot())
browseVignettes(package = "dplyr")

# ==== Export the data ====
export_df(df_all, file_name = "data", directory = "sub/", addDateTime = FALSE)