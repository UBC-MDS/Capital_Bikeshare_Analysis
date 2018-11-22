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
echo "Gennerate Summary"
python3 src/summarise_data.py data/cleaned_day.csv result/summarised_data.csv img/accuracy.png img/dtree.png &
wait $!

# Produce Graphs

# Make report

echo "COMPLETED"
