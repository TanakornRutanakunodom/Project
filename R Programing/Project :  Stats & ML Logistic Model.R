## logistic model

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

myGrid <- expand.grid(alpha = 0:1, lambda = seq(0.001, 1, length = 20))

logistic_model <- train(churn ~ .,
                        data = train_df,
                        method = "glm",
                        metric = "AUC",
                        preProcess = c("center", "scale", "nzv"),
                        trControl = ctrl)

## AUC = 0.9588, precision = 0.8821, recall = 0.9737

## test model
pred_logistic <- predict(logistic_model, newdata = test_df)
confusionMatrix(pred_logistic, test_df$churn, positive = "Yes", mode = "prec_recall")

## Precision = 0.5200, recall = 0.1844
