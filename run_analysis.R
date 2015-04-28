#!/usr/bin/R --verbose --quiet

################################################################################
# RUN ANALYSIS ON UCI DATA SET
################################################################################

# make sure we have all the packages installed to run analysis
if (!require("reshape2")) {
    # install.packages("reshape2")
    stop("Required package reshape2 missing")
}

# must have data sets locally
if (!file.exists("UCI HAR Dataset")) {
    stop("UCI HAR Dataset not found.\n",
         "Have you downloaded and unzipped the archive?\n",
         "See README.md for details.")
}

#
# from here on, we are assuming the raw UCI HAR data exists and is in
# a directory structure as per the original archive
#

################################################################
# MERGE
#
# Requirement (1) Merges the training and the test sets to create one data set.
#

#
# load activity labels and features
#
activity_labels <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"), stringsAsFactors=F)
features        <- read.table(file.path("UCI HAR Dataset", "features.txt"), stringsAsFactors=F)

#
# load train data sets
#

# prepare train dataset
subject_train <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"), stringsAsFactors=F)
y_train       <- read.table(file.path("UCI HAR Dataset", "train", "y_train.txt"), stringsAsFactors=F)
x_train       <- read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"), stringsAsFactors=F)

# set column names from features
names(x_train) <- features$V2

# put variables (subject & activity) first, then measurements (X data)
train <- cbind(subject = subject_train$V1, activity = y_train$V1, x_train)

#
# load test data sets
#

# prepare test dataset
subject_test <- read.table(file.path("UCI HAR Dataset", "test", "subject_test.txt"), stringsAsFactors=F)
y_test       <- read.table(file.path("UCI HAR Dataset", "test", "y_test.txt"), stringsAsFactors=F)
x_test       <- read.table(file.path("UCI HAR Dataset", "test", "X_test.txt"), stringsAsFactors=F)

# set column names from features
names(x_test) <- features$V2

# put variables (subject & activity) first, then measurements (X data)
test <- cbind(subject = subject_test$V1, activity = y_test$V1, x_test)

#
# merge
#

# merge test and train by rows - this is the "raw" data set
raw <- rbind(test, train)

# free memory (alternatively can hold onto these so we can re-create "raw")
rm(subject_test, x_test, y_test, test)
rm(subject_train, x_train, y_train, train)

# Completed (1): Have merged test and train datasets into data frame, "raw"


################################################################
# STD and MEANS
#
# Requirement (2) Extracts only the measurements on the mean and
#                 standard deviation for each measurement
#

# get mean() and std() measurements only, we are excluding gravityMean and meanFreq
colstokeep <- grepl("subject|activity|std|mean[^F]", colnames(raw), ignore.case = F)

# so we can replay this step from "raw", store result into data frame: data
data <- raw[,colstokeep]

# Completed (2): data contains subject, activity, and std, mean columns


################################################################
# ACTIVITY NAMES
#
# Requirement (3) Uses descriptive activity names to name the activities
#                 in the data set
#

data$activity <- activity_labels$V2[data$activity]

# Completed (3): activity now contains string labels


################################################################
# LABEL COLUMNS AND MELT TO LONG FORMAT
#
# Requirement (4) Appropriately labels the data set with
#                 descriptive variable names.

# - column names are as per the features but are messy in that
#   they contain non-alphabetic characters, and are mixed-case
# - subject & activity are factors
# - melt data to long format

# lowercase all column names
colnames(data) <- tolower(colnames(data))

# remove non-alphabetic characters from column names
colnames(data) <- gsub("[^a-z]", "", colnames(data))

# replace t with time and f with freq for frequency
colnames(data) <- sub("^t", "time", colnames(data))
colnames(data) <- sub("^f", "freq", colnames(data))

# correct duplicate body as per codebook in features_info.txt
colnames(data) <- sub("(body)+", "\\1", colnames(data))

# replace acc with accel as abbreviation for accelerometer
colnames(data) <- sub("acc", "accel", colnames(data))

# note: gyro is abbreviation for gyroscope

# replace mag with magni as abbreviation for magnitude
colnames(data) <- sub("mag", "magni", colnames(data))

# subjects are factors 1..30
data$subject <- factor(data$subject)

# activities are factors using levels as per activity labels
data$activity <- factor(data$activity, activity_labels$V2)

# melt from "wide" to "narrow" format
# where: subject and activity are id variables
# all the rest are feature measurements
library(reshape2)

meltdata <- melt(data,
                 id.vars = c("subject", "activity"),
                 variable.name = "feature")

# Completed (4): measurement variables tidied and melted into
#                subject, activity, feature, value


################################################################
# CREATE TIDY DATA SET OF FEATURE MEASUREMENT AVERAGES
#
# Requirement (5) create a second, independent tidy data set with
#                 the average of each variable for each activity
#                 and each subject

# get average value for each feature measurement by subject and activity
# return as narrow list of averages (i.e. in "long" format)
tidydata <- with(meltdata,
                 aggregate(x=value,
                           by=list(subject, activity, feature),
                           FUN=mean))

# set meaningful labels
colnames(tidydata) <- c("subject", "activity", "feature", "average")

# save to text file
write.table(tidydata, "uci_analysis.txt", row.names = FALSE)

# to read in this file use:
# tidydata <- read.table("uci_analysis.txt", header = T)

# Completed (5)

#EOF