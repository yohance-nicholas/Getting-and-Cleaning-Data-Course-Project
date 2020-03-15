
# Description -------------------------------------------------------------

# This project was completed in partial fulfilment of the Coursera Getting and
# Cleaning Data Course.The purpose of this project was to demonstrate one's
# ability to collect, work with, and clean a data set.Using data collected from
# the accelerometers from the Samsung Galaxy S smartphone, this script works
# with the data and generates a clean data set, outputting the resulting tidy
# data to a file named "tidy_data.txt".

# run_analysis.R does using the  following steps:
#    1. Merges the training and the test sets to create one data set.
#    2. Extracts only the measurements on the mean and standard deviation for each
#       measurement.
#    3. Uses descriptive activity names to name the activities in the data set
#    4. Appropriately labels the data set with descriptive variable names.
#    5. From the data set in step 4, creates a second, independent tidy data set
#       with the average of each variable for each activity and each subject.


# Loading Required Packages -----------------------------------------------

library(dplyr)

# Obtain and Extract Data -------------------------------------------------

## Download Dataset and Veryify Not Already on System

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
DATASET <- "UCI HAR Dataset.zip"

if (!file.exists(DATASET)) {
  download.file(URL, DATASET, mode = "wb")
}

## Extract Files to Predetermined Filepath

FILEPATH <- "UCI HAR Dataset"
if (!file.exists(FILEPATH)) {
  unzip(DATASET)
}


# Importing the Data ------------------------------------------------------

## Importing the Training Data
TRAINING_SUBJECTS <- read.table(file.path(FILEPATH, "train", "subject_train.txt"))
TRAINING_VALUES <- read.table(file.path(FILEPATH, "train", "X_train.txt"))
TRAINING_ACTIVITY <- read.table(file.path(FILEPATH, "train", "y_train.txt"))

## Importing the Test Data
TEST_SUBJECTS <- read.table(file.path(FILEPATH, "test", "subject_test.txt"))
TEST_VALUESs <- read.table(file.path(FILEPATH, "test", "X_test.txt"))
TEST_ACTIVITY <- read.table(file.path(FILEPATH, "test", "y_test.txt"))

## Importing the Feautres
FEATURES <- read.table(file.path(FILEPATH, "features.txt"), as.is = TRUE)

## Importing Activity Labels
ACTIVITIES <- read.table(file.path(FILEPATH, "activity_labels.txt"))
colnames(ACTIVITIES) <- c("activityId", "activityLabel")


# 1. Merging the Data Sets ------------------------------------------------

## Merge Individual Datasets into a Single Data Table
HUMAN_ACTIVITY <- rbind(
  cbind(TRAINING_SUBJECTS, TRAINING_VALUES, TRAINING_ACTIVITY),
  cbind(TEST_SUBJECTS, TEST_VALUESs, TEST_ACTIVITY)
)

## Drop individual data sets to free RAM
rm(TRAINING_SUBJECTS, TRAINING_VALUES, TRAINING_ACTIVITY, 
   TEST_SUBJECTS, TEST_VALUESs, TEST_ACTIVITY)

## Name columns of merged dataset
colnames(HUMAN_ACTIVITY) <- c("subject", FEATURES[, 2], "activity")


# 2. Extract the measurements of the mean and standard deviation ---------

## Identify Columns to Keep
COLUMNS_TO_KEEP <- grepl("subject|activity|mean|std", colnames(HUMAN_ACTIVITY))

## Retain solely the data in those columns
HUMAN_ACTIVITY <- HUMAN_ACTIVITY[, COLUMNS_TO_KEEP]

# 3. Use descriptive activity names to name the activities in the  --------

HUMAN_ACTIVITY$activity <- factor(HUMAN_ACTIVITY$activity, 
  levels = ACTIVITIES[, 1], labels = ACTIVITIES[, 2])

# 4. Appropriately label the data set with descriptive variable na --------

## Retrieve column names of HUMAN_ACTIVITY
HUMAN_ACTIVITY_COLUMNS <- colnames(HUMAN_ACTIVITY)

##  perform replacement of the special characters
HUMAN_ACTIVITY_COLUMNS <- gsub("[\\(\\)-]", "", HUMAN_ACTIVITY_COLUMNS)

## Further clean up names
HUMAN_ACTIVITY_COLUMNS <- gsub("^f", "frequencyDomain", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("^t", "timeDomain", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("Acc", "Accelerometer", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("Gyro", "Gyroscope", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("Mag", "Magnitude", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("Freq", "Frequency", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("mean", "Mean", HUMAN_ACTIVITY_COLUMNS)
HUMAN_ACTIVITY_COLUMNS <- gsub("std", "StandardDeviation", HUMAN_ACTIVITY_COLUMNS)

## Correct Typographic Errors
HUMAN_ACTIVITY_COLUMNS <- gsub("BodyBody", "Body", HUMAN_ACTIVITY_COLUMNS)

## Utlise new labels from HUMAN_ACTIVITY_COLUMNS as column names for HUMAN_ACTIVITY
colnames(HUMAN_ACTIVITY) <- HUMAN_ACTIVITY_COLUMNS


# 5. From the data set in step 4, create a second, independent tid --------

## takes an existing tbl and converts it into a grouped tbl by subject and activity
## then summarise using mean
HUMAN_ACTIVITY_MEANS <- HUMAN_ACTIVITY %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

##  prints HUMAN_ACTIVITY_MEANS to"tidy_data.txt"
write.table(HUMAN_ACTIVITY_MEANS, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
