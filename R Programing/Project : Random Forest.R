## random forest
library(tidyverse)
library(dplyr)
library(rpart)
library(caret)
library(MLmetrics)
library(glmnet)
library(rpart.plot)

## 1.load data set churn
df <- read.csv("churn.csv")

## 2. data manipulation
mean(complete.cases(df)) # 1 is data complete

glimpse(df)
df$churn <- factor(df$churn)

df %>%
  count(churn) %>%
  mutate(pct = n/sum(n)) # unbalance case

## split data
set.seed(42)
id <- createDataPartition(y = df$churn,
                          p = 0.8,
                          list = FALSE)
train_df <- df[id, ]
test_df <- df[-id, ]

## train model
set.seed(42)
ctrl <- trainControl(
  method = "cv",
  number = 5,
  classProbs = TRUE,
  summaryFunction = prSummary,
  verboseIter = TRUE
)

rf_model <- train(churn ~ .,
                     data = train_df,
                     method = "rf",
                     metric = "AUC",
                     trControl = ctrl)

## AUC = 0.9718, Precision = 0.9395, recall = 0.9947

## test model
pred_rf <- predict(rf_model, newdata = test_df)

confusionMatrix(pred_rf, test_df$churn, mode = "prec_recall", positive = "Yes")

## precision = 0.9796, recall = 0.6809
