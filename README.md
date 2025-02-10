# Predicting-House-Prices

## Get the data
The first step is to get the data and explore it. We will use the ames dataset that ships with the tidymodels package. T

A data set from De Cock (2011) has 82 fields were recorded for 2,930 properties in Ames IA. This version is  from the AmesHousing package but does not include a few quality columns that appear to be outcomes rather than predictors.

Our objective is to build a model that predicts sale_price. While this dataset is rich in potential features we can use, we will build the simplest possible model. only including the latitude and longitude as features.

## 1. Split the data into training and test sets
Let us start by splitting the data into training and test sets. The basic idea is to train the model on a portion of the data and test its performance on the other portion that has not been seen by the model. This is done in order to prevent overfitting.

## 2. Choose a class of model, and hyperparameters.
The next step is to choose a class of models and specify hyperparameters.  We will pick the  K Nearest Neighbours model!

## 3. Fit the model to the training data
It is time to fit the model on the training data. We will fit the simplest possible model that uses the location coordinates of the house as predictors of sale price. We use the logarithm of the sale price as the response variable, since it is highly skewed.

## 4. Use the fitted model to predict on test data
Now that we have fitted the model using training data, we can use the fitted model to predict prices for houses in the test dataset. We do this using the predict method.

## 5. Evaluate performance
A good performance measure to use here is the RMSE (Root Mean Squared Error). Additionally, we will also plot the actual prices vs. the predicted prices to get a sense of how close they are.
based off the result, the model predictions are 
# accurate
