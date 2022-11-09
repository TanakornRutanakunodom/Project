## R
install.packages("mlbench")
library(mlbench)
library(dplyr)
library(nnet)
library(NeuralNetTools)

data("BreastCancer")
data("BostonHousing")

## 1. Build Linear Regression
set.seed(42)
n <- nrow(BostonHousing)
sample <- sample(1:n, size = n*0.8)
train <- BostonHousing[sample, ]
test <- BostonHousing[-sample, ]

## Train Model
linear_model <- lm(medv ~ zn + indus + chas, data = train)

predict_train <- predict(linear_model)

error_train <- predict_train - train$medv
rmse_train <- sqrt(mean(error_train**2))

## Test Model
predict_test <- predict(linear_model, newdata = test)

error_test <- predict_test - test$medv
rmse_test <- sqrt(mean(error_test**2))

## Result
cat("RMSE Train :", rmse_train,
    "\nRMSE Test :", rmse_test)

## 2. Build Logistic Regression
set.seed(42)
n_2 <- nrow(BreastCancer)
sample_2 <- sample(1:n_2, size = n_2*0.8) 
train_2 <- BreastCancer[sample_2, ]
test_2 <- BreastCancer[-sample_2, ]

BreastCancer$Class <- factor(BreastCancer$Class,
                             levels = c("benign", "malignant"),
                             labels = c(0,1))
glimpse(BreastCancer)

## Train Model
logistic_Model <- glm(Class ~ Cl.thickness, data = train_2, family = "binomial")

predict_train_2 <- predict(logistic_Model, type = "response")

train_2$pred <- if_else(predict_train_2 >= 0.5, 1, 0)
accuracy_train <- mean(train_2$Class == train_2$pred)

## Test Model 
predict_test_2 <- predict(logistic_Model, type = "response", newdata = test_2)

test_2$pred <- if_else(predict_test_2 >= 0.5, 1, 0)
accuracy_test <- mean(test_2$Class == test_2$pred)

## Result
cat("Accuracy Train :", accuracy_train,
    "\nAccuracy Test :", accuracy_test)


## 3. Build Neural Network
set.seed(42)
n_3 <- nrow(BreastCancer)
sample_3 <- sample(1:n_3, size = n_3*0.8)
train_3 <- BreastCancer[sample_3, ]
test_3 <- BreastCancer[-sample_3, ]

## Train Model
nnet_model <- nnet(Class ~ Bl.cromatin, data = train_3 , size = 3)

plotnet(nnet_model)
summary(nnet_model)

## Prediction / Test Model
test_3$pred <- predict(nnet_model, type = "class", newdata = test_3)
accuracy_test_2 <- mean(test_3$Class == test_3$pred)

## Result
cat("Accurancy Test :", accuracy_test_2)
