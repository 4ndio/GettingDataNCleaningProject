library(reshape2) 
 
 # Load activity labels and features' labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt") 
 activityLabels[,2] <- as.character(activityLabels[,2]) 
 features <- read.table("UCI HAR Dataset/features.txt") 
 features[,2] <- as.character(features[,2]) 
 
 # Extract only the data on mean and standard deviation 
 featuresFiltered <- grep(".*mean.*|.*std.*", features[,2]) 
 
 # Obtaining descriptive variable names from existing Labels
 featuresFiltered.names <- features[featuresFiltered,2] 
 featuresFiltered.names = gsub('-mean', 'Mean', featuresFiltered.names) 
 featuresFiltered.names = gsub('-std', 'Std', featuresFiltered.names) 
 featuresFiltered.names <- gsub('[-()]', '', featuresFiltered.names) 
 

 

 # Load the datasets
 train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresFiltered] 
 trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt") 
 trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt") 

  # column bind Subjects, Activities with the measurements for Train set
 train <- cbind(trainSubjects, trainActivities, train) 
 
 test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresFiltered] 
 testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt") 
 
 # column bind Subjects, Activities with the measurements for Test set
 testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt") 
 test <- cbind(testSubjects, testActivities, test) 
 

 # merge datasets and add labels 
 allData <- rbind(train, test) 
 colnames(allData) <- c("subject", "activity", featuresWanted.names) 
 

 # turn activities & subjects into factors 
 allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2]) 
 allData$subject <- as.factor(allData$subject) 
 
 allData.melted <- melt(allData, id = c("subject", "activity")) 
 allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean) 
 

 write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE) 
