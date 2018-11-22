# Capital Bikeshare Ridership Prediction

<sup>Mike Yuan ([Mikeymice](https://github.com/Mikeymice)) and Evan Yathon ([EvanYathon](https://github.com/EvanYathon)) </sup>

This analysis is performed on the [Bike Sharing Dataset](https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset) provided by the UCI Machine Learning Repository.

We are trying to answer a predictive question: What are the top three predictors of rental bike ridership for a given day in the metro DC area?

To answer this question we intend to perform supervised machine learning using decision tree classification.  Valid features such as temperature, weather and day of the week will be included.  In order to simplify the potential ridership outcomes, the ridership will be broken into different categories; an example could be low, medium and high ridership.  To find the bounds of the categories some initial exploratory data analysis will be performed to investigate the number of riders.  Our initial idea is a histogram of ridership and using quantiles to evenly split the data into thirds.

Splitting the dataset randomly into two sets will create both a training and test dataset.  The decision tree will be trained using the training dataset, and then predict the outcome of the test dataset.  Because the actual ridership outcomes are known for the test dataset, the predicted outcomes can be compared to the actual outcomes and a percentage of correctly identified outcomes will be generated.  Using a visualization of the tree and/or scikit-learn's `feature_importances_` function will determine which of the features are the top three strongest predictors of bicycle ridership.

## Usage

1.  Clone this repo, and using the command line, navigate to the root of this project.
2.  Run the following commands:

    ```sh
    Rscript src/load_csv.R data/day.csv data/cleaned_day.csv
    python3 src/summarise_data.py data/cleaned_day.csv result/summarised_data.csv img/accuracy.png img/dtree.png

    # add more script below REMOVE THIS LINE afterward!!!!!
    ```

    or on your command shell

    ```sh
    bash run_all.sh
    ```

## Dependencies

-   ### R and R libraries
    -   `tidyverse`
    -   `lubridate`
    -   `ggplot2`
    -   `rmarkdown`
    -   `knitr`
-   ### Python
    -   `pandas`
    -   `numpy`
    -   `sklearn`
    -   `graphviz`
    -   `pydotplus`
    -   `seaborn`
    -   `Ipython`
    -   `matplotlib`
    -   `tqdm`
