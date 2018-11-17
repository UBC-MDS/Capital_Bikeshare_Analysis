# Capital Bikeshare Ridership Prediction

#### Mike Yuan and Evan Yathon

This analysis is performed on the [Bike Sharing Dataset](https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset) provided by the UCI Machine Learning Repository.

We are trying to answer a predictive question: What are the top three predictors of rental bike ridership for a given day in the metro DC area?

To answer this question we intend to perform supervised machine learning using decision tree classification.  Valid features such as temperature, weather and day of the week will be included.  In order to simplify the potential ridership outcomes, the ridership will be broken into different categories; an example could be low, medium and high ridership.  To find the bounds of the categories some initial exploratory data analysis will be performed to investigate the number of riders.  Our initial idea is a histogram of ridership and using quantiles to evenly split the data into thirds.

Splitting the dataset randomly into two sets will create both a training and test dataset.  The decision tree will be trained using the training dataset, and then predict the outcome of the test dataset.  Because the actual ridership outcomes are known for the test dataset, the predicted outcomes can be compared to the actual outcomes and a percentage of correctly identified outcomes will be generated.  Using a visualization of the tree and/or scikit-learn's `feature_importances_` function will determine which of the features are the top three strongest predictors of bicycle ridership.

Here is a table of tasks that we have performed and the link to the relevant script.

| Task Description                 | Link                                                                                                    | Instruction                                           |
| -------------------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| Loading the Daily Ridership Data | [load_csv.R](https://github.com/UBC-MDS/DSCI_522_Capital_Bikeshare_Analysis/blob/master/src/load_csv.R) | Under **project** directory, `Rscript src/load_csv.R` |
