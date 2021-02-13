##loading required packages
library(dplyr)
library(data.table)

##setting working directory, you should change this
setwd("C:/Users/Hriday/Documents/R/win-library/4.0/project_gettdata/projectdata_c")

#downloading data
urlproject <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
downloaddata <- download.file(urlproject,"projectdata.zip",method = "curl")
unzip("projectdata.zip",list = TRUE)

## reading data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#section 1: merged datasets 
subject_data <- rbind(subject_train,subject_test)
x_data <- rbind(x_test,x_train)
y_data <- rbind(y_test,y_train)
MergedData <- cbind(x_data,y_data,subject_data)

#section 2: extracted only the measuremnets on the mean and standard deviation  
TidyData <- MergedData %>% select(subject, code, contains("mean"), contains("std"))

# section 3: use descriptive names to label the activities
TidyData$code <- activities[TidyData$code, 2]

#section 4: label the data set with descriptive names
names(TidyData)[2] <- "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# section 5: create a second tidy variable with the average of each variable for each activity and subject
FinalData <- TidyData %>% group_by(subject,activity) %>%
                            summarise_all(lst(mean))
write.table(FinalData, "FinalData.txt",row.names = FALSE)

## looking at final data
View(FinalData)