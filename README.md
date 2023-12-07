# Effects_of_monetary_policy_on_economic-activity
Effects of monetary policy on economic activity
![Rplotttt](https://github.com/SethCodesABitForSchool/Effects_of_monetary_policy_on_economic-activity/assets/147195203/824eacde-3d9b-4a74-97c3-21088d5fdc35)
library(readxl)
CAN_macro_data <- read_excel("C:/Users/kumbalas-INS/Downloads/CAN_macro_data.xlsx")
View(CAN_macro_data)
final <- read_excel("C:/Users/kumbalas-INS/Downloads/CAN_macro_data.xlsx")
rm(CAN_macro_data)
# Scale variables (except interest rate and oil prices), take logs, and multiply by 100
final <- final %>%
mutate(EMPL = log(EMPL) * 100,
CPI.CPI = log(CPI.CPI) * 100,
M1.M1 = log(M1.M1) * 100)
# Convert nominal oil prices to real oil prices using the CPI price index
final$P_COMM.P_OIL <- final$P_COMM.P_OIL - final$CPI.CPI
# Convert the date to a proper date format
final$date <- as.Date(final$date)
# Load required libraries for VAR analysis
library(vars)
# Create a VAR object
var_data <- final[, c("EMPL", "CPI.CPI", "OVERNIGHT.OVERNIGHT", "P_COMM.P_OIL", "M1.M1")]
install.packages("ggplot2")
library(ggplot2)
ggplot(data = final) + geom_point(mapping = aes(x = EMPL, y = CPI.CPI ))
ggplot(data = final) + geom_point(mapping = aes(x = CPI.CPI, y = EMPL))
colnames(final)
ggplot(data = final) + geom_point(mapping = aes(x = EMPL, y = OVERNIGHT.OVERNIGHT ))
ggplot(data = final) + geom_point(mapping = aes(x = OVERNIGHT.OVERNIGHT, y = EMPL))
final2 <- read_excel("C:/Users/kumbalas-INS/Downloads/CAN_macro_data.xlsx")
ggplot(data = final2) + geom_point(mapping = aes(x = EMPL, y = CPI.CPI ))
ggplot(data = final2) + geom_point(mapping = aes(x = CPI.CPI, y = EMPL))
ggplot(data = final2) + geom_point(mapping = aes(x = EMPL, y = OVERNIGHT.OVERNIGHT ))
ggplot(data = final2) + geom_point(mapping = aes(x = OVERNIGHT.OVERNIGHT, y = EMPL))
ggplot(data = final2) + geom_point(mapping = aes(x = OVERNIGHT.OVERNIGHT, y = M1.M1))
empl = ts(var_data$EMPL, start = c(1961, 01, 01), frequency = 12)
cpi = ts(var_data$CPI.CPI, start = c(1961, 01, 01), frequency = 12)
rate = ts(var_data$OVERNIGHT.OVERNIGHT, start = c(1961, 01, 01), frequency = 12)
oil = ts(var_data$P_COMM.P_OIL, start = c(1961, 01, 01), frequency = 12)
m1 = ts(var_data$M1.M1, start = c(1961, 01, 01), frequency = 12)
# plot the series
autoplot(cbind(empl, cpi, rate, oil, m1))
rlang::last_trace()
library(ggplot2)
# plot the series
autoplot(cbind(empl, cpi, rate, oil, m1))
rlang::last_trace()
rlang::last_trace(drop = FALSE)
# plot the series
autoplot(cbind(empl, cpi))
# Combine the variables into a multivariate time series
mts_data <- ts(final[, c("empl", "cpi", "rate", "oil", "m1")], frequency = 12)
rlang::last_trace()
rlang::last_trace(drop = FALSE)
colnames(final)
# Combine the variables into a multivariate time series
mts_data <- ts(final[, c("EMPL", "CPI.CPI", "OVERNIGHT.OVERNIGHT", "M1.M1", "P_COMM.P_OIL" )], frequency = 12)
# Plot the multivariate time series
autoplot(mts_data)
rlang::last_trace()
rlang::last_trace(drop = FALSE)
# plot the series
autoplot(cbind(empl, cpi))
# datermine the persistence of the model
acf(cpi)
final.st = cbind(empl, cpi, m1, oil, rate)
acf(final.st)
pacf(final.st)
# Check correlation matrix
cor_matrix <- cor(final.st)
# Print correlation matrix
print(cor_matrix)
# Check for variables with high correlation
highly_correlated <- findCorrelation(cor_matrix, cutoff = 0.95)
install.packages("caret")
library(caret)
# Check for variables with high correlation
highly_correlated <- findCorrelation(cor_matrix, cutoff = 0.95)
# Print variables with high correlation
print(names(highly_correlated))
# Load required libraries for VAR analysis
library(vars)
View(cor_matrix)
lagselection = VARselect(final.st, lag.max = 10, type = "const")
View(lagselection)
lagselection$selection
# Assuming you want to use the lag order selected based on AIC
var_model1 <- VAR(final.st, p = lagselection$selection[1])
var_model2 <- VAR(final.st, p = lagselection$selection[2])
# the lag order selection
AIC <- VAR(final.st, p = lagselection$selection[1])
HQ <- VAR(final.st, p = lagselection$selection[2])
SC <- VAR(final.st, p = lagselection$selection[3])
FPE <- VAR(final.st, p = lagselection$selection[4])
# Print a summary of the VAR model
aic = summary(AIC)
# Print a summary of the VAR model
summary(AIC)
hq = summary(HQ)
sc = summary(SC)
fpe = summary(FPE)
# Assuming you want to use a higher lag order (e.g., 15)
var_model1 <- VAR(final.st, p = 15)
# Print a summary of the VAR model
summary(var_model1)
# Check for constant variables
constant_vars <- apply(final.st, 2, function(x) length(unique(x)) == 1)
# Print names of constant variables
print(names(constant_vars[constant_vars]))
# Remove constant variables
final.st_no_const <- final.st[, !constant_vars]
# Fit VAR model without constant variables
var_model2 <- VAR(final.st_no_const, p = 15)
# Print a summary of the VAR model
summary(var_model2)
# Fit VAR model with a reduced lag order (e.g., 5)
var_model3 <- VAR(final.st_no_const, p = 5)
# Print a summary of the VAR model
summary(var_model3)
# Check correlation matrix
cor_matrix <- cor(final.st_no_const)
# Print correlation matrix
print(cor_matrix)
# Find highly correlated variable pairs
highly_correlated_pairs <- which(cor_matrix > 0.8 & cor_matrix < 1, arr.ind = TRUE)
# Print highly correlated variable pairs
print(highly_correlated_pairs)
adf.test(final.st)
install.packages("tseries")
library(tseries)
adf_test_result <- adf.test(final.st)
for (col in colnames(final.st)) {
adf_test_result <- adf.test(final.st[[col]])
print(paste("ADF Test for", col))
print(adf_test_result)
}
# Loop through columns and apply ADF test
for (col in colnames(final.st)) {
col_data <- final.st[, col]
adf_test_result <- adf.test(col_data)
print(paste("ADF Test for", col))
print(adf_test_result)
}
# Differencing each column
final.st_diff <- apply(final.st, 2, diff)
# Print the head of the differenced data frame
head(final.st_diff)
# Loop through columns and apply ADF test
for (col in colnames(final.st_diff)) {
col_data <- final.st_diff[, col]
adf_test_result <- adf.test(col_data)
print(paste("ADF Test for", col))
print(adf_test_result)
}
View(final.st_diff)
View(final.st_diff)
empl = ts(final.st_diff$empl, start = c(1961, 01, 01), frequency = 12)
lagselection = VARselect(final.st_diff, lag.max = 10, type = "const")
lagselection$selection
# the lag order selection
AIC <- VAR(final.st_diff, p = lagselection$selection[1])
HQ <- VAR(final.st_diff, p = lagselection$selection[2])
SC <- VAR(final.st_diff, p = lagselection$selection[3])
FPE <- VAR(final.st_diff, p = lagselection$selection[4])
# Print a summary of the VAR model
aic = summary(AIC)
hq = summary(HQ)
sc = summary(SC)
fpe = summary(FPE)
# Check correlation matrix
cor_matrix_diff <- cor(final.st_diff)
print(cor_matrix_diff)
# Check VIF (install the 'car' package if not already installed)
# install.packages("car")
library(car)
# Check VIF (install the 'car' package if not already installed)
install.packages("car")
install.packages("car")
library(car)
vif_results <- vif(lm(final.st_diff[, -1] ~ ., data = final.st_diff))
diff = as.data.frame(final.st_diff)
vif_results <- vif(lm(diff[, -1] ~ ., data = diff))
# Convert matrix to data frame
diff <- as.data.frame(final.st_diff)
# Check the structure of the data frame
str(diff)
# Now try VIF calculation again
vif_results <- vif(lm(diff[, -1] ~ ., data = diff))
# Find constant variables
constant_vars <- apply(diff, 2, function(x) length(unique(x)) == 1)
constant_vars <- which(constant_vars)
# Remove constant variables
diff_no_const <- diff[, -constant_vars]
# Check the structure of the data frame without constant variables
str(diff_no_const)
# Now try VIF calculation again
vif_results <- vif(lm(empl ~ ., data = diff_no_const))
# Check the summary of the data frame without constant variables
summary(diff_no_const)
View(diff_no_const)
View(diff)
# Find constant variables
constant_vars <- apply(diff, 2, function(x) length(unique(x)) == 1)
constant_vars <- which(constant_vars)
# Print the constant variables
print(constant_vars)
# Remove constant variables
diff_no_const <- diff[, -constant_vars]
# Check the structure of the data frame without constant variables
str(diff_no_const)
View(diff_no_const)
# Check the structure of the original data frame
str(diff)
# Check the summary of the original data frame
summary(diff)
# Now try VIF calculation again
vif_results <- car::vif(lm(empl ~ ., data = diff))
print(vif_results)
lagselection = VARselect(diff, lag.max = 10, type = "const")
lagselection$selection
# the lag order selection
AIC <- VAR(diff, p = lagselection$selection[1])
HQ <- VAR(diff, p = lagselection$selection[2])
SC <- VAR(diff, p = lagselection$selection[3])
FPE <- VAR(diff, p = lagselection$selection[4])
# Print a summary of the VAR model
aic = summary(AIC)
# Fit VAR model
var_model <- vars::VAR(diff, p = 10)
# Impulse response analysis
irf_results <- vars::irf(var_model, impulse = c("cpi", "m1", "oil", "rate"), response = c("empl"), n.ahead = 48)
# Plot the results
plot(irf_results)
# Compute FEVD
fevd_results <- vars::fevd(var_model, n.ahead = 48)
# Print FEVD results
print(fevd_results)
plot(fevd_results, which = "empl")
warnings()
warnings()
# Suppress warnings while plotting
suppressWarnings(plot(fevd_results, which = "empl"))
View(fevd_results)
plot(fevd_results)
# Suppress warnings while plotting
suppressWarnings(plot(fevd_results, which = "empl"))
plot(fevd_results$cpi)
plot(fevd_results$empl)
print(fevd_results)
fresults = as.data.frame(fevd_results)
cumulative_contribution_empl <- rowSums(fevd_results$empl)
print(cumulative_contribution_empl)
# Extract the contribution of each variable to the forecast error variance of empl
contribution_empl <- fevd_results$empl[, -1]  # Exclude empl itself
# Calculate the cumulative contribution for each variable
cumulative_contribution_empl <- apply(contribution_empl, 2, cumsum)
# Print the cumulative contribution
print(cumulative_contribution_empl)
plot(cumulative_contribution_empl)
install.packages("ggplot2")
install.packages("ggplot2")
install.packages("reshape2")
install.packages("reshape2")
library(ggplot2)
library(reshape2)
# Create a data frame for visualization
plot_data <- data.frame(
Time = 1:48,  # Assuming you have 48 time periods
Empl = cumulative_contribution_empl[, "empl"],
CPI = cumulative_contribution_empl[, "cpi"],
M1 = cumulative_contribution_empl[, "m1"],
Oil = cumulative_contribution_empl[, "oil"],
Rate = cumulative_contribution_empl[, "rate"]
)
# Extract cumulative contributions from the list
cumulative_contribution_empl <- lapply(fevd_results, function(x) rowSums(x))
# Convert to data frame for visualization
plot_data <- data.frame(
Time = 1:48,  # Assuming you have 48 time periods
Empl = cumulative_contribution_empl$empl,
CPI = cumulative_contribution_empl$cpi,
M1 = cumulative_contribution_empl$m1,
Oil = cumulative_contribution_empl$oil,
Rate = cumulative_contribution_empl$rate
)
# Melt the data for better plotting with ggplot
plot_data_melted <- melt(plot_data, id.vars = "Time", variable.name = "Variable", value.name = "Cumulative_Contribution")
# Plot with ggplot2
library(ggplot2)
ggplot(plot_data_melted, aes(x = Time, y = Cumulative_Contribution, color = Variable)) +
geom_line() +
labs(title = "Cumulative Contribution of Variables to Forecast Error Variance of Empl",
x = "Time",
y = "Cumulative Contribution") +
theme_minimal()
# Load required libraries for VAR analysis
plot(final)
# Load required libraries for VAR analysis
plot.ts(final.st)
plot.ts(final.st_diff)
autoplot(final.st)
View(final)
ggplot(final, aes(x = Time, y = Value, color = Variable)) +
geom_line() +
labs(title = "Transformed Variables Over Time",
x = "Time",
y = "Value") +
theme_minimal()
rlang::last_trace()
rlang::last_trace(drop = FALSE)
str(final)
colnames(final)
# Melt the data for better plotting with ggplot
final_melted <- melt(final, id.vars = "date", variable.name = "Variable", value.name = "Value")
# Plot with ggplot2
library(ggplot2)
ggplot(final_melted, aes(x = date, y = Value, color = Variable)) +
geom_line() +
labs(title = "Transformed Variables Over Time",
x = "Date",
y = "Value") +
theme_minimal()
View(final_melted)
View(final)
ggplot(final, aes(x = date, y = empl, color = Variable)) +
geom_line() +
labs(title = "Transformed Variables Over Time",
x = "Date",
y = "Value") +
theme_minimal()
# Extract the numeric columns from the final dataframe
numeric_cols <- final[, sapply(final, is.numeric)]
# Plot all variables in the same graph
matplot(final$date, numeric_cols, type = "l", lty = 1, col = 1:ncol(numeric_cols), xlab = "Date", ylab = "Value")
# Add legend
legend("topright", legend = colnames(numeric_cols), col = 1:ncol(numeric_cols), lty = 1)
# Select relevant columns for each group
final2 = as.data.frame(final.st)
View(final2)
X0t <- final2$oil
X1t <- final2$empl
X1t_cpi <- final2$cpi
X2t <- final2$m1
Rt <- final2$rate
# Create a new dataframe for plotting
plot_data <- data.frame(date = final$date, X0t, X1t, X1t_cpi, X2t, Rt)
# Melt the data for better plotting with ggplot
plot_data_melted <- melt(plot_data, id.vars = "date", variable.name = "Variable", value.name = "Value")
# Plot with ggplot2
ggplot(plot_data_melted, aes(x = date, y = Value, color = Variable)) +
geom_line() +
labs(title = "Variables Over Time",
x = "Date",
y = "Value") +
theme_minimal()
# Plot with ggplot2
ggplot(plot_data, aes(x = date, y = Value, color = Variable)) +
geom_line() +
labs(title = "Variables Over Time",
x = "Date",
y = "Value") +
theme_minimal()
rlang::last_trace()
date = subset(final, select = c("date"))
new = cbind(date, final2)
View(new)
str(new)
savehistory("~/Final/ffff.Rhistory")
