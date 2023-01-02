# ==== Check the data ====

# Basic check ----
check_data(df_all, plot = TRUE)

# Multiple variables ----
multiplot <- df_all %>%
  select(!c(uid,place,name, event)) %>%
  ggpairs(
    mapping = aes(color = category, alpha = 0.6), # Describe factor col name that shows as color variation (also write without double-quotation)
    lower = list(continuous = "smooth", combo = "facetdensity"),
    diag = list(continuous = "barDiag")
  )

# === Regression Models ====

# Simple OLS with natural log
res <- lm(log(amount)~date+name+category+section ,data = df_all)
summary(res)
par(mfrow=c(2,2))
plot(res)
par(mfrow=c(1,1))