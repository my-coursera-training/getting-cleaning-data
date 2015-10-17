This repo provides a possible solution to the course project.

There is only one script "run_analysis.R", that performs all the operations.

1. Reading training set and appending numeric code for the activity
2. Reading test set and appending numeric code for the activity
3. Merging datasets
4. Setting variable names
5. replacing numeric codes of activities with their descriptive labels
6. Selecting the variables with the means and standard deviations (those that contains mean() or std() in the label)
7. Calculating averages per activity and subject, and saving it to a txt file without headers.