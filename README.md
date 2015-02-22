# Getting-and-Cleaning-Data
A repository for the submission of course project in Coursera's "Getting and Cleaning Data"

How The script works
====================

The script "run_analysis.R" assumes that the data zip file have been downloaded and that the
the working directory, and that the data files were extracted to the directory "UCI HAR Dataset" 
(under the working directory.

The output of the file is the tidy set, and therefore it is recommended to assign the results of 
the run_analysis() function call to a variable.

You'll find comments in the script code describing the different stages of the processing.
At the end of the script there's the code used to write the tidy set to file (however, it is 
commented out).

The Code Book
=============

The instructions given for the creation of the tidy data set said:
"Extracts only the measurements on the mean and standard deviation for each measurement."
I took that to exclude calculated values (e.g. tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, 
tBodyGyroMag, tBodyGyroJerkMag) and values taken in a different measurement technique 
(gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean,tBodyGyroJerkMean).

According to the tidy data principle that "each variable forms a column", I decided to separate 
each feature to 3 parts (each with its own column): the measurement(e.g. tBodyGyro), 
the relevant variable type (e.g. mean(): Mean value / std(): Standard deviation) 
and the direction (x/y/z). 

The values presented  in the column "Average.Value" were obtained from the raw-data tables by averaging 
the relevant measurement ("Variable.Type"+"Direction"+"Activity.Type") per subject and activity type. 
I.e. each value in the column indicates the average of a certain given measurement values of a certain 
subject in a certain activity.

some information regarding the experimental study design used:
"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
using another low pass Butterworth filter with a corner frequency of 0.3 Hz...

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ)."

