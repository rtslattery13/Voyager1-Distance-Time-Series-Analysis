# LIBRARIES
library(tseries)
library(TSA)
library(forecast)
library(LSTS)

# READING THE CSV
voyager1 = read.csv("/Users/ryanslattery/Desktop/Machine\ Learning\ Classes/MA641\ -\ Time\ Series\ Analysis/Project/Voyager1_Distance_Data.csv", header = FALSE)

# CONVERTING THE DATA TO A NUMERIC VECTOR
voyager1_data = na.omit(as.numeric(unlist(voyager1[2])))

# PLOTTING THE TIME SERIES
plot(voyager1_data, type = "o")

# WE WILL BE HOLDING OUT CERTAIN VALUES TO USE LATER FOR OUR FORECASTING. WE WILL ONLY BE OBSERVING 72 OF THE 96 VALUES
forecasting_data = voyager1_data
voyager1_data = voyager1_data[1:72]

# PERFORMING THE SEASONAL DIFFERENCE FOR MONTHLY PERIODS
v1d_seasonal_diff = diff(voyager1_data, lag = 12)

# PLOTTING THE SEASONAL DIFFERENCED DATA
plot(v1d_seasonal_diff, type = "o")

# ADF TEST
adf.test(v1d_seasonal_diff)

# REGULAR DIFFERENCING
v1d_diff = diff(v1d_seasonal_diff)

# PLOTTING THE TRANSFORMED TIME SERIES
plot(v1d_diff, type = "o")

# PERFORMING ANOTHER ADF TEST
adf.test(v1d_diff)

# THE ACF; THIS WILL GIVE THE ORDERS OF MA PARAMETERS THROUGH LOOKING AT THE FIRST SET OF SIGNIFICANT LAGS
acf(v1d_diff, lag.max = 50)

# THE PACF WILL GIVE THE NUMBER OF AR PARAMETERS THROUGH THE FIRST SIGNIFICANT LAGS.
pacf(v1d_diff, lag.max = 50)

eacf(v1d_diff)

# SARIMA(2, 1, 1)x(0, 1, 1)[12]
v1d_arima1 <- Arima(voyager1_data, order = c(2, 1, 1), seasonal = list(order = c(0, 1, 1), period = 12), method = "ML")
print(v1d_arima1)

# SARIMA(1, 1, 1)x(0, 1, 1)[12]
v1d_arima2 <- Arima(voyager1_data, order = c(1, 1, 1), seasonal = list(order = c(0, 1, 1), period = 12), method = "ML")
print(v1d_arima2)

# SARIMA(0, 1, 1)x(0, 1, 1)[12]
v1d_arima3 <- Arima(voyager1_data, order = c(0, 1, 1), seasonal = list(order = c(0, 1, 1), period = 12), method = "ML")
print(v1d_arima3)

# SARIMA(1, 1, 0)x(0, 1, 1)[12]
v1d_arima4 <- Arima(voyager1_data, order = c(1, 1, 0), seasonal = list(order = c(0, 1, 1), period = 12), method = "ML")
print(v1d_arima4)

# ACF OF SARIMA(2, 1, 1)x(0, 1, 1)[12] RESIDUALS
acf(v1d_arima1$residuals, lag.max = 50)

# LJUNG-BOX TEST TO OBSERVE IF RESIDUALS ARE INDEPENDENT
Box.Ljung.Test(v1d_arima1$residuals, lag = 50)

# NORMALITY TESTS:
# Q-Q PLOT
qqnorm(v1d_arima1$residuals)
qqline(v1d_arima1$residuals)

# HISTOGRAM PLOT
hist(v1d_arima1$residuals)

# SHAPIRO TEST
shapiro.test(v1d_arima1$residuals)

# STORING FORECASTED VALUES
forecasts <- forecast(v1d_arima1, h = 48)

# PLOTTING FORECASTS VS. ACTUAL DATA
plot(forecasts)
lines(forecasting_data)

# EVALUATING THE FORECASTS AND ACTUAL DATA WITH MSE
mse = sum((forecasts$mean[1:24] - forecasting_data[73:96])^2) / 24
print(paste0("MEAN SQUARED ERROR FOR SARIMA(2, 1, 1)x(0, 1, 1)12 FORECAST: ", mse))