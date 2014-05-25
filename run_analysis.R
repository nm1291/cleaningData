library(reshape2)

## Load the data sets and parse them
## with the function scan
set_train <- scan("./train/X_train.txt", character(0), sep = " ")
set_test <- scan("./test/X_test.txt", character(0), sep = " ")
label_train <- scan("./train/y_train.txt", character(0), sep = " ")
label_test <- scan("./test/y_test.txt", character(0), sep = " ")
subject_train <- scan("./train/subject_train.txt", character(0), sep = " ")
subject_test <- scan("./test/subject_test.txt", character(0), sep = " ")
features <- scan("features.txt", character(0), sep = " ")
activity_labels <- scan("activity_labels.txt", character(0), sep = " ")

## Remove the characters "" from the sets
set_train <- set_train[!is.element(set_train, "")]
set_test <- set_test[!is.element(set_test, "")]

## Get a frame from the vector sets (representation of the 561 features)
set_train_frame <- matrix(as.numeric(set_train), ncol = 561)
set_test_frame <- matrix(as.numeric(set_test), ncol = 561)

set_train_frame <- data.frame(set_train_frame)
set_test_frame <- data.frame(set_test_frame)

## Get a matrix with the activity labels
activity_labels <- matrix(activity_labels, nrow = 2)

## Merging the training and test set (first question ?!)
set <- rbind(set_train_frame, set_test_frame)

## Merging the two labels
label <- c(as.numeric(label_train),as.numeric(label_test))

## Feature vector
features <- matrix(features, nrow = 2)
features <- features[-1,] # Keeps only the names of the features

## Giving names to columns
colnames(set) <- features

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
## Initializing the new set
set_extract <- data.frame(set[,1])
colnames(set_extract)[1] <- features[1]
## Removing the non related columns using grepl
for (i in 2:561){
  if ((grepl("-mean()",features[i]) || grepl("-std()",features[i])) && !grepl("-meanFreq()",features[i])){
    set_extract <- cbind(set_extract,set[,i])
  }
}

## Same for the features
features_extract <- features[1]
for (i in 2:561){
  if ((grepl("-mean()",features[i]) || grepl("-std()",features[i])) && !grepl("-meanFreq()",features[i])){
    features_extract <- c(features_extract,features[i])
  }
}

# Name the columns
colnames(set_extract) <- features_extract

## Creating a vector of the label with proper activity name
label_name <- label

for (i in 1:6){
  label_name[label_name == as.numeric(activity_labels[1,i])] <- activity_labels[2,i]
}

# Create a frame with the label vector
label_name_frame <- data.frame(label_name)
colnames(label_name_frame) <- "Activity"

# Merge the set and the label to have the first final tidy data set
final_data_1 <- cbind(set_extract, label_name_frame)
if (!file.exists("final_data_1.txt")){
  write.table(final_data_1, "final_data_1.txt", sep="\t")
}


### Second data set

## Merge the two "subject" vector
subject <- c(as.numeric(subject_train),as.numeric(subject_test))
subject <- data.frame(subject)
colnames(subject) <- "Subject"
# Merge with the final data
final <- cbind(final_data_1, subject)
final <- final[order(final$Subject),]
final <- final[order(final$Activity),]

final_melt <- melt(final, id=c("Activity","Subject"), measure.var=features_extract)
averages <- dcast(final_melt, Subject+Activity ~ variable, mean)

## Create the second tidy data set
if (!file.exists("final_data_2.txt")){
  write.table(averages, "final_data_2.txt", sep=",")
}