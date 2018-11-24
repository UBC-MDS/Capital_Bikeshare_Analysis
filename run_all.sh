# run_all.sh
#
#
# This driver script completes the textual analysis of
#
#
# Usage: bash run_all.sh

# read the raw csv
echo "Running load_csv"
Rscript src/load_csv.R data/day.csv data/cleaned_day.csv &
wait $!

# produce summary result
echo "Generate Summary"
python src/summarise_data.py data/cleaned_day.csv result/summarised_data.csv report/img/accuracy.png report/img/dtree.png result/tree_summary.csv &
wait $!

# Produce Graphs
echo "Creating EDA Plots"
Rscript src/eda_plots.R data/cleaned_day.csv report/img/plot &
wait $!

# produce top ML attributes chart
echo "Creating Feature Importance Plot"
Rscript src/important_features.R result/summarised_data.csv report/img/important_features.png &
wait $!

# Make report

echo "COMPLETED"
