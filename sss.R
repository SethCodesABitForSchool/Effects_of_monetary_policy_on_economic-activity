library(ggplot2)

# Assuming your dataframe is named 'final' and 'date' is the date column
# Make sure to replace variable names with the actual column names in your dataset

# Select relevant columns for each group
final2 = as.data.frame(final.st)

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
ggplot(plot_data, aes(x = date, y = Value, color = Variable)) +
  geom_line() +
  labs(title = "Variables Over Time",
       x = "Date",
       y = "Value") +
  theme_minimal()

library(ggplot2)

library(ggplot2)

ggplot(new, aes(x = date2)) +
  geom_line(aes(y = empl, color = "Employment")) +
  geom_line(aes(y = cpi, color = "CPI")) +
  geom_line(aes(y = m1, color = "M1")) +
  geom_line(aes(y = oil, color = "Oil")) +
  geom_line(aes(y = rate, color = "Rate")) +
  
  labs(title = "Time Series of Variables",
       x = "Date",
       y = "Values") +
  
  scale_color_manual(values = c("Employment" = "blue",
                                "CPI" = "black",
                                "M1" = "green",
                                "Oil" = "orange",
                                "Rate" = "purple")) +
  
  theme(legend.position = "right")

new$date <- as.Date(new$date)

summary(new)

dt = cbind(empl, cpi, m1, oil, rate)

empl = ts(final$EMPL, start = c(1961, 01, 01), frequency = 12)
cpi = ts(final$CPI.CPI, start = c(1961, 01, 01), frequency = 12)
rate = ts(final$OVERNIGHT.OVERNIGHT, start = c(1961, 01, 01), frequency = 12)
oil = ts(final$P_COMM.P_OIL, start = c(1961, 01, 01), frequency = 12)
m1 = ts(final$M1.M1, start = c(1961, 01, 01), frequency = 12)
# If the date column is in the format "YYYY-MM-DD"
date2 = final$date <- as.Date(final$date, format = "%Y-%m-%d")

plot(empl)
plot(cpi)






# Assuming 'empl' and 'cpi' are your time series data
matplot(x = new$date, y = cbind(new$empl, new$cpi), type = "l", col = c("blue", "red"),
        xlab = "Date", ylab = "Values", main = "Time Series Plot of empl and cpi")

# Adding a legend
legend("topright", legend = c("empl", "cpi"), col = c("blue", "red"), lty = 1)

par(mfrow = c(1,1))



# Set the outer margins to zero to fill the whole plotting area
par(mar = c(0, 0, 0, 0))

# Assuming 'empl' and 'cpi' are your time series data
matplot(x = new$date, y = cbind(new$empl, new$cpi), type = "l", col = c("blue", "red"),
        xlab = "Date", ylab = "Values", main = "Time Series Plot of empl and cpi")

# Adding a legend
legend("topright", legend = c("empl", "cpi"), col = c("blue", "red"), lty = 1)

# Reset the margins to default after plotting
par(mar = c(2, 2, 2, 2) + 0.5)



# Plot the first time series
plot(x = new$date, y = new$empl, type = "l", col = "blue", xlab = "Date", ylab = "Values",
     main = "Time Series Plot of empl and cpi")

# Add the second time series
lines(x = new$date, y = new$cpi, col = "red")

# Adding a legend
legend("topright", legend = c("empl", "cpi"), col = c("blue", "red"), lty = 1)


# Set the width and height of the plotting device
pdf("output_plot.pdf", width = 10, height = 5)

# Assuming 'empl' and 'cpi' are your time series data
matplot(x = new$date, y = cbind(new$empl, new$cpi), type = "l", col = c("blue", "red"),
        xlab = "Date", ylab = "Values", main = "Time Series Plot of empl and cpiddd")

# Adding a legend
legend("topright", legend = c("empl", "cpi"), col = c("blue", "red"), lty = 1)

# Close the plotting device
dev.off()


print("ee")



# Assuming 'empl' and 'cpi' are your time series data
matplot(x = new$date, y = cbind(new$empl, new$cpi), type = "l", col = c("blue", "red"),
        xlab = "Date", ylab = "Values", main = "Time Series Plot of empl and cpi")

# Adding a legend
legend("topright", legend = c("empl", "cpi"), col = c("blue", "red"), lty = 1)


















