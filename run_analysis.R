
#Download the file to data folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Dataset.zip")

#Unzip the file
if (!file.exists("UCI HAR Dataset")) { 
        unzip(zipfile="./Dataset.zip") 
}

#Merge the training and the test sets to create one data set
trainingSet <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

testSet  <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
testSubjects  <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testLabels  <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

allSet <- rbind(trainingSet, testSet)
allSubjects <- rbind(trainingSubjects, testSubjects)
colnames(allSubjects) <- c("subject")
allLabels <- rbind(trainingLabels, testLabels)
colnames(allLabels) <- c("activity")

#Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
features[,2] <- as.character(features[,2])

wantedMeasures <- grep(".*mean.*|.*std.*", features[,2])
wantedMeasures.names <- features[wantedMeasures,2]

allData <- allSet[, wantedMeasures]
colnames(allData) <- wantedMeasures.names
allData <- cbind(allData, allSubjects, allLabels)

#Use descriptive activity names to name the activities in the data set
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
activityLabels[,2] <- as.character(activityLabels[,2])

allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

#Appropriately label the data set with descriptive variable names
names(allData) <- gsub("^t", "time", names(allData))
names(allData) <- gsub("^f", "frequency", names(allData))
names(allData) <- gsub('-mean', 'Mean', names(allData))
names(allData) <- gsub('-std', 'Std', names(allData))
names(allData) <- gsub('[-()]', '', names(allData))

#Create a independent tidy data set with the average of each variable for each activity and each subject
library(plyr)
tidyData <- aggregate(. ~subject + activity, allData, mean)
tidyData <- tidyData[order(tidyData$subject,tidyData$activity),]

#write to file
write.table(tidyData, file = "tidydata.txt", row.name=FALSE, quote = FALSE)
