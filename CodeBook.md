# Getting and Cleaning Data
The purpose of this markdown is to describes the variables, the data, and transformations that R script performed to clean up the data.

## Location of the dataset
Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

### Experiment Overview
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The following are the files that were considered for this project.

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

## Transformations
There are 561 variables or columns in the taining and testing datasets. Out of which we are mainly interested to process entries that include mean() and std() at the end. There are entries with 'mean' and 'std' in an earlier part of the name as well but the script do not consider them.

Following are the steps that 'run_analysis.R' executes:
#### Merge the training and the test sets to create one data set.
 1. Read in all the provided training data-set into dataframe and assign the column names.
 2. Read in activity_labels file as dataframe and assign column name(s).
 3. Combine all the training data-set into a single dataframe i.e. append y_train and subject_train into X_train.
 4. Read in all the provided test data-set into dataframe and assign the column names.
 5. Combine all the test data-set into a single dataframe i.e. append y_test and subject_test into X_test.
 6. Finally, merge the training and test data frame into 1 dataframe.
#### Extract only the measurements on the mean and standard deviation for each measurement.
 1. Filter out those index values that contains mean() and std() columns.
 2. Extract only measurements for the above column indices.
#### Use descriptive activity names to name the activities in the data set.
 1. Merge the data based on the *activityCode* to get the names in final dataset.
#### Appropriately labels the data set with descriptive variable names.
 1. Beautify the column names to retain only alphanumeric characters.
#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 1. First exclude the cols that are not desired (for the time being); then aggregate on each numeric variable for average.
 2. Get back the 'activityName' back into the data by merging activity dataframe.
 3. Store the resulted dataframe into file under current directory.

## Output
The output text filename is 'TidyData.txt' and it is generated with write.table() using row.name=FALSE. The header variable/column names are:
```
"activityCode" 
"subjectCode" 
"tBodyAccMeanX" 
"tBodyAccMeanY" 
"tBodyAccMeanZ" 
"tGravityAccMeanX" 
"tGravityAccMeanY" 
"tGravityAccMeanZ" 
"tBodyAccJerkMeanX" 
"tBodyAccJerkMeanY" 
"tBodyAccJerkMeanZ" 
"tBodyGyroMeanX" 
"tBodyGyroMeanY" 
"tBodyGyroMeanZ" 
"tBodyGyroJerkMeanX" 
"tBodyGyroJerkMeanY" 
"tBodyGyroJerkMeanZ" 
"tBodyAccMagMean" 
"tGravityAccMagMean" 
"tBodyAccJerkMagMean" 
"tBodyGyroMagMean" 
"tBodyGyroJerkMagMean" 
"fBodyAccMeanX" 
"fBodyAccMeanY" 
"fBodyAccMeanZ" 
"fBodyAccJerkMeanX" 
"fBodyAccJerkMeanY" 
"fBodyAccJerkMeanZ" 
"fBodyGyroMeanX" 
"fBodyGyroMeanY" 
"fBodyGyroMeanZ" 
"fBodyAccMagMean" 
"fBodyBodyAccJerkMagMean" 
"fBodyBodyGyroMagMean" 
"fBodyBodyGyroJerkMagMean" 
"tBodyAccStdDevX" 
"tBodyAccStdDevY" 
"tBodyAccStdDevZ" 
"tGravityAccStdDevX" 
"tGravityAccStdDevY" 
"tGravityAccStdDevZ" 
"tBodyAccJerkStdDevX" 
"tBodyAccJerkStdDevY" 
"tBodyAccJerkStdDevZ" 
"tBodyGyroStdDevX" 
"tBodyGyroStdDevY" 
"tBodyGyroStdDevZ" 
"tBodyGyroJerkStdDevX" 
"tBodyGyroJerkStdDevY" 
"tBodyGyroJerkStdDevZ" 
"tBodyAccMagStdDev" 
"tGravityAccMagStdDev" 
"tBodyAccJerkMagStdDev" 
"tBodyGyroMagStdDev" 
"tBodyGyroJerkMagStdDev" 
"fBodyAccStdDevX" 
"fBodyAccStdDevY" 
"fBodyAccStdDevZ" 
"fBodyAccJerkStdDevX" 
"fBodyAccJerkStdDevY" 
"fBodyAccJerkStdDevZ" 
"fBodyGyroStdDevX" 
"fBodyGyroStdDevY" 
"fBodyGyroStdDevZ" 
"fBodyAccMagStdDev" 
"fBodyBodyAccJerkMagStdDev" 
"fBodyBodyGyroMagStdDev" 
"fBodyBodyGyroJerkMagStdDev" 
"activityName"
```
