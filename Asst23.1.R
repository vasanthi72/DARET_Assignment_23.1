Apple.Price.Jun.Sep.Model <- read.csv("D:/kamagyana/Computing/DARET/Assignments/Apple-Price-Jun-Sep-Model.csv", stringsAsFactors=FALSE)
View(Apple.Price.Jun.Sep.Model)
Apple.Price.Jun.Sep.Predict <- read.csv("D:/kamagyana/Computing/DARET/Assignments/Apple-Price-Jun-Sep-Predict.csv", stringsAsFactors=FALSE)
View(Apple.Price.Jun.Sep.Predict)
app.mod <- Apple.Price.Jun.Sep.Model
app.pred <- Apple.Price.Jun.Sep.Predict
app.mod$Date <- as.Date(app.mod$Date)
str(app.mod)
app.pred$Date <- as.Date(app.pred$Date)
str(app.pred)
modeldata <- ts(app.mod$Close)
head(modeldata)
modeldata
plot(modeldata, main = "Daily Closing Prices")
library(tseries)
model1 <- lm(modeldata~c(1:length(modeldata)))
summary(model1)
plot(resid(model1), type = l)
plot(resid(model1), type = "l")
model2 <- auto.arima(modeldata)
plot(forecast(model2, h = 15))
accuracy(model2)
adf.test(diff(modeldata))
plot(diff(modeldata))
model3 <- auto.arima(diff(modeldata))
plot(forecast(model3, h = 15))
accuracy(model3)
acf(diff(modeldata))
pacf(diff(modeldata))
model4 <- Arima(diff(modeldata),order=c(3,0,0)))
model4 <- Arima(diff(modeldata),order=c(3,0,0))
summary(model4)
plot(forecast(model4, h = 15))
accuracy(model4)
accuracy(model3)
accuracy(model2)
accuracy(model1)
model5 <- Arima(modeldata, order = c(3,1,0))
pred1 <- predict(model5, n.ahead = 15)
ts.plot(modeldata,pred1$pred)
plot(pred1$pred,app.pred$Close)
pred1$pred <- as.numeric(pred1$pred)
predact <- cbind(pred1$pred, app.pred$Close)
predact <- as.data.frame(predact)
colnames(predact) <- c("predcited", "actual")
predact$time <- c(1:15)
head(predact)
library(reshape)
plotpred <- melt(predact, id.vars = "time")
library(ggplot2)
ggplot(plotpred, aes(x = time, y = value, colour = variable)) + geom_line()
summary(pred1)
predact$predupper <- as.numeric(c((pred1$pred + pred1$se)))
predact$predlower <- as.numeric(c((pred1$pred - pred1$se)))
head(predact)
plotpred <- melt(predact, id.vars = "time")
ggplot(plotpred, aes(x = time, y = value, colour = variable)) + geom_line()
forecast1 <- forecast(model4, h=15)
class(forecast1)
forecast1 <- as.numeric(forecast[,c(1:5)])
forecast1 <- as.data.frame(forecast1)
library(xts)
str(forecast1)
str(modeldata)
modeldata[6,11]
modeldatamat <- as.matrix(modeldata)
modeldatamat[66,1]
lastprice <- rep((modeldatamat[66,1]),5)
lastprice
forecast1
forecast1 <- rbind(lastprice, forecast1[1:nrow(forecast1), ])
colnames(forecast1)
forecast1[,"meanprice"] <- cumsum(forecast1$`Point Forecast`)
forecast1[,"lo80price"] <- cumsum(forecast1$)
forecast1[,"lo80price"] <- cumsum(forecast1$`Lo 80`)
forecast1[,"lo95price"] <- cumsum(forecast1$`Lo 95`)
forecast1[,"Hi80price"] <- cumsum(forecast1$`Hi 80`)
forecast1[,"Hi95price"] <- cumsum(forecast1$`Hi 95`)
head(forecast1)
predappprice <- forecast1[,c(6:10)]
predappprice
predappprice <- predappprice[-1,]
predappprice
predappprice$time <- c(1:15)
predappprice
plopredappprice <- melt(predappprice, id.vars = "time")
ggplot(plopredappprice, aes(x = time, y = value, colour = variable)) + geom_line()
cbind(predappprice,predact$actual)
predappprice <- cbind(predappprice,predact$actual)
colnames(predappprice)[7] <- c("Actual")
predappprice
plopredappprice <- melt(predappprice, id.vars = "time")
ggplot(plopredappprice, aes(x = time, y = value, colour = variable)) + geom_line()

