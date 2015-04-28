#!/usr/bin/R --verbose --quiet

# This is NOT called to run analysis.
# It is included here to show steps used to get UCI data sets.
#
# It assumes you are working in target project directory.
# That is, the directory where ZIP file will be downloaded into.
# It should be where this script and the README.md, CodeBook.md files are.
# Otherwise you will need to setwd('some_path') to you preferred location.

# need utils library to work with ZIP archives
require(utils)

# download UCI archive into local directory
zipFileName <- file.path("getdata-projectfiles-UCI HAR Dataset.zip")
if (!file.exists(zipFileName)) {
    zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(zipUrl, destfile = zipFileName, method = "curl", mode = "wb")
    print(paste(Sys.time(), "archive downloaded"))
}

# unzip overwriting existing directory to ensure clean setup
if (file.exists(zipFileName)) {
    unzip(zipFileName, list = TRUE)
    unzip(zipFileName, overwrite = TRUE)
    print(paste(Sys.time(), "unpacked archive"))
}

# download UCI dataset names
namesFileName <- file.path("UCI HAR Dataset.names")
if (!file.exists(namesFileName)) {
    namesUrl = "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names"
    download.file(namesUrl, destfile = namesFileName, method = "curl")
    print(paste(Sys.time(), "data set names downloaded"))
}
