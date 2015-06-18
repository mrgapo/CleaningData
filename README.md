#Coursera Getting and Cleaning Data Course Work
Script *run_analysis.R* executes following steps:
1. Read  test & Train data, and merge those. Column names are assigned.
2. Select variables related to mean and standard deviation
3. Replace activities with names
4. Prepares new tidy data set with the average of each variable for each activity and each subject.
5. Saves it in tidy_data.txt in the working directory. Data set saved in text format and could be read back into R with read.table("./tidy_data.txt", header=TRUE)

See detailed info about data in code book

## Why prepared dataset is tidy
Each variable is in one column, Each different observation of that variable is in a different row

## Why variable names are descriptive
Each variable name includes 

##Preconditions for script execution
1. Path to data from working directory  "./UCI HAR Dataset"
2. package dplyr is installed.




