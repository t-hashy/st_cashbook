# ==== Import data from Google sheets ====
df_dt <- read_sheet(shtID, sheet = shtName_data)
df_ctg <- read_sheet(shtID, sheet = shtName_ctg)
df_mail <- read_sheet(shtID, sheet = shtName_mail)
df_plc <- read_sheet(shtID, sheet = shtName_place)
df_sec <- read_sheet(shtID, sheet = shtName_sec)
df_evt <- read_sheet(shtID, shtName_ev)

# ==== Merge sheets =====
