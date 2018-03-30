---
title: "CodeBook.md"
author: "Mark Smith"
date: "30 March 2018"
output: html_document
---

## Source Data
The source data is originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After examining the data and requirements I decided that the raw data under the "Inertial Signals" folders should be excluded as the requirements did not specify its inclusion, although it could be added easily if required.  The following are the remaining relevant data files:

| Source File             | Details                                                       |
| ----------------------- | ------------------------------------------------------------- |
| train/subject_train.txt | The Subject number for each observation (training set)        |
| train/X_train.txt       | The variables for the observations (training set)             |
| train/Y_train.txt       | The activity identifier (training set)                        |
| test/subject_test.txt   | The Subject number for each observation (test set)            |
| test/X_test.txt         | The variables for the observations (test set)                 |
| test/Y_test.txt         | The activity identifier (test set)                            |
| activity_labels.txt     | The activity descriptions for the data in the Y_???.txt files |
| features.txt            | The feature labels for each Variable in the X_???.txt files   |

## Codebook (Processing Steps)

The overall process taken to process trhe orignal data set is:

* Load all the data and metadata.
* Combine the train(X/Y) and test(X/Y) data objects into all(X/Y) objects (It was done in this order to avoid having to manipulate variable names twice.)
* Merge the all(X/Y), activity and feature objects into completeSet (which is unfiltered).
* Filter the variables to only keep those required.
* Use a set of replacement patterns (order is important to stop double processing) to quickly fix all the Variable names.
* Create summarySet tidy data set with the average of each variable for each activity and each subject.
* Rename all the columns in summarySet with a postfix "Mean" to clearly indicate what they contain.
* Write the resulting summarySet into results.txt (tab separated).

The result satisfies the tidy data rules:

1. Each variable forms a column: The subject, the Activty Description and the processed mean values.
2. Each observation forms a row: These are taken from the original layout and kept in wide format, although narrow could have been used.  
3. Each type of observational unit forms a table: This is satisfied, the data here is all related and can't be normalised further.


## CodeBook (Variables)

The following should be read in conjunction with "README.txt" from the original data set referred to above.

* 	Subject	: Subject number [1 to 30], integer
* 	Activity	: Activity identifier [LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS], text
* 	TimeBodyAccelerometerMeanXMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerMeanYMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerMeanZMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerMeanXMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerMeanYMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerMeanZMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkMeanXMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkMeanYMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkMeanZMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeMeanXMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeMeanYMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeMeanZMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkMeanXMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkMeanYMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkMeanZMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	TimeGravityAccelerometerMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	TimeBodyAccelerometerJerkMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	TimeBodyGyroscopeJerkMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMeanXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMeanYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMeanZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMeanFrequencyXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMeanFrequencyYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMeanFrequencyZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkMeanXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkMeanYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkMeanZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkMeanFrequencyXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkMeanFrequencyYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerJerkMeanFrequencyZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeMeanXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeMeanYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeMeanZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeStandardDeviationXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeStandardDeviationYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeStandardDeviationZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeMeanFrequencyXMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeMeanFrequencyYMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyGyroscopeMeanFrequencyZMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyAccelerometerMagnitudeMeanFrequencyMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyAccelerometerJerkMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyAccelerometerJerkMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyAccelerometerJerkMagnitudeMeanFrequencyMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyGyroscopeMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyGyroscopeMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyGyroscopeMagnitudeMeanFrequencyMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyGyroscopeJerkMagnitudeMeanMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyGyroscopeJerkMagnitudeStandardDeviationMean	: range [-1 to 1], floating point number 
* 	FrequencyBodyBodyGyroscopeJerkMagnitudeMeanFrequencyMean	: range [-1 to 1], floating point number 
* 	AngleTimeBodyAccelerometerMeanGravityMean	: range [-1 to 1], floating point number 
* 	AngleTimeBodyAccelerometerJerkMeanGravityMeanMean	: range [-1 to 1], floating point number 
* 	AngleTimeBodyGyroscopeMeanGravityMeanMean	: range [-1 to 1], floating point number 
* 	AngleTimeBodyGyroscopeJerkMeanGravityMeanMean	: range [-1 to 1], floating point number 
* 	AngleXGravityMeanMean	: range [-1 to 1], floating point number 
* 	AngleYGravityMeanMean	: range [-1 to 1], floating point number 
* 	AngleZGravityMeanMean	: range [-1 to 1], floating point number 

