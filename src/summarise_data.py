# summarise_data.py
#
# take the tidy set and create decision treeabs
# Usage: python3 src/summarise_data.py data/tidy_day.csv result/summarised_day.csv
#


# %% load library
import pandas as pd
import numpy as np
import argparse
from sklearn import datasets
from sklearn.tree import DecisionTreeClassifier
from sklearn.externals.six import StringIO
from sklearn.tree import export_graphviz
import graphviz
from sklearn.model_selection import train_test_split
import pydotplus
from IPython.display import Image


# load arugments
# parser = argparse.ArgumentParser()
# parser.add_argument('input_file')
# parser.add_argument('output_file')

# for testing
input_file = "data/tidy_day.csv"
output_file = "result/summarised_data.csv"


def main():
    # %% load csv to df
    data = pd.read_csv(input_file)

    # %% identify features and target
    features = ['season',
                'mnth',
                'holiday',
                'weekday',
                'workingday',
                'weathersit',
                'temp',
                'atemp',
                'hum',
                'windspeed',
                'day_in_month']
    target = 'rentalship'

    # %% select only rows with rental_type as both
    data_both = data.query('rental_type == "both"')

    X = data_both[features]
    y = data_both[target]
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20)

    tree = DecisionTreeClassifier()
    tree.fit(X_train, y_train)

    # visualize decision tree
    # Reference: https://medium.com/@rnbrown/creating-and-visualizing-decision-trees-with-python-f8e8fa394176
    dot_data = StringIO()
    export_graphviz(tree,
                    out_file=dot_data,
                    max_depth=3,
                    filled=True,
                    rounded=True,
                    feature_names=features,
                    special_characters=True)
    graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
    Image(graph.create_png())

    # saving the graph
    graph.write_png("img/dtree.png")

    # get top 3 most important factors from the tree
    most_important_index = np.argmax(tree.feature_importances_)
    features[most_important_index]
    top_feature_indice = tree.feature_importances_.argsort()[-3:][::-1]

    top_features = []
    for i in top_feature_indice:
        top_features.append(features[i])



# %% call main function
if __name__ == "__main__":
    main()
