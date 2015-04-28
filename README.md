README
======

Contents
--------

* [Objectives](README.md#objectives)
* [Files in repository](README.md#files-in-repository)
* [Source UCI HAL data set](README.md#source-uci-hal-data-set)
* [What does the run analysis script do?](README.md#what-does-the-run-analysis-script-do)
* [Is this tidy data?](README.md#is-this-tidy-data)
* [Layout of CodeBook](README.md#layout-of-codebook)
* [How to run analysis](README.md#how-to-run-analysis)
* [How to load data set](README.md#how-to-load-data-set)
* [Acknowledgements](README.md#acknowledgements)

--------------------------------------------------------------------------------

Objectives
==========

This analysis of the UCI HAL data set will average mean and standard deviation
measurements from Samsung Galaxy S smartphone accelerometers.

The project uses an [R](http://www.r-project.org/) script called
`run_analysis.R` that does the following:

 (1) Merges training and the test sets to create one data set

 (2) Extracts only measurements on the mean and standard deviation for each
     measurement.

 (3) Sets descriptive activity names to name the activities in the data set.

 (4) Labels the data set with descriptive variable names.

 (5) From the data set in step 4, creates a second, independent tidy data set
     with the average of each variable for each activity and each subject.


Files in repository
===================

Included in this repository are the following files:

* [README.md](README.md) this document
* [CodeBook.md](CodeBook.md) describes the variables of analysis data set
* [run_analysis.R](run_analysis.R) creates the analysis data set

I have also included a helper script to download and unpack the UCI HAL data
set archive:

* [get_ucidata.R](get_ucidata.R) download and unpack UCI HAL data archive from original source


Source UCI HAL data set
=======================

The data set for this analysis was sourced from,
[UCI Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The direct link to the raw data set is:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

A full description of the UCI HAL data set is available from:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>


What does the run analysis script do?
=====================================

Inline with project [objectives](README.md#objectives), the `run_analysis.R`
script has several parts that are executed sequentially:

* Do a quick sanity check on required packages and data directories

* Merge data
    * load activity a feature data
    * load test data
    * load training data
    * merge by rows
    * save into a data frame called `raw`

* Subset merged data to include only means and standard deviations
    * save into a data frame called `data`

* Replace activity id's with activity text labels
    * this updates the `data` data frame

* Label columns based on `features.txt`
    * use lower case names for all features
    * remove non-alphabetic characters from features
    * cleanup feature names
    * update subject as a factor
    * update activity as a factor using labels
      and levels from `activity_labels.txt`
    * melt data into long format with headings:
      `subject`, `activity`, `feature`, `value`
    * save into a data frame called `meltdata`

* Create tidy data set in long format
    * aggregate feature measurement values by subject and activity
    * save into a data frame called `tidydata` with headings:
      `subject`, `activity`, `feature`, `average`
    * write data frame to text file called `uci_analysis.txt`


Is this tidy data?
==================

The script creates a data set in long format. Long data has columns for
possible variable types and columns for the values of those variables.

The feature column contains modified descriptions of the feature measurements.
Since the data set can be cast into wide format, the values in this column may
become column names with the associated restrictons that column names have in
R. To assist this, and to keep the names short but still meaningful they have
only been mariginally modified from the UCI feature names.

The tidy data set was strutured following principles described by
[Hadley Wickham in Tidy Data, Journal of Statistics Software](http://vita.had.co.nz/papers/tidy-data.pdf)
with additional recommendations provided by David Hood,
see [Acknowledgements](README.md#acknowledgements).


Layout of CodeBook
==================

The CodeBook describes the content of the data set created by the
`run_analysis.R` script. It includes:

* Variable Name: Indicates the variable name assigned to each variable in the
  data collection.

* Variable Column Location: Indicates the starting location and type of the
  variable.

* Variable Type: Indicates type and length or range of variable.

* Variable Value: Indicates the code values occurring in the data for this
  variable.

* Variable Description: Indicates an abbreviated variable description to 
  identify the variable.


How to run analysis
===================

To run the analysis script:

 (1) clone this repository:
```
git clone git@github.com:frankhjung/getdata-013.git
```

 (2) download
 [UCI HAL data set archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 and unpack into a working directory containing `run_analysis.R` The archive
 contains a directory structure: (Note: The `Inertial Signals` directories are
 not used in this analysis.)
```
UCI HAR Dataset/
├── test
│   └── Inertial Signals
└── train
    └── Inertial Signals
```
 The R script `get_ucidata.R` can be used to download and extract the UCI HAL
 data set:
```
cd getdata-013
R -f get_ucidata.R
```

 (3) The analysis script must be in the parent directory of `UCI HAR Dataset`
 Set the working directory to the directory containing the `run_analysis.R`
 script.
```
cd getdata-013
```

 (4) You can call the analysis script from the command line using:
```
R -f run_analysis.R
```


How to load data set
====================

To load data set `uci_analysis.txt` into R, use:

```r
tidydata <- read.table("uci_analysis.txt", header = T)
```


Acknowledgements
================

The data set used for this project was provided by:

* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
  Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
  Hardware-Friendly Support Vector Machine. International Workshop of Ambient
  Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The principles of tidy data came from:

* [Hadley Wickham](http://had.co.nz/), Tidy Data, Journal of Statistics Software,
  <http://vita.had.co.nz/papers/tidy-data.pdf>

Helpful hints were kindly provided by:

* David Hood, Community TA, David's personal course project FAQ:
  <https://class.coursera.org/getdata-013/forum/thread?thread_id=30>

