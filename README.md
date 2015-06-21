# Getting and Cleaning Data
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

##  Course Project Overview
The R script called 'run_analysis.R' does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to run the script?
Open RStudio and setwd() to dir where *'run_analysis.R'* and *'UCI HAR Dataset'* dataset are located. In *Console* window, type:
```
source("run_analysis.R")
(1) Merge the training and the test sets to create one data set.
(2) Extract only the measurements on the mean and standard deviation 
    for each measurement.
(3) Use descriptive activity names to name the activities in the dataset.
(4) Appropriately labels the data set with descriptive variable names.
(5) From the data set in step 4, creates a second, independent tidy 
    data set with the average of each variable for each activity and each subject.
```

For code details, please refer 'run_analysis.R' script.

## Output Interpretation Markdown
CodeBook.md above is the code book that describes the variables, the data, and the transformations that is performed by the script to clean up the data. On successful execution the output text file (i.e. *'TidyData.txt'*) gets created under current-worming-directory.

