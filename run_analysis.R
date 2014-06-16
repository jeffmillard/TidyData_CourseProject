## =============================================================================
## Function:	run_analysis.R function()
## -----------------------------------------------------------------------------
## Assignment Requirements:
#
# 	Create one R script called run_analysis.R that does the following. 
# 		1. Merges the training and the test sets to create one data set.
# 		2. Extracts only the measurements on the mean and standard deviation 
#    		   for each measurement. 
# 		3. Uses descriptive activity names to name the activities in the 
#		   data set.
#		4. Appropriately labels the data set with descriptive activity names. 
#		5. Creates a second, independent tidy data set with the average of 
#		   each variable for each activity and each subject. 
##
## Description and Approach
#
#	Part 1: Merging the subject index, activity index, training and test sets. 
#			A. Read and merge data
#			B. I have chosen to save this combined data set, 
#			   even though this is not required for the assignment.
#
#	Part 2: 	Extracts measurements of mean and SD.
#			A. Subset to only subject, activity and data columns that are
#			   mean (column name contains "mean()") or standard deviation
#			   column name contains "std()").
#			B. Modify column names to provide appropriate column headings.
#
#	Part 3: Create tidy data set of averages and save as .txt file
#			A. Created tidyDF.txt as tab-delimited file
#
#
## Data Source Reference:  
#	Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
#	Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
#	Hardware-Friendly Support Vector Machine. International Workshop of 
#	Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#

run_analysis <- function() {

	## ========================================================================
	##  PART 1. Combining test and training data sets along with Subject ID,
	##		Activity Description, and providing appropriate column labels.
	## ========================================================================
	
	# need this for dcast.data.table
	library(data.table)
	library(reshape2)
	
	# -------------------------------------------------------------------------
	# Define the locations/names of the files we will use
	# -------------------------------------------------------------------------
	# My working directory containg the UCI HAR Dataset is datacleaning.  This 
	# line would need to change to match your directory structure
	setwd("~/TidyData_CourseProject")
	
	# directory for unzipped data files
	datadir <- "./UCI HAR Dataset"

	# test data set
	testx 	<- paste(datadir, "test/X_test.txt",       sep="/")
	testy  	<- paste(datadir, "test/y_test.txt",       sep="/")	
	testsubj	<- paste(datadir, "test/subject_test.txt", sep="/")

	# training data set
	trainx 	<- paste(datadir, "train/X_train.txt"      , sep="/")
	trainy  	<- paste(datadir, "train/y_train.txt"	 , sep="/")
	trainsubj	<- paste(datadir, "train/subject_train.txt", sep="/")

	# original feature names from original data authors
	featNames	<- paste(datadir, "./features.txt", sep="/")
	
	# When joining files, I am adopting the convention that test comes first, 
	# then train (test are top rows, train appended at bottom)

	# -------------------------------------------------------------------------
	# create first column (subjectid) from subject_test and subject_train files
	# -------------------------------------------------------------------------
	subjcomboDF <- rbind(read.csv(testsubj,  col.names = "subjectid",  header=FALSE),
				   read.csv(trainsubj, col.names = "subjectid",  header=FALSE))
	
	subjcomboDF[,1] <- as.factor(subjcomboDF[,1])
	# -------------------------------------------------------------------------
	# create second column (activity) from y_test and y_train files
	# -------------------------------------------------------------------------
	ycomboDF <- rbind(read.csv(testy,  col.names = "activity",  header=FALSE), 
				read.csv(trainy, col.names = "activity",  header=FALSE))

	# convert numeric activity IDs into descriptive factors
	activitylist <- c("Walking", "Walking up stairs", "Walking down stairs",
					 "Sitting", "Standing", "Laying")
	
	ycomboDF[,1] <- factor(ycomboDF[,1], labels=activitylist)

	# -------------------------------------------------------------------------
	# create 561 data columns x_test and x_train files
	# -------------------------------------------------------------------------
	xtestDF  <- read.table(testx,  header=FALSE)
	xtrainDF <- read.table(trainx, header=FALSE)
	xcomboDF <- rbind(xtestDF, xtrainDF)
	
	# do not modify names until after subsetting (much easier !!!)
	# space delimited file, read only 2nd column
	longlist <- read.table(featNames, sep=" ", header=FALSE)[,2]
		
	# add column names
	colnames(xcomboDF) <- longlist
	
	# combine everything into (tidy) complete data set 
	tempDF <- cbind(subjcomboDF, ycomboDF, xcomboDF)
	
	# save tidy complete data set (not required, but nice to have)
	write.table(tempDF, "./completeDF.txt", sep="\t")
	
	## ========================================================================
	##  PART 2. Creating Desired Tidy Data Subset
	## ========================================================================

	# -------------------------------------------------------------------------
	# Subsetting data to include only mean and standard deviation data
	# -------------------------------------------------------------------------
	# make a data table so we can use dcast.data.table
	
	tidyDF <- data.table(cbind(xcomboDF[c(grep("mean\\(\\)\\-", names(xcomboDF)), 
			                          grep("std\\(\\)\\-",  names(xcomboDF)))]))

	# -------------------------------------------------------------------------
	# modify column labels for remaining 50 data columns x_test and x_train files
	# ------------------------------------------------------------------------
	shortlist <- colnames(tidyDF)

	# remove ()- and other -
	shortlist <- gsub("mean\\(\\)\\-", "Mean", shortlist)
	shortlist <- gsub("std\\(\\)\\-", "StdDev", shortlist)
	shortlist <- gsub("\\-", "", shortlist)
	
	# indicate time or frequency data more clearly
	shortlist <- gsub("^t", "time", shortlist)
	shortlist <- gsub("^f", "frequency", shortlist)
	
	# change Acc to Accelerometer and Gyro to Gyroscope
	shortlist <- gsub("Acc", "Accelerometer", shortlist)
	shortlist <- gsub("Gyro", "Gyroscope", shortlist)	

	setnames(tidyDF, shortlist)
	
	tidyDT <- data.table(cbind(subjcomboDF, ycomboDF, tidyDF))
	# 
	## ========================================================================
	##  PART 3. Creating Desired Tidy Data Summary and Writing File
	## ========================================================================

	# -------------------------------------------------------------------------
	# average of means and standard deviations
	# -------------------------------------------------------------------------
	factorNames <- c("subjectid", "activity")
	
	# melt() to create one long list and cast to get means of mean and stddev
	# by subject ID and activity
	tidyMeltDT <- melt(tidyDT, id.vars=factorNames, measure.vars=shortlist)
	tidyOutDT <- dcast.data.table(tidyMeltDT, subjectid + activity ~ ..., fun=mean)
	
	# -------------------------------------------------------------------------
	# Output as a txt (tab-delimited) file
	# -------------------------------------------------------------------------
	write.table(tidyOutDT, file="tidyOut.txt", sep="\t")
	
}



