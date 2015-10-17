setwd("~/coursera/datasciencecoursera/courses/3.- Getting and Cleaning Data/project")
library(dplyr)

# Merging the training and the test sets to create one data set.
X_train <- read.table("data/train/X_train.txt")
X_train <- cbind(X_train, read.table("data/train/y_train.txt", 
                                     col.names = c('n_activity')))
X_test <- read.table("data/test/X_test.txt")
X_test <- cbind(X_test, read.table("data/test/y_test.txt",
                                   col.names = c('n_activity')))
X <- rbind(X_train, X_test)

#Using descriptive activity names to name the activities in the data set
activity_labels <- read.table("data/activity_labels.txt")
X <- merge(X, activity_labels, by.x = "n_activity", by.y="V1")
X <- select(X, -n_activity)

# Setting labels to data set with descriptive variable names. 
features_labels <- read.table("data/features.txt", stringsAsFactors=FALSE)[2]
features_labels <- rbind(features_labels, "activity")[,1]
colnames(X) <- features_labels
  
#Extracting only the measurements on the mean and standard deviation for each measurement. 
# those that contains mean(), std() + activity name column
selected_features = grep("(mean|std)\\(|act", features_labels)
X <- X[selected_features]

# Creating a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 
subject_test <- read.table("data/test/subject_test.txt", col.names = c('subject'))
subject_train <- read.table("data/train/subject_train.txt", col.names = c('subject'))
subject <- rbind(subject_test, subject_train)
averages <- aggregate(select(X, -activity), 
                      by = list(activity = X$activity, 
                                subject = subject[,1]), 
                      mean)

write.csv(averages, file='averages.txt', row.names=FALSE)



