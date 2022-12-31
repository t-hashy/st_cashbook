# === Regression Models ====

# Simple OLS with natural logarhism
res <- lm(log(amount)~date+name+category+section ,data = df_all)
summary(res)
par(mfrow=c(2,2))
plot(res)
par(mfrow=c(1,1))