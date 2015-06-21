## Course - Getting and Cleaning Data
## Project - R script called run_analysis.R that does the following:
## (1) Merges the training and the test sets to create one data set.
## (2) Extracts only the measurements on the mean and standard deviation 
##     for each measurement. 
## (3) Uses descriptive activity names to name the activities in the data set
## (4) Appropriately labels the data set with descriptive variable names. 
## (5) From the data set in step 4, creates a second, independent tidy data 
##     set with the average of each variable for each activity and each subject.
##
## ASSUMPTION - 'UCI HAR Dataset' is available in current-working-directory.
## Author - Sanjeev Kumar Maheve
##
library(dplyr)

## ============================================================================
## (1) Merge the training and the test sets to create one data set.
##
message("(1) Merge the training and the test sets to create one data set.")
# (1a) Read in feature file as dataframe.
features <- read.table(file="./UCI HAR Dataset/features.txt", 
                       blank.lines.skip=FALSE, header=FALSE)
# (1b) Read in activity_labels file as dataframe and assign column name(s).
activity_labels <- read.table(file="./UCI HAR Dataset/activity_labels.txt", 
                              blank.lines.skip=FALSE, header=FALSE)
colnames(activity_labels)  = c("activityCode","activityName");

# (1c) Read in all the provided training data-set into dataframe and 
# assign the column names.
X_train <- read.table(file="./UCI HAR Dataset/train/X_train.txt", 
                      blank.lines.skip=FALSE, header=FALSE)
y_train <- read.table(file="./UCI HAR Dataset/train/y_train.txt", 
                      blank.lines.skip=FALSE, header=FALSE)
subject_train <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", 
                            blank.lines.skip=FALSE, header=FALSE)
colnames(X_train) = features[, 2];
colnames(y_train) = "activityCode"
colnames(subject_train) = "subjectCode"

# (1d) Combine all the training data-set into a single dataframe.
# i.e. append y_train and subject_train into X_train.
train_set <- cbind(subject_train, y_train, X_train)

# (1e) Read in all the provided test data-set into dataframe and 
# assign the column names.
X_test <- read.table(file="./UCI HAR Dataset/test/X_test.txt", 
                     blank.lines.skip=FALSE, header=FALSE)
y_test <- read.table(file="./UCI HAR Dataset/test/y_test.txt", 
                     blank.lines.skip=FALSE, header=FALSE)
subject_test <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", 
                           blank.lines.skip=FALSE, header=FALSE)
colnames(X_test) = features[, 2];
colnames(y_test) = "activityCode"
colnames(subject_test) = "subjectCode"

# (1f) Combine all the test data-set into a single dataframe.
# i.e. append y_test and subject_test into X_test.
test_set <- cbind(subject_test, y_test, X_test)

# (1g) Finally, merge the training and test data frame into 1 dataframe.
combined_dataset <- rbind(train_set, test_set)

## ============================================================================
## (2) Extract only the measurements on the mean and standard deviation 
## for each measurement. 
message("(2) Extract only the measurements on the mean and standard deviation ")
message("    for each measurement.")
# (2a) Filter out those index values that contains mean() and std() columns.
mean_index <- grep("mean\\(\\)", colnames(combined_dataset))
std_index <- grep("std\\(\\)", colnames(combined_dataset))

# (2b) Extract only measurements for the above column indices.
final_dataset <- combined_dataset[, c(which(colnames(combined_dataset)
                                             =="subjectCode"),
                                      which(colnames(combined_dataset)
                                             =="activityCode"),
                                      mean_index, std_index)]

## ============================================================================
## (3) Use descriptive activity names to name the activities in the dataset.
message("(3) Use descriptive activity names to name the activities in the dataset.")
# (3a) Merge the data based on the activityCode to get the names in final data.
merged_dataset <- merge(final_dataset, activity_labels, 
                        by="activityCode", all=TRUE)

## ============================================================================
## (4) Appropriately label the data set with descriptive variable names.
message("(4) Appropriately labels the data set with descriptive variable names.")
# (4a) Beautify the column names to retain only alphanumeric characters.
colnames(merged_dataset) <- colnames(merged_dataset) %>%
    gsub("mean", "Mean", .) %>%
    gsub("std", "StdDev", .) %>%
    gsub("[^[:alnum:] ]", "", .)

## ============================================================================
## (5) From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
message("(5) From the data set in step 4, creates a second, independent tidy ")
message("    data set with the average of each variable for each activity and each subject.")
# 5(a) First exclude the cols that are not desired (for the time being); 
# then aggregate on each numeric variable for average.
aggregate_dataset <- aggregate(merged_dataset[, names(merged_dataset) 
                                              != c("activityCode",
                                                   "subjectCode", 
                                                   "activityName")], 
                               by=list(activityCode = 
                                           merged_dataset$activityCode,
                                       subjectCode = 
                                           merged_dataset$subjectCode),
                               mean);
# 5(b) Get back the 'activityName' back into the data by merging activity 
# dataframe.
tidy_dataset <- merge(aggregate_dataset, activity_labels, 
                      by="activityCode", all=TRUE)
# 5(c) Store the resulted dataframe into file under current directory.
write.table(tidy_dataset, "./TidyData.txt", row.names=FALSE);
