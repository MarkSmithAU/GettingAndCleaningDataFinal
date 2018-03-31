# Coursera Getting and Cleaning Data - Final Assignment
# By Mark Smith
# 
# Please see CodeBook.md and README.md in conjunction with this file.
#
# Process summary:
# Load all the data and metadata
# Combine the train* and test* objects into all* objects (Done in this order to avoid 
#  having to manipulate variable names twice.)
# Merge the all* objects into completeSet
# Filter the variables to only keep those required
# Use a set of replacement patterns (order is important to stop double processing) to quickly fix all
#  the Variable names
# Create summarySet with tidy data set with the average of each variable for each activity and each subject.
# Rename all the columns in summarySet with a postfix "Mean" to clearly indicate what they contain
# Write the resulting summarySet into results.txt (tab separated)
#
# To execute:
# unzip "UCI HAR Dataset.zip" into the same folder as the script and confirm the working directory is the same
## source("run_analysis.R")
## run_analysis()
# To read the results:
## library(dplyr)
## library(data.table)
## data = tbl_df(fread("results.txt"))
## summary(data)


# Load libraries
library(dplyr)
library(data.table)

# loadData
# function to import the data into an unfiltered tidy set.  This is a neatly reusable block.
loadData <- function() {
        # Read in all relevant files: 
        trainSubject <- tbl_df(fread("train/subject_train.txt"))
        trainX <- tbl_df(fread("train/X_train.txt"))
        trainY <- tbl_df(fread("train/Y_train.txt"))
        testSubject <- tbl_df(fread("test/subject_test.txt"))
        testX <- tbl_df(fread("test/X_test.txt"))
        testY <- tbl_df(fread("test/Y_test.txt"))
        activityLabels <- tbl_df(fread("activity_labels.txt"))
        features <- tbl_df(fread("features.txt"))
        
        # Combine the individual training and test files into combination sets
        allSubject <- bind_rows(trainSubject, testSubject)
        allX <- bind_rows(trainX, testX)
        allY <- bind_rows(trainY, testY)
        
        # tidy up the headers so we can join and maniupulate based on them
        names(allSubject) <- c("Subject")
        names(allY) <- c("ActivityID")
        names(activityLabels) <- c("ActivityID", "Activity")
        # Convert the activity numbers to text IDs
        activity <- left_join(allY, activityLabels, by="ActivityID")
        # Get and apply the vector names for the main data set
        names(allX) <- as.vector(unlist(features["V2"]))
        # Join it all together
        completeSet <- bind_cols(allSubject, activity["Activity"], allX)
        # Explicitly return the generated set 
        return(completeSet)
}

# run_analysis - main function
run_analysis <- function() {
        print("run_analysis() start.")
        
        # read in the data
        completeSet <- loadData()
        
        # Extract only the measurements on the mean and standard deviation for each measurement.
        # where mean() is Mean value and std() is Standard deviation
        # we also need to keep 
        fSet <- select(completeSet, matches("^Subject|^Activity|mean|std"))
        
        # Use descriptive activity names to name the activities in the data set
        # Appropriately labels the data set with descriptive variable names.
        toFix <- names(fSet)
        toFix <- gsub("Freq", "Frequency", toFix)
        toFix <- gsub("fBody", "FrequencyBody", toFix)
        toFix <- gsub("tBody", "TimeBody", toFix)
        toFix <- gsub("tGravity", "TimeGravity", toFix)
        toFix <- gsub("Gyro", "Gyroscope", toFix)
        toFix <- gsub("Acc", "Accelerometer", toFix)
        toFix <- gsub("Mag", "Magnitude", toFix)
        toFix <- gsub("std", "StandardDeviation", toFix)
        toFix <- gsub("mean", "Mean", toFix)
        toFix <- gsub("angle", "Angle", toFix)
        toFix <- gsub("gravity", "Gravity", toFix)
        toFix <- gsub("[(]|[)]|-|,", "", toFix)
        names(fSet) <- toFix
        
        # From the data set in the last step, create a second, independent tidy data set with the 
        # average of each variable for each activity and each subject.
        summarySet <- fSet %>% group_by(Subject, Activity) %>% summarise_all(funs(mean))
        names(summarySet) <- lapply(names(summarySet), 
                                    function(x) {
                                            if (length(grep(x, "^Subject|^Activity")) > 0) 
                                                x 
                                            else 
                                                paste(x, "Mean", sep = "")
                                        }
                                ) 
        
        # Save to file
        write.table(summarySet, file = "results.txt", append = FALSE,
               na = "", dec = ".", row.names = FALSE, col.names = TRUE)
        
        
        print("run_analysis() complete.")
}
