# GettingAndCleaningData
Final Assignment of the Getting and Cleaning Data Course from John Hopkins at Coursera

The data source is: Human Activity Recognition Using Smartphones Dataset, Version 1.0, www.smartlab.ws
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## run_analysis.R code explanation
I merged the test and training dataset row-wise together
- Each column displays a feature, the three last columns display numeric label, subject name and activity.
- These features are measured at each observation, and each observation corresponds to one row in the data frame.
- I extracted only the measurements on the mean and standard deviation for each measurement.
- I used descriptive activity names to name the activities in the data set

## tidy_ds.txt output file explanation
In this file the average of each variable (feature) for each activity and subject was calculated.
column names are "activity"."subject"

