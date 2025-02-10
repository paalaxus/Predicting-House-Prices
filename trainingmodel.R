install.packages('tidyverse')
install.packages('tidymodels')
install.packages('janitor')

suppressPackageStartupMessages(library(tidyverse, warn.conflicts = FALSE))
suppressPackageStartupMessages(library(tidymodels, warn.conflicts = FALSE))

#get the data
data(ames) #from tidymodels package
ames_data= janitor::clean_names(ames)
head(ames_data)

#we want to build a model that predicts sale_price. 
#start by splitting data into training and test sets

set.seed(1234)
ames_splits <- initial_split(ames_data)
ames_train <- training(ames_splits)
ames_test<- testing(ames_splits)
ames_splits

#Choose a class of model, and hyperparameters.
#next we choose a class of models and specify hyperparameters. using the k nearest neighbour model.

ames_knn_mod <- nearest_neighbor() %>%
  set_mode('regression') %>%
  set_engine('kknn') %>%
  update(neighbors = 5)

ames_knn_mod

#Fit the model to the training data
#We will fit the simplest possible model that uses the location coordinates of the house as 
#predictors of sale price. We use the logarithm of the sale price as the response variable, since it is highly skewed.

ames_knn_fit <- ames_knn_mod %>%
  fit(log10(sale_price) ~ latitude +longitude, data= ames_train)

ames_knn_fit

#next we use the fitted model to predict on test data

ames_knn_pred <- ames_knn_fit %>%
  predict(new_data=ames_test)
ames_knn_pred

#evaluate the performance
ames_test_pred <- ames_knn_pred %>%
  bind_cols(ames_test) %>% #combine test values with dataset
  mutate(truth = log10(sale_price)) #create a new column called truth

ames_test_pred %>%
  ggplot(aes(x = truth, y = .pred)) + #create scatterplot
  geom_point() + #plot individual predictions as points
  geom_smooth(method = 'lm') #overlays a linear regression trend line to show the correlation between actual and predicted values.

ames_knn_metrics <- ames_test_pred %>%
  rmse(truth = truth, estimate = .pred) #root mean square error 
#how far predictions deviate from actual values

ames_knn_metrics
