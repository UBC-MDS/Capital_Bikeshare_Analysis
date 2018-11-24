# summarise_data.py
#
# By Mike Yuan, November 2018
#
# take the tidy set and create decision treeabs
# Usage: python src/summarise_data.py data/cleaned_day.csv result/summarised_data.csv report/img/accuracy.png report/img/dtree.png result/tree_summary.csv
#


# %% load library
import pandas as pd
import numpy as np
import argparse
from sklearn import datasets
from sklearn.tree import DecisionTreeClassifier
from sklearn import model_selection
from sklearn.externals.six import StringIO
from sklearn.tree import export_graphviz
import graphviz
from sklearn.model_selection import train_test_split
import pydotplus
from IPython.display import Image
import seaborn as sns
import matplotlib.pyplot as plt
sns.set()
from tqdm import tqdm

# load arugments
parser = argparse.ArgumentParser()
parser.add_argument('input_file')
parser.add_argument('output_file')
parser.add_argument('accuracy_fig_path')
parser.add_argument('tree_fig_path')
parser.add_argument('tree_summary_path')
args = parser.parse_args()
input_file = args.input_file
output_file = args.output_file
accuracy_fig_path = args.accuracy_fig_path
tree_fig_path = args.tree_fig_path
tree_summary_path = args.tree_summary_path
# n_top_features = 5  # for picking up number of top features
# for testing
# input_file = "data/tidy_day.csv"
# output_file = "result/summarised_data.csv"
# accuracy_fig_path = "img/accuracy.png"
# tree_fig_path = "img/dtree.png"

# define report string
summary_rpt = '''\nTREE SUMMARY
=============================
the optimal tree depth: {0}
accuracy score: {1}

FILE PATH
=============================
accuracy figure: {2}
tree figure: {3}
features summary: {4}\n'''

RANDOM_STATE = 2018


def main():
    print("===> loading csv")
    # %% load csv to df
    data = pd.read_csv(input_file)
    print("done")
    # %% identify features and target
    features = ['season',
                'mnth',
                'holiday',
                'weekday',
                'year',
                'workingday',
                'weathersit',
                'temp',
                'atemp',
                'hum',
                'windspeed',
                'day_in_month']

    if 'hour' in input_file:
        features.append('hr')
    target = 'rentalship'

    # %% select only rows with rental_type as both
    data_both = data.query('rental_type == "both"')

    X = data_both[features]
    y = data_both[target]

    # %% get the class_names and sorted
    classes = y.unique()
    classes.sort()
    # %% initialize and fit the tree
    print("===> training decision tree")
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.20, random_state=RANDOM_STATE)

    tree_depth, accuracy_score = get_tree_depth(X_train, y_train, 50)

    tree = DecisionTreeClassifier(
        max_depth=tree_depth, random_state=RANDOM_STATE)
    tree.fit(X_train, y_train)

    accuracy_score = tree.score(X_test, y_test)
    print("done")

    #tree.score(X_test, y_test)
    # visualize decision tree
    # Reference: https://medium.com/@rnbrown/creating-and-visualizing-decision-trees-with-python-f8e8fa394176

    dot_data = StringIO()
    export_graphviz(tree,
                    out_file=dot_data,
                    filled=True,
                    rounded=True,
                    feature_names=features,
                    class_names=classes.tolist(),
                    special_characters=True)
    graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
    Image(graph.create_png())
    # saving the graph
    graph.write_png(tree_fig_path)

    save_feature_csv(features, tree.feature_importances_)

    print(summary_rpt.format(tree_depth,
                             accuracy_score,
                             accuracy_fig_path,
                             tree_fig_path,
                             output_file))

    # save tree summary to csv file
    tree_summary = {'optimal_tree_depth': tree_depth,
                    'accuracy_score': accuracy_score}
    tree_summary_df = pd.DataFrame(data=tree_summary,
                                   index=[0])
    tree_summary_df.to_csv(tree_summary_path)


# make the importance df and save as csv
def save_feature_csv(features, feature_importances):
    print("===> saving features to csv")
    d = {'feature': features, 'gini_value': feature_importances}
    df = pd.DataFrame(data=d)
    df = df.sort_values(by=['gini_value'],
                        ascending=False).reset_index(drop=True)
    df.to_csv(output_file)
    print("done")
    print(df)


def get_tree_depth(X_arg, y_arg, max_depth):
    print("===> getting optimal tree depth")
    depth_list = np.linspace(1, max_depth, max_depth)
    accuracy_scores = []
    for i in tqdm(depth_list, ncols=100, unit_scale=True):
        if (i > 0):
            model = DecisionTreeClassifier(
                max_depth=int(i), random_state=RANDOM_STATE)
            score = model_selection.cross_val_score(
                model, X_arg, y_arg, cv=10).mean()
            accuracy_scores.append(score)

    index = np.argmax(accuracy_scores)

    print("===> saving accuracy graph")
    plt.figure(figsize=(8, 6))
    plt.plot(depth_list, accuracy_scores, 'g-')
    plt.xlabel("Max Depth for Decision Tree")
    plt.ylabel("Accuracy Score")
    plt.title("Tree Depth vs Accuracy ")
    txt = 'depth = {0} with {1} accuracy'.format(
        (index + 1), round(accuracy_scores[index], 4))
    plt.text((index + 2), accuracy_scores[index], txt, color='purple')
    plt.plot((index + 1), accuracy_scores[index], 'ro')
    plt.tight_layout()
    plt.savefig(accuracy_fig_path)
    print("saved at {0}".format(accuracy_fig_path))

    return ((index + 1), accuracy_scores[index])



    # %% call main function
if __name__ == "__main__":
    main()
