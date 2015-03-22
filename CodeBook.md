##CodeBook

This is the CodeBook for tidy dataset `tidyResult.txt` created using `run_analysis.R`.

####Variable Names & Descriptions:
* SubjectNumber - Numbers assigned to subject who performed the activity for each sample. The range is from 1 to 30.
* Activity - Names of six measured activities.
* Feature - Mean value (identified by"mean()") and standard deviation (identified by"std()") variables that were estimated from the feature measurements captured by the accelerometer and gyroscope 3-axial raw signals produced by the subjects during the activities. There are 66 feature mean value and standard deviation variables.
* AverageValue - The average of each variable for each activity and each subject.


####transformations or work performed to clean up the data
* Merged together the training and test datasets provided by the experiments.
* Appended subject and activity data to the feature vector datasets.
* Applied distinct names to variables.
* Subsetted the dataset to extract only the measurements on the mean and standard deviation for each measurement.
* Melted the dataset so that each row represent would represent one mean or standard deviation variable.
* Removed redundant and unnecessary data.
* Calculated the average of each variable for each activity and each subject.


####Structure of the Dataset
```r
> str(tidyResult)

Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':        11880 obs. of  4 variables:
 $ SubjectNumber: int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity     : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Feature      : Factor w/ 66 levels "fBodyAcc-mean()-X",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ AverageValue : num  -0.939 -0.867 -0.883 -0.924 -0.834 ...
 - attr(*, "vars")=List of 2
  ..$ : symbol SubjectNumber
  ..$ : symbol Activity
 - attr(*, "drop")= logi TRUE
```


####Variable Lists

Subject
```r
> unique(tidyResult$Subject)

[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
```

Activity
```r
> unique(tidyResult$Activity)

[1] LAYING            
[2] SITTING           
[3] STANDING          
[4] WALKING           
[5] WALKING_DOWNSTAIRS
[6] WALKING_UPSTAIRS  
6 Levels: LAYING ... WALKING_UPSTAIRS
```

Feature
```r
> unique(tidyResult$Feature)

 [1] fBodyAcc-mean()-X           fBodyAcc-mean()-Y           fBodyAcc-mean()-Z          
 [4] fBodyAcc-std()-X            fBodyAcc-std()-Y            fBodyAcc-std()-Z           
 [7] fBodyAccJerk-mean()-X       fBodyAccJerk-mean()-Y       fBodyAccJerk-mean()-Z      
[10] fBodyAccJerk-std()-X        fBodyAccJerk-std()-Y        fBodyAccJerk-std()-Z       
[13] fBodyAccMag-mean()          fBodyAccMag-std()           fBodyBodyAccJerkMag-mean() 
[16] fBodyBodyAccJerkMag-std()   fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std() 
[19] fBodyBodyGyroMag-mean()     fBodyBodyGyroMag-std()      fBodyGyro-mean()-X         
[22] fBodyGyro-mean()-Y          fBodyGyro-mean()-Z          fBodyGyro-std()-X          
[25] fBodyGyro-std()-Y           fBodyGyro-std()-Z           tBodyAcc-mean()-X          
[28] tBodyAcc-mean()-Y           tBodyAcc-mean()-Z           tBodyAcc-std()-X           
[31] tBodyAcc-std()-Y            tBodyAcc-std()-Z            tBodyAccJerk-mean()-X      
[34] tBodyAccJerk-mean()-Y       tBodyAccJerk-mean()-Z       tBodyAccJerk-std()-X       
[37] tBodyAccJerk-std()-Y        tBodyAccJerk-std()-Z        tBodyAccJerkMag-mean()     
[40] tBodyAccJerkMag-std()       tBodyAccMag-mean()          tBodyAccMag-std()          
[43] tBodyGyro-mean()-X          tBodyGyro-mean()-Y          tBodyGyro-mean()-Z         
[46] tBodyGyro-std()-X           tBodyGyro-std()-Y           tBodyGyro-std()-Z          
[49] tBodyGyroJerk-mean()-X      tBodyGyroJerk-mean()-Y      tBodyGyroJerk-mean()-Z     
[52] tBodyGyroJerk-std()-X       tBodyGyroJerk-std()-Y       tBodyGyroJerk-std()-Z      
[55] tBodyGyroJerkMag-mean()     tBodyGyroJerkMag-std()      tBodyGyroMag-mean()        
[58] tBodyGyroMag-std()          tGravityAcc-mean()-X        tGravityAcc-mean()-Y       
[61] tGravityAcc-mean()-Z        tGravityAcc-std()-X         tGravityAcc-std()-Y        
[64] tGravityAcc-std()-Z         tGravityAccMag-mean()       tGravityAccMag-std()       
66 Levels: fBodyAcc-mean()-X fBodyAcc-mean()-Y fBodyAcc-mean()-Z ... tGravityAccMag-std()
```
