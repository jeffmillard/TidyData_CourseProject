Code Book for Tidy Dataset - Human Activity Recognition Using Smartphones
========================================================
Version 1.0

Jeffrey R. Millard

May 2014

Study Design
-------------------------------------------------------
The objective of this data analysis (the "present study") was to present a "tidy" summary of data previously obtained by other researchers (the "original study") for human activity recognition using smartphone accelerometer and gyroscopic measurements.

This tidy summary is generated in the R script called "run_analysis.R", which does the following. 

    1. Merges the original study training and the test sets to create one data set.
    2. Subsets the  original study to __only__ the measurements on the mean and standard deviation for each measurement. 
    3. Replaces the activity IDs (1 through 6) with corresponding names (e.g., "Walking")
    4. Labels the columns of the original data set with descriptive names (e.g., "timeBodyAccelerometerMeanX" to donate the mean on the x axis of the time domain data for body motion recorded by the accelerometer). 
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Original Data
The reference for the original study is:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The data files were downloaded as a zip archive from the URL: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

in May of 2014. This zip file is included in the code repository.  See README.md for details regarding the code repository contents and the contents of the original study data zip archive.

The original study had 30 test subjects, who engaged in 6 activities: Walking, Walking up stairs, Walking down stairs, Sitting, Standing, Laying.  Note, the original researchers named the 2nd and 3rd activities as "WALKING UPSTAIRS" and "WALKING DOWNSTAIRS".  For the present study, I have interpreted that as walking up or down the stairs, respectively, and not simply walking on different floors of a building.

The original study subjects had Samsung Galaxy SII smartphones on their waists. 3-axial linear acceleration and 3-axial angular velocity were recorded at a constant rate of 50Hz.  Thus, the original study data were recorded in the time domain.

The columns of the original study, merged into a single data set but no other processing, can be summarized as follows:

Column(s)     | Description        | Class/Type   | Range     | Units
------------- | ------------------ | ------------ | --------- | ----------------
1             | Subject ID         | Integer      | 1 to 30   | none, index
2             | Activity ID        | Integer      | 1 to 6    | none, index
3-563         | Measurement Data   | Numeric      | -1 to 1   | none, normalized to +/-1

* Subject ID came from files labeled "subject"
* Activity ID came from files labeled "y"
* Measurement Data came from files labeled "X"

In the run_analysis.R script, Activity ID integers were replaced with description names and converted to factors, and the entire combined data set was given descriptive column names, resulting in:

Column(s)     | Column Name        | Class/Type           | Range      | Units
------------- | ------------------ | -------------------- | ---------- | ----------------
1             | subjectid          | Integer Factor       | 1 to 30    | none, index
2             | activityid         | Character Factor     | see note 1 | none, index
3-563         | see note 2         | Numeric              | -1 to 1    | none, normalized to +/-1

1. Note 1: activityid was one of "Walking, Walking up stairs, Walking down stairs, Sitting, Standing, Laying".
2. Note 2: Due to length of this list, it has been presented at the end of this file.

### Description of Present Study
In the present study, only mean and standard deviation data from the original study were considered. What was meant in particular by "mean data" was open to interpretation.  My chosen list of this subset is included below, in "Code Book".


Code Book
-------------------------------------------


Column(s)     | Description        | Class/Type       | Range     | Units
------------- | ------------------ | ---------------- | --------- | ----------------
1             | Subject ID         | Integer          | 1 to 30   | none, index
2             | Activity ID        | Factor           | see lis   | none, index
3-50          | Mean/SD Data       | Numeric          | -1 to 1   | none, normalized to +/-1

In selecting the data to include in the tidy data set, columns of the original data that had the "mean()" or "std()" designation were used.  Note, this is not all columns where the name included the word "mean", but it was my opinion that only the ones with mean() and std() should be included.

####Data Source Reference:  

	Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
	Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
	Hardware-Friendly Support Vector Machine. International Workshop of 
	Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012



