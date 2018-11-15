# Capital Bikeshare Ridership Prediction
#### Mike Yuan and Evan Yathon

This analysis is performed on the [Bike Sharing Dataset](https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset) provided by the UCI Machine Learning Repository.  

We are trying to answer a predictive question; can we predict rental bike ridership for a given day based on features such as weather conditions, day of the week and season?

To answer this question we intend to perform supervised machine learning using decision tree classification.  Valid features such as temperature, weather and day of the week will be included.  In order to simplify the potential ridership outcomes, the ridership will be broken into different categories; an example could be low, medium and high ridership.  To find the bounds of the categories some initial exploratory data analysis in the form of a histogram will be performed to investigate the number of riders.  

Splitting the dataset randomly into two sets will create both a training and test dataset.  The decision tree will be trained using the training dataset, and then predict the outcome of the test dataset.  Because the actual ridership outcomes are known for the test dataset, the predicted outcomes can be compared to the actual outcomes and a percentage of correctly identified outcomes will decide whether or not rental bike ridership can be predicted.
