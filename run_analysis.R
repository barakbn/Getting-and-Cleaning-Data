run_analysis <- function() {
  
  library(dplyr)
  library(reshape2)
  
  # reading the data files

  features <- read.csv("./UCI HAR Dataset/features.txt", sep=" ", header=FALSE)
  
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", as.is=TRUE,check.names=FALSE, col.names = t(features[,2]))
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = c("Activity"))
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject"))
  
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", as.is=TRUE, check.names=FALSE, col.names = t(features[,2]))
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = c("Activity"))
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))
  
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("Activity", "Activity Type"))

  # adding the subject column to the test and training data
  
  x_train_with_subject <-cbind(y_train,subject_train, x_train)
  x_test_with_subject <-cbind(y_test,subject_test, x_test)
  
  # adding the activity columns to the test and training data (to name the activities in the data set)
  
  full_descrtion_train <-merge (activity_labels, x_train_with_subject)
  full_descrtion_test <-merge (activity_labels,  x_test_with_subject)
    
  # combining the test and training data sets to create one data set.
  
  combinedDataSet <- rbind(full_descrtion_test, full_descrtion_train)
  
  # Extracting the measurements on the mean and standard deviation for each measurement 
  
  listOfFeatures <- t(features[1:265,2])
  
  meanAndStdColumns<-c("Activity.Type", "Subject", grep("-mean()-",listOfFeatures, fixed=TRUE, value=TRUE), grep("-std()-",listOfFeatures, fixed=TRUE, value=TRUE))
  
  meanAndStdColOfDataSet<-combinedDataSet[,meanAndStdColumns]
  
  # creating a dataset with the average of each variable for each activity and each subject. 
  
  meanAndStdColOfDataSet <-group_by(meanAndStdColOfDataSet, Activity.Type,Subject)
  
  averagedvariablesOfActivityAndSubject <- summarise_each(meanAndStdColOfDataSet, funs(mean))
  
  # preparing the sorted tidy set
  
  tidySet<-melt(averagedvariablesOfActivityAndSubject, id=c("Activity.Type", "Subject")) %>% dplyr::rename (Measure=variable, Average.Value = value) %>%  arrange (Subject)
  
  tidySet$Direction <- lapply(strsplit(as.character(tidySet$Measure), "\\-"), "[", 3)
  
  tidySet$Variable.Type <- lapply(strsplit(as.character(tidySet$Measure), "\\-"), "[", 2)
  
  tidySet$Measure <- lapply(strsplit(as.character(tidySet$Measure), "\\-"), "[", 1)
  
  tidySet<- select(tidySet, c(Subject,Measure, Variable.Type, Direction, Activity.Type, Average.Value))
  
  tidySet
  
  # writing tidy set to file
    
  # tidySetForFile <- as.matrix(tidySet)
  
  # write.table(tidySetForFile, file = "tidySet.txt", row.name=FALSE)
  
}