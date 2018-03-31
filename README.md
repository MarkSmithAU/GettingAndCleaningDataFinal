---
title: "README.md"
author: "Mark Smith"
date: "30 March 2018"
output: html_document
---

# Coursera Getting and Cleaning Data - Final Assignment

The script provided has two purposes:

* To produce a tidy data set (internally);
* Take selected values (means and standard deviations) from the tidy set and take the average of them; and
* Write the result to results.txt (tab separated).

This was developed on R 3.4.3 on Windows x64.

# Requirements

* Have the downloaded data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (or the original source) extracted in the same directory as run_analysis.R.
* Have dplyr and data.table libraries installed in R.
* Sufficient permissions to write results.txt to the working directory.

## How to run
```{r}
source("run_analysis.R")
run_analysis()
```

## To read the results:
```{r}
library(dplyr)
library(data.table)
data <- tbl_df(fread("results.txt"))
summary(data)
```

## Files
* README.md
This file
* CodeBook.md
The codebook describing the variables and the conversion process to generate the results.
* run_analysis.R
The main program.
* results.txt
Generated by the main program's final step.
