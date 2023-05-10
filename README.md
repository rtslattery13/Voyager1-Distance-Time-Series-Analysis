# Voyager1 Distance Time Series Analysis
### PURPOSE:
The purpose of this project is to observe the distance travelled by the Voyager 1 spacecraft between 2013 and 2020, and produce forecasts from the given data. 

### METHODS:
1. DIFFERENCING & TRANSFORMATIONS: Because this dataset is nonstationary, differencing and/or transformations will need to be performed to remove trends and fluctuations in variance.
2. SARIMA MODELING: A SARIMA (Seasonal ARIMA) model will need to be fitted to the data. SARIMA models will be picked using the Autocorrelation, Partial Autocorrelation, and Extended Autocorrelation Functions. 
3. RESIDUAL ANALYSIS: Residual analysis will be performed to observe independence/normality of the model's residuals. This will ensure better forecasting results.
4. FORECASTING: Using the best model, a forecast will be produced and observed for how well it fits. Some of the actual values will be witheld from the model fitting process to compare to the forecasts through mean squared error.

### FINDINGS:
The model's residuals were found to be independent through the Ljung-Box test, but the Shapiro test concluded that they were not normal. This was most likely due to the presence of an outlier in the residuals. There was not much I could do in this case and had to proceed with what I had.
Forecasting was a success. The mean squared error produced between the actual and predicted values was very small, and the actual values were within the confidence intervals of the predictions.
