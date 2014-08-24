# Getting and Cleaning Data Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## The script

The cleanup script (run_analysis.R) does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Running the script

To run the script, source `run_analysis.R`. Be careful to have "UCI HAR Dataset" data directory in the same level and, if needed, set your working directory.

## Process

1. Merges the training and the test sets to create one data set.
    1. Load X_Train data
    2. Load Y_Train data
    3. Load Subject_train data
    4. Merge the above datasets
	
	5. Load X_Test data
    6. Load Y_Test data
    7. Load Subject_test data
    8. Merge the above datasets
	
	9. Merge Train and Test data to produce first intermediate dataset (TAT_data_s1)

2. Extracts only the measurements on the mean and standard deviation for each measurement
	1. Read features dataset
	2. Make some cleaning on names
	3. Select only needed features (Mean and Std)
	4. Produce second intermediate dataset (TAT_data_s2)
	
3. Uses descriptive activity names to name the activities in the data set
	1. Add activity labels and produce third intermediate dataset (TAT_data_s3)
	
4. Appropriately labels the data set with descriptive activity names
	1. Labels data and produce fourth intermediate dataset (TAT_data_s4)

5. Creates a tidy data set with the average of each variable for each activity and each subject.
	1. Makes aggregations based on subject and activity (TAT_data_s5)
	2. Write the clean dataset to disk (TidyDataSet.txt)

## Cleaned Data

The resulting clean dataset is in this repository at: `TidyDataSet.txt`. It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.
