README for Tidy Dataset - Human Activity Recognition Using Smartphones
=================================================================================

### Project Instructions
>"You should create one R script called run_analysis.R that does the following. 
>
>    Merges the training and the test sets to create one data set.
>    Extracts only the measurements on the mean and standard deviation for each measurement. 
>    Uses descriptive activity names to name the activities in the data set
>    Appropriately labels the data set with descriptive activity names. 
>    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. "

### Detailed Description of Original Study Data

The original study had 30 test subjects, who engaged in 6 activities: Walking, Walking up stairs, Walking down stairs, Sitting, Standing, Laying.  Note, the original researchers named the 2nd and 3rd activities as "WALKING UPSTAIRS" and "WALKING DOWNSTAIRS".  I have interpreted that as walking up or down the stairs, respectively, and not simply walking on different floors of a building.

The subjects had Samsung Galaxy SII smartphones on their waists. 3-axial linear acceleration and 3-axial angular velocity were recorded at a constant rate of 50Hz.

The original data set contained numerous measured and derived data based on the sensor (3D accelerometer and gyroscope) measurements.  Raw (unprocessed) data were included in the zip archive, but only the processed data were used in this analysis.

Data were randomly divided by subject into training and testing data.  For the "tidy data" analysis described herein, the training and testing data were combined into a single file.

In the original study, data were generated or derived according to:

1. Type of data (time domain, frequency domain, vector angle).  Since all of the raw measurements were made in the time domain, frequency was calculated by FFT (Fast Fourier Transform) and angle was calculated by vector transformation of the 3D accelerometer and gyroscope data.

2. Type of sensor (time and frequency domain only).  There were 2 sensor types: Accelerometer and Gyroscope.

3. Type of acceleration (body motion or gravity).

4. Axis of measurement (Cartesian axes X, Y, Z)

5. Type of analysis applied to the data (excerpted from the original study documentation:

	* mean():	 	Mean value
	* std(): 		Standard deviation
	* mad(): 		Median absolute deviation 
	* max(): 		Largest value in array
	* min(): 		Smallest value in array
	* sma(): 		Signal magnitude area
	* energy(): 	Energy measure. Sum of the squares divided by the number of values. 
	* iqr(): 		Interquartile range 
	* entropy(): 	Signal entropy
	* correlation(): 	Correlation coefficient between two signals
	* maxInds(): 	Index of the frequency component with largest magnitude
	* meanFreq(): 	Weighted average of the frequency components to obtain a mean
				frequency
	* skewness(): 	skewness of the frequency domain signal 
	* kurtosis(): 	kurtosis of the frequency domain signal 

These analyses had more than one coefficient/result

*	arCoeff(): 		Autorregresion coefficients with Burg order equal to 4 (e.g. 
				coefficients 1-4)
*	bandsEnergy(): 	Energy of a frequency interval within the 64 bins of the FFT 
				of each window.

This analysis specified 2 arguments; the two vectors:
*	angle(): 		Angle between two vectors.

See the documention provided with the data set for additional detail.

### Data Processing Steps Performed in this Study

#### Part 1: Merging the subject index, activity index, training and test sets. 
	A. Read and merge data
		1. Read and combine (rbind) test and train subject IDs into one column named "subjectid". Convert to a factor.
		2. Read and combine (rbind) test and train activity IDs into another column named "activityid".  Convert to a factor. Convert integer activity ids to their descriptive names.
		3. Read and combine (rbind) test and train numeric data.  There are 561 columns (features) in this data.
		4. Read the feature names from file and make these names the titles of the numeric columns.
		
	B. Save merged data. I have chosen to save this combined data set, even though this is not required for the assignment.

#### Part 2: Extracts measurements of mean and SD.
	A. Subset to only subject, activity and data columns that are mean (column name contains "mean()") or standard deviation column name contains "std()").
	B. Modify column names to provide appropriate column headings.

#### Part 3: Create tidy data set of averages and save as .txt file
	A. 
	B. Created tidyDF.txt as tab-delimited file

### Details of computing platform
platform       x86_64-apple-darwin10.8.0   
arch           x86_64                      
os             darwin10.8.0                
system         x86_64, darwin10.8.0        
status                                     
major          3                           
minor          0.3                         
year           2014                        
month          03                          
day            06                          
svn rev        65126                       
language       R                           
version.string R version 3.0.3 (2014-03-06)
nickname       Warm Puppy                  
