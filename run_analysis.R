
#---------------------------------------------------------------------------------------------------------------------------------
#If needed, set your working dir
#---------------------------------------------------------------------------------------------------------------------------------
setwd("c:/personal/Rprogramming")

#---------------------------------------------------------------------------------------------------------------------------------
#STEP #1: Merges the training and the test sets to create one data set.
#---------------------------------------------------------------------------------------------------------------------------------

#Load X_Train data
x_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
# assign row number as the values of ID column
x_train$ID <- as.numeric(rownames(x_train))

#Load Y_Train data
y_train <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE, col.names=c("activity_id"))
# assign row number as the values of ID column
y_train$ID <- as.numeric(rownames(y_train))

#Load SUbject_train data
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE, col.names=c("subject_id"))
# assign row number as the values of ID column
subject_train$ID <- as.numeric(rownames(subject_train))

#merge subject_train and Y_train
train <- merge(y_train, subject_train)
#merge the result with and X_train
train <- merge(x_train, train)


#Load X_Test data
x_test <- read.csv("UCI HAR Dataset/Test/X_Test.txt", sep="", header=FALSE)
# assign row number as the values of ID column
x_test$ID <- as.numeric(rownames(x_test))

#Load Y_Test data
y_test <- read.csv("UCI HAR Dataset/Test/Y_Test.txt", sep="", header=FALSE, col.names=c("activity_id"))
# assign row number as the values of ID column
y_test$ID <- as.numeric(rownames(y_test))

#Load SUbject_Test data
subject_test <- read.csv("UCI HAR Dataset/Test/subject_Test.txt", sep="", header=FALSE, col.names=c("subject_id"))
# assign row number as the values of ID column
subject_test$ID <- as.numeric(rownames(subject_test))


#merge subject_Test and Y_Test
test <- merge(y_test, subject_test)
#merge the result with and X_Test
test <- merge(x_test, test)


# Merge Training And Test (TATA) sets together
TAT_data_s1 <- rbind(train, test)

#---------------------------------------------------------------------------------------------------------------------------------
#STEP #2: Extracts only the measurements on the mean and standard deviation for each measurement.
#---------------------------------------------------------------------------------------------------------------------------------
# Read features dataset
features = read.csv("UCI HAR Dataset/features.txt", , col.names=c("feature_id", "feature_label"), sep="", header=FALSE)

# make some cleaning on names
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])

#select features we need
selected_features <- features[grep(".*Mean.*|.*Std.*", features[,2]),]
#and add ID Column at the beginning and the last two colums
TAT_data_s2 <- TAT_data_s1[, c(1, selected_features$feature_id + 1, 563, 564)]

#---------------------------------------------------------------------------------------------------------------------------------
#Step 3: Uses descriptive activity names to name the activities in the data set.
#---------------------------------------------------------------------------------------------------------------------------------
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id", "activity_label"),)
TAT_data_s3 <- merge(activity_labels, TAT_data_s2 )

#---------------------------------------------------------------------------------------------------------------------------------
#Step 4: Appropriately labels the data set with descriptive activity names.
#---------------------------------------------------------------------------------------------------------------------------------
TAT_data_s4 = TAT_data_s3

selected_features$feature_label <- gsub("\\(\\)", "", selected_features$feature_label)
selected_features$feature_label <- gsub("-", ".", selected_features$feature_label)
for (i in 1:length(selected_features$feature_label)) {
  colnames(TAT_data_s4)[i + 3] <- selected_features$feature_label[i]
}

#---------------------------------------------------------------------------------------------------------------------------------
#Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#---------------------------------------------------------------------------------------------------------------------------------
#drop useless columns
drops <- c("ID","activity_label")
TAT_data_s5 <- TAT_data_s4[,!(names(TAT_data_s4) %in% drops)]
aggdata = aggregate(TAT_data_s5, by=list(subject = TAT_data_s5$subject_id, activity = TAT_data_s5$activity_id), FUN=mean, na.rm=TRUE)

drops <- c("subject","activity")
aggdata <- aggdata[,!(names(aggdata) %in% drops)]
#merge activity labels
aggdata <- merge(activity_labels, aggdata)
#write final dataset
write.table(file="TidyDataSet.txt", x=aggdata, row.names = FALSE)


