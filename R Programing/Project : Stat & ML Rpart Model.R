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

rpart_model <- train(churn ~ .,
                   data = train_df,
                   method = "rpart",
                   metric = "AUC",
                   trControl = ctrl)

## AUC = 0.9081, cp = 0.0194

## Explore
rpart.plot(rpart_model$finalModel)
