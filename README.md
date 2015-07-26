# Coursera Getting and Cleaning Data Course Project

##Project
This is the course project for the Coursera course: Getting and Cleaning Data. The goal is to prepare tidy data that can be used for later analysis. 

##Data
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Script
The R script, run_analysis.R, does the following:

* Download the dataset and unzip it

* Merge the training and the test sets to create one data set

* Extract only the measurements on the mean and standard deviation for each measurement

* Use descriptive activity names to name the activities in the data set

* Label the data set with descriptive variable names

* Create a independent tidy data set with the average of each variable for each activity and each subject

* Write to file __tidydata.txt__

