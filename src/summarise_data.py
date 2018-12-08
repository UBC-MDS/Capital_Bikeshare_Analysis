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
font = {'family': 'normal',
        'weight': 'bold',
        'size': 22}

plt.rc('font', **font)
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
# input_file = "result/cleaned_day.csv"
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

    # tree.score(X_test, y_test)
    # visualize decision tree
    # Reference: https://medium.com/@rnbrown/creating-and-visualizing-decision-trees-with-python-f8e8fa394176

    dot_data = StringIO()
    export_graphviz(tree,
                    out_file=dot_data,
                    filled=True,
                    rounded=True,
                    feature_names=features,
                    class_names=classes.tolist(),
                    special_characters=True,
                    leaves_parallel=False,
                    max_depth=3,
                    rotate=True)
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

# %% find optimal tree depth


def get_tree_depth(X_arg, y_arg, max_depth):
    print("===> getting optimal tree depth")
    depth_list = np.linspace(1, max_depth, max_depth)

    test_accuracy = []
    train_accuracy = []
    approx_err = []

    for i in tqdm(depth_list, ncols=100, unit_scale=True):
        if (i > 0):
            model = DecisionTreeClassifier(
                max_depth=int(i), random_state=RANDOM_STATE)
            scores = model_selection.cross_validate(
                model, X_arg, y_arg, cv=10, return_train_score=True)
            test_score = scores['test_score'].mean()
            train_score = scores['train_score'].mean()
            approx_err_score = abs(test_score - train_score)
            test_accuracy.append(test_score)
            train_accuracy.append(train_score)
            approx_err.append(approx_err_score)

    index = np.argmax(test_accuracy)
    print("===> saving accuracy graph")
    plt.figure(figsize=(8, 6))
    ax = plt.gca()
    ax.tick_params(labelsize='large')
    plt.plot(depth_list, test_accuracy, 'g-', label='Test Accuracy Score')
    plt.plot(depth_list, train_accuracy, 'r-', label='Train Accuracy Score')
    txt = 'depth = {0} with {1} accuracy'.format(
        (index + 1), round(test_accuracy[index], 4))
    #plt.axvline(x=(index + 1), ymin=0.2)
    plt.xlabel("Max Depth for Decision Tree", fontsize=18)
    plt.ylabel("Accuracy Score", fontsize=18)
    plt.title("Tree Depth vs Accuracy ", fontsize=20)
    plt.legend()
    txt = 'depth = {0} with {1} accuracy'.format(
        (index + 1), round(test_accuracy[index], 4))
    plt.text((index + 2), test_accuracy[index],
             txt, color='purple', fontsize=14)
    plt.plot((index + 1), test_accuracy[index], 'ro')

    # plt.savefig('result/test.png')
    plt.savefig(accuracy_fig_path)
    print("saved at {0}".format(accuracy_fig_path))
    index = np.argmax(test_accuracy)

    return ((index + 1), test_accuracy[index])


# %% call main function
if __name__ == "__main__":
    main()
