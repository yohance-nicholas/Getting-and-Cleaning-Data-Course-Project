# Coursera Getting and Cleaning Data Course Project
This repo was prepared by Yohance Nicholas in partial fulfilment of the Getting and Cleaning Data Course which comprises one of the ten courses necessary for the Data Science Specialization offered by Johns Hopikins University through Coursera.

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis.

This repository contains the following files:

- `README.md`- which provides an overview of the dataset and how it was created
- `tidy_data.txt` - which contains the dataset
- `CodeBook.md`- which describes the contents of the dataset
- `run_analysis.R`- which is the script that was used to create the dataset 

## Research Design <a name="Research-Design"></a>

The data for this project were gleaned from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#), and their description of how the data were collected is as follows:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

In line with the requirements of the course work project, training and test data were firstly merged to create one data set, subsequntly the measurements on the mean and standard deviation were extracted for each measurement,  descriptive activity names were then attributed to the activities in the data set, and then the measurements were averaged for each subject and activity, resulting in the final data set.

## Making the dataset <a name="makingg-data-set"></a>

The R script `run_analysis.R` was utilised to create the data set in it's current form. It fetches the source data set and transforms it to produce the final data set by implementing the following steps:

- Download and unzip source data if it doesn't exist.
- Read data.
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set.
- Appropriately label the data set with descriptive variable names.
- Create a second, independent tidy set with the average of each variable for each activity and each subject.
- Write the data set to the `tidy_data.txt` file.

The `tidy_data.txt` in this repository was created by running the `run_analysis.R` script using R version 3.5.2 (2018-12-20) -- "Eggshell Igloo" on Windows 10 64-bit edition.

This script requires the `dplyr` package (version 0.8.0.1 was used).
