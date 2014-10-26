README.md

This project processes data related to a study concerning the use of "wearable computing" devices. Specifically, the data used in this project was collected from accelerometers built into the Samsung Galaxy S smartphone. (See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more information concerning this study.)

Execution:

This project consists of a single R script, 'run_analysis.R'. This script can be sourced into the R app and executed without additional input from the user.

Libraries:

The script attempts to load the 'plyr' library. Therefore, the 'plyr' package should be installed in the local version of R prior to using this script. Note that attempting to load 'plyr' after 'dplyr' is already loaded will generate a warning. Should this occur, remove the 'dplyr' library from the current R environment and then load 'plyr' first before reloading 'dplyr' if needed.

Data Source:

The data used for this project can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This zipped archive file must then be unzipped to obtain the "UCI HAR Dataset" folder. This folder and its contents should be placed in the current R working directory. Alternatively, the user may set the current working directory in R to be the "UCI HAR Dataset" folder.

Input Files:

The "UCI HAR Dataset" folder should contain the following files and folders:

	train -- sub-folder containing the following files:
		X_train.txt
		y_train.txt
		subject_train.txt
			
	test -- subfolder containing the following files:
		X_test.txt
		y_test.txt
		subject_test.txt
			
	activity_labels.txt

	features.txt

Other files in the "UCI HAR Dataset" folder, including the contents of the "Inertial Signals" subfolders in the /train and /test folders, are not used in this project.

Methodology:

The script performs the following tasks:

1. Reads each of the above-mentioned text files into individual data frames:
	
|Filename              |––>|Data Frame|
|:-----------------------|:----------:|:----------|
|X_train.txt            |                 |x_train|
|y_train.txt             |                 |y_train|
|subject_train.txt  |                 |subject_train|
|X_test.txt              |                 |x_test|
|y_test.txt               |                 |y_test|
|subject_test.txt    |                 |subject_test|
|activity_labels.txt|                 |activity_labels|
|features.txt            |                 |features|
	
2. Adds descriptive names "activity_id" and "activity_name" to the columns in the "activity_labels" data frame.
	
3. Extracts the second column of the "features" data frame as a vector to use for labelling the measured data columns (See step 5 below.)
	
4. Combines corresponding "test" and "train" data frames into "combined" data frames using rbind( ):
	
			Individual data frames				Combined data frame
			x_test, x_train				x_combined
			y_test, y_train				y_combined
			subject_test, subject_train				subject_combined
			
	Note: Because these pieces will be joined together in subsequent steps to form one single data frame, the order of the "test" and "train" data frames must be consistent for all three rbind( ) operations.
			
5. Adds descriptive column names to the "x_combined" data frame, using the vector of labels from step 3 above.
	
6. Adds column name to the "y_combined" data frame
	
7. Adds column name to the "subject_combined" data frame
	
8. Combines "subject_combined" and "y_combined" data frames, forming "subject_y_combined" data frame
	
9. Use the join() operation from the 'plyr' library to add the activity names to the "subject_y_combined" data frame, using the "activity_labels" data frame as a lookup table. A new data frame, "subject_y_activity_combined", is created.

10. Combine the "subject_y_activity_combined" and "x_combined" data frames using cbind( ). This creates the "data" data frame, which contains all of the data from the various text files combined into a single data frame.

11. Reorder the combined data by "subject_id" and "activity_id"	. While not strictly necessary, this step makes it easier to scan the resulting data frame to ensure the all 30 subjects have been included as intended.
	
12. Use the grepl() function to create a logical vector identifying columns to extract from the combined data frame. Of interest are the "subject_id" and "activity_name" fields, and any measured variable that includes "mean" or "std" in the name, excluding those with "meanFreq". The latter are excluded because they do not appear to represent a mean of a measured value for the purposes of this project. See the file "features_info.txt" in the original "UCI HAR Dataset" folder for additional information about the variables used in the original data set.

13. Subset the "data" data frame by extracting only those columns that were identified in the preceding step. The results are sent back to "data", thereby replacing the previous combined version of "data".

14. Use the ddply() function from the "plyr" library to collapse the data into unique combinations of "subject_id" and "activity_name", and compute the mean value for each of the 66 variables for each combination. The result are kept in a new data frame, "finaldata".
	
15. Write the "finaldata" data frame out to a text file in the current working directory named "tidydata.txt". Note that any existing file in the current working directory having the same name will be overwritten. Future versions of this script could include testing to check for the existence of a file with that name prior to writing, and providing appropriate messaging in cases where a file might be overwritten. 
	
Output:

The script writes out the final result to a text file named "tidydata.txt", which is written to the current working directory. This file can be read back into R with the following instruction:

data\_frame\_name <- read.table("tidydata.txt", header = FALSE)

Notes:

The data set produced by this script is a relatively "wide" data set, consisting of 180 rows (one for each combination of "subject\_id" and "activity\_label"), with each row containing the corresponding mean values for 66 different measured variables. Additional processing could render this data into a "tall" data set by converting the 66 variable names into a "feature" variable and using the existing column names as factor levels for the new variable. By "melting" and "casting" this data frame, a new data frame could be created that included columns for only "subject\_id", "activity\_name", "feature", "mean", and "std". The resulting data frame would then be only 5 columns wide. However, instead of the current 180 rows, the new data frame would consist of 180 * 33 = 5940 rows. (The 33 comes from the fact that each variable is part of mean/std pair. Each pair of values would be on its own line in the reshaped data, so there would be 33 lines for each combination of "subject\_id" and "activity\_name".)

At the present time, there is no discernable benefit to reshaping the data into that particular form. While the data frame is not necessarily intended for human viewing, in its current form it is easy to see that each row of the data consists of a set of measurements that are related to one particular subject/activity combination. Separating out each individual measurement for its own line would make it more difficult to see this grouping.

Should a need arise where such reshaping is believed to be beneficial, one could start with the "data" data frame produced in step 13 of this script.
