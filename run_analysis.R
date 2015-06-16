
#Step 1&4 

#Read feature names
feature_names <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
#Replace invalid symbols in names ()-, with dots
feature_names$V2 <- make.names(feature_names$V2)
#replace multiple dots with one
feature_names$V2 <- gsub("...",".",feature_names$V2, fixed = TRUE)
feature_names$V2 <- gsub("..",".",feature_names$V2, fixed = TRUE)

# Read test data (setting proper names to colums )
variables_test <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names = feature_names$V2)
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = c("Activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = c("Subject"))

# Read train data (setting proper names to colums)
variables_train <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names = feature_names$V2)
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("Activity"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = c("Subject"))

#merge data
data_test <- cbind(variables_test,activity_test,subject_test)
data_train <- cbind(variables_train,activity_train,subject_train)
data <- rbind(data_train, data_test)


#Step -2 

#choose mean and std variables
# asuume that only variables that have -mean()  and -std() in names are Mean and Std
# earlier '-', '(',  ') were replaced by '.'
mean_std_names <- subset(feature_names,grepl(".mean.", feature_names$V2, fixed=TRUE) | grepl(".std.", feature_names$V2, fixed = TRUE) )
#add Activity and Subject - two last colums 
cols = c(mean_std_names$V1,length(feature_names$V1)+1,length(feature_names$V1)+2)
# subset frame for mean, std, Activity, Subject colums
mean_std_data <- data[,cols]

#Step 3
#replace activities with  names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
mean_std_data$Activity <- activity_labels[mean_std_data$Activity,2]

#Step 4
# not needed - was a part of step 1

#Step 5
#prepare new data set
library(dplyr)
tidy_data <- group_by(mean_std_data, Activity, Subject)
tidy_data <-summarise_each(tidy_data, funs(mean))

write.table(tidy_data, "./tidy_data.txt", row.names = FALSE)
