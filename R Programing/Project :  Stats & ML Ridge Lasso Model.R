## ridge/ lasso regression
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

mygrid <- expand.grid(alpha = 0:1, lambda = seq(0.001, 1, length = 20))
ridge_lasso_model <- train(churn ~ .,
                  data = train_df,
                  method = "glmnet",
                  metric = "AUC",
                  reProcess = c("center", "scale", "nzv"),
                  tuneGrid = mygrid,
                  trControl = ctrl)

## AUC 0.9582, precision = 0.8787, recall = 0.9784

## test model
pred_ridge_lasso <- predict(ridge_lasso_model, newdata = test_df)
confusionMatrix(pred_ridge_lasso, test_df$churn, mode = "prec_recall", positive = "Yes")

## precision = 0.5294, recall = 0.1914
