library(randomForest)
library(caret)
data <- read.csv("Churn_Modelling.csv")
str(data)
summary(data)
data$CreditScore <- as.factor(data$CreditScore)
set.seed(123)
trainIndex <- createDataPartition(data$CreditScore, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]
rf_model <- randomForest(CreditScore ~ ., data = trainData, ntree = 100, mtry = sqrt(ncol(trainData) - 1))
print(rf_model)
rf_predictions <- predict(rf_model, newdata = testData)
confusionMatrix(rf_predictions, testData$CreditScore)
importance(rf_model)
varImpPlot(rf_model)

