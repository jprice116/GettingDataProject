## Assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example <a href="http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/">this article</a>. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!


## Solution

Create a script called run_analysis.R:  

###Step 1
Load data.table and reshape2 packages.  Download the data and unzip the files.  Read the data into R using fread.  *I used read.table with data.table to read in the X_train and X_test files because fread would not work on these two files.*  Merge the training and the test sets to create one data set named HarData **(Requirement #1)**.

###Step 2
Using setnames, apply distinct names to variables **(Requirement 4)**.

###Step 3
Merge HarData with the Subject and Activity data.  Subset only the measurements on the mean and standard deviation from Features.  *I extracted only the features that explicitly contained “mean()” and std()” resulting in a subset of 66.  I intentionally excluded other mean instances (e.g. fBodyBodyAccJerkMag-meanFreq(), angle(X,gravityMean)) because these are not mean calculations on the original measurements.*  Extract only the measurements on the mean and standard deviation for each measurement in HarData **(Requirement 2)** by merging HarData with the subset from Features.

###Step 4
Using merge, append activity names to data **(Requirement 3)**.  Melt HarData so that each row represents one observation.  Using merge, append feature names to HarData.

###Step 5
Load dplyr package.  Make HarData into data frame tbl.  Clear out unnecessary variables and columns.  Create a second, independent tidy data set tidyResult with the average of each variable for each activity and each subject **(Requirement 5)** using group_by and summarize.  Write the tidyResult to a txt file.

