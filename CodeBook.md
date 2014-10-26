##CodeBook for TidyDataProject##

###Introduction###

This CodeBook accompanies the `run_analysis.R` script included in the TidyDataProject. The purpose of this project is to practice working with data sets to produce a "tidy" data set as output. 

The data set used in this project initially contained 561 measurements, distributed across several files, representing values obtained or derived from measurements recorded by the accelerometer and gyroscope built into the Samsung Galaxy S smartphone.

In the analysis and processing performed by the ***originators*** of this data, the raw accelerometer and gyroscope data was used to produce a number of measurements for a variety of variables in both the time domain, and the frequency domain. Many of these variables are resolved into X, Y, and Z components, thereby increasing the variable count three-fold. 

As all values included in the original data set had been previously "normalized and bounded" in the interval [-1, 1] (see note toward the end of the file "README.txt" that accompanies the data archive), all values used in this project are similarly bounded and unit-less.

Additional information concerning the original variables and their derivation can be found in the "README.txt" and "features_info.txt" that accompany the original data set. The link to the original data set is contained in the "README.md" file attached with this project.

###Methodology Overview###

*Note: A detailed explanation of the specific steps taken processing the data is available in the accompanying "README.md" file.*

The processing of the files used in this project primarily consists of assembling the data from the various files into a single comprehensive data frame, and then extracting a subset of that data frame to include only the variables of interest.

This comprehensive data frame consists of 10299 rows and 564 columns of data. Each row consists of a "subject_id", an "activity_id", an "activity_name", and 561 variable values.

As this project is only interested in those variables that represent a mean or standard deviation of a measured value, indicated by "mean()" or "std()" in the variable's name, all variable columns which do not contain one of those two strings are eliminated. Of course, the "subject_id" and "activity_name" columns are retained. Since the "activity_name" value is retained, the "activity_id" column is no longer needed, and is not retained. Following this reduction, the resulting data frame consists of 10299 rows and 68 columns.

In the final step, the data is collapsed so that each row represents the aggregated data for each unique combination of "subject_id" and "activity_name". The value of each variable column in the aggregated data is the mean value for the data for that variable and that particular combination of "subject_id" and "activity_name". This reduces the data frame to 180 rows and 68 columns. The column names in this final data frame are updated to reflect the fact that each value now represents the mean value for that variable.

###Variables###

The list of all variables in the original data is contained in the "features.txt" file that accompanies the original data. As there are over 560 variables, the list is not duplicated here.

The directory of variable names for the 68 variables in the output data set from this project script is shown below:

| Variable Name | Variable Name |
| :-------------|:------------------ |
| subject_id | activity_name || meanOf_tBodyAcc-mean()-X | meanOf_tBodyAcc-std()-X || meanOf_tBodyAcc-mean()-Y | meanOf_tBodyAcc-std()-Y || meanOf_tBodyAcc-mean()-Z | meanOf_tBodyAcc-std()-Z || meanOf_tGravityAcc-mean()-X | meanOf_tGravityAcc-std()-X || meanOf_tGravityAcc-mean()-Y | meanOf_tGravityAcc-std()-Y || meanOf_tGravityAcc-mean()-Z | meanOf_tGravityAcc-std()-Z || meanOf_tBodyAccJerk-mean()-X | meanOf_tBodyAccJerk-std()-X || meanOf_tBodyAccJerk-mean()-Y | meanOf_tBodyAccJerk-std()-Y || meanOf_tBodyAccJerk-mean()-Z | meanOf_tBodyAccJerk-std()-Z |
| meanOf_tBodyGyro-mean()-X | meanOf_tBodyGyro-std()-X || meanOf_tBodyGyro-mean()-Y | meanOf_tBodyGyro-std()-Y || meanOf_tBodyGyro-mean()-Z | meanOf_tBodyGyro-std()-Z || meanOf_tBodyGyroJerk-mean()-X | meanOf_tBodyGyroJerk-std()-X || meanOf_tBodyGyroJerk-mean()-Y | meanOf_tBodyGyroJerk-std()-Y || meanOf_tBodyGyroJerk-mean()-Z | meanOf_tBodyGyroJerk-std()-Z || meanOf_tBodyAccMag-mean() | meanOf_tBodyAccMag-std() || meanOf_tGravityAccMag-mean() | meanOf_tGravityAccMag-std() || meanOf_tBodyAccJerkMag-mean() | meanOf_tBodyAccJerkMag-std() || meanOf_tBodyGyroMag-mean() | meanOf_tBodyGyroMag-std() || meanOf_tBodyGyroJerkMag-mean() | meanOf_tBodyGyroJerkMag-std() || meanOf_fBodyAcc-mean()-X | meanOf_fBodyAcc-std()-X || meanOf_fBodyAcc-mean()-Y | meanOf_fBodyAcc-std()-Y || meanOf_fBodyAcc-mean()-Z | meanOf_fBodyAcc-std()-Z |
| meanOf_fBodyAccJerk-mean()-X | meanOf_fBodyAccJerk-std()-X || meanOf_fBodyAccJerk-mean()-Y | meanOf_fBodyAccJerk-std()-Y || meanOf_fBodyAccJerk-mean()-Z | meanOf_fBodyAccJerk-std()-Z || meanOf_fBodyGyro-mean()-X | meanOf_fBodyGyro-std()-X | | meanOf_fBodyGyro-mean()-Y | meanOf_fBodyGyro-std()-Y || meanOf_fBodyGyro-mean()-Z | meanOf_fBodyGyro-std()-Z | | meanOf_fBodyAccMag-mean() | meanOf_fBodyAccMag-std() || meanOf_fBodyBodyAccJerkMag-mean() | meanOf_fBodyBodyAccJerkMag-std() || meanOf_fBodyBodyGyroMag-mean() | meanOf_fBodyBodyGyroMag-std() | | meanOf_fBodyBodyGyroJerkMag-mean() | meanOf_fBodyBodyGyroJerkMag-std() |

####Variable Values####

| Variable Name| Value Range |
|:------------------------- |:-------------------|
|subject_id | [1, 30] |
|activity_name | LAYING, SITTING, STANDING, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS |
| All other variables | [-1, 1] |










