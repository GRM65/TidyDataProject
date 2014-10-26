# run_analysis.R

# Load 'plyr' library
library(plyr)

# Get 'training' data files from the current working directory
x_train <- read.table("./train/X_train.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
subject_train <- read.table("./train/subject_train.txt", header = FALSE)

# Get 'test' data files from current working directory
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)
subject_test <- read.table("./test/subject_test.txt", header = FALSE)

# Get 'activity labels' file from current working directory
activity_labels <- read.table("./activity_labels.txt", header = FALSE)

# Get 'features' file from current working directory
features <- read.table("./features.txt", header = FALSE)

# Add column names to 'activity_labels" data frame
colnames(activity_labels) <- c("activity_id", "activity_name")

# Extract vector of feature labels to be used for column names
features_labels <- as.vector(features[[2]])

# Combine the "test" and "train" data frames for "x", "y", and "subject" data
x_combined <- rbind(x_test, x_train)
y_combined <- rbind(y_test, y_train)
subject_combined <- rbind(subject_test, subject_train)

# Add column names to the combined data frames
colnames(x_combined) <- c(features_labels)
colnames(y_combined) <- "activity_id"
colnames(subject_combined) <- "subject_id"

# Combine subject_combined and y_combined data frames
subject_y_combined <- cbind(subject_combined, y_combined)

# Use join() from "plyr" library to add the activity names to the "subject_y_combined"
# data frame, using "activity_labels" data frame as a lookup table
subject_y_activity_combined <- join(subject_y_combined, activity_labels)

# Combine subject_y_activity_combined data frame with the x_combined data frome
# This results in the complete combined data frame, named "data"
data <- cbind(subject_y_activity_combined, x_combined)

# Reorder "data" by subject_id and activity_id
data <- data[order(data$subject_id, data$activity_id), ]

# Keep only columns containing the subject_id, activity_name, and any measurement
# that is a mean or a standard deviation
cols_to_keep <- grepl("subject_id|activity_name|mean|std", names(data)) & !grepl("meanFreq", names(data))

# Subset the data, keeping only those columns identifed in previous instruction
data <- data[ , cols_to_keep]

# Create separate data frame with the mean of each measurement, for each combination of 
# subject_id and activity_name
finaldata <- ddply(data, .(subject_id, activity_name), numcolwise(mean))

# Modify column names in 'finaldata' data frame to reflect the change in values to means
# of the variables
finaldata_names <- names(finaldata)
finaldata_names <- sub("^t", "meanOf_t", finaldata_names)
finaldata_names <- sub("^f", "meanOf_f", finaldata_names)
colnames(finaldata) <- c(finaldata_names)

# Write finaldata data frame to file
write.table(finaldata, "tidydata.txt", row.names = FALSE)
