CodeBook
========


Study Design
------------

The file `uci_analysis.txt` contains a data set in "long" format of averaged
means and standard deviation measurements from 
[UCI HAR](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The source data was processed (by `run_analysis.R`) as follows:

- Test and training measurement data was combined.
- This anaylsis is only interested in the mean and standard deviation
  measurements, so all other activity measurements were purged from the
  analysis data set. Note: This analysis explicity excludes the gravityMean and
  meanFreq measurements.
- Activity codes were replaced by their textual name.
- Feature names were only marginally modified to be valid names within the
  processing tool. A mapping is provided between the original UCI HAR name and
  the modified name.
- The iterim reduced "wide" data set was then melted into a "long" format to
  obtain a measurement value, by subject, activity and feature.
- Finally, the point of this analysis was to calculate the averages for mean
  and standard deviations by subject, activity and feature. This makes up the
  final analysis data set with fields described below.

The `README.md` contains further information on how this data set was
prepared.

The analysis (`uci_analysis.txt`) data set contains the following fields:


subject
-------

Column 1: the subject id

Type: Integer, Range: [1:30], Categorical

This identifies the subject who performed the activity for each window sample.

Its range is from 1 to 30.


activity
--------

Column 2: the activity description

Type: Character, Length: 18, Categorical

These are text labels of activities. They were sourced from the UCI HAR file
`activity_labels.txt`.

The 6 activities are:

```
Factor  Factor
Level   Value
--------------------------
1       WALKING
2       WALKING_UPSTAIRS
3       WALKING_DOWNSTAIRS
4       SITTING
5       STANDING
6       LAYING
```


feature
-------

Column 3: the feature measurement being averaged

Type: Character, Length: 26, Categorical

This field contains modified feature labels for mean and standard deviation
measurements. This is to enable casting into wide format as valid column names.

There are 66 feature measurements that have been averaged. This analysis
excludes the gravityMean and meanFreq measurements.

The UCI HAR field abbreviations are:

* `acc` - accelerometer measured in Hz (`accel` in analysis data)
* `Gyro` - gyroscope (`gyro` in analysis data)
* `Mag` - magnitude (`magni` in analysis data)
* `mean` - mean
* `std` - standard deviation
* `XYZ` - suffixes denote the 3-axial signals in the X, Y and Z directions (`xyz` in analysis data)
* `t` - a time domain signal measurement (`time` in analysis data)
* `f` - a frequency domain signal measurement (`freq` in analysis data)

Each feature maps to an associated UCI HAR feature measurements as described in
`features.txt` and `features_info.txt`:

```
UCI Feature                     analysis data Averaged Feature
--------------------------------------------------------------
tBodyAcc-mean()-X               timebodyaccelmeanx
tBodyAcc-mean()-Y               timebodyaccelmeany
tBodyAcc-mean()-Z               timebodyaccelmeanz
tBodyAcc-std()-X                timebodyaccelstdx
tBodyAcc-std()-Y                timebodyaccelstdy
tBodyAcc-std()-Z                timebodyaccelstdz
tGravityAcc-mean()-X            timegravityaccelmeanx
tGravityAcc-mean()-Y            timegravityaccelmeany
tGravityAcc-mean()-Z            timegravityaccelmeanz
tGravityAcc-std()-X             timegravityaccelstdx
tGravityAcc-std()-Y             timegravityaccelstdy
tGravityAcc-std()-Z             timegravityaccelstdz
tBodyAccJerk-mean()-X           timebodyacceljerkmeanx
tBodyAccJerk-mean()-Y           timebodyacceljerkmeany
tBodyAccJerk-mean()-Z           timebodyacceljerkmeanz
tBodyAccJerk-std()-X            timebodyacceljerkstdx
tBodyAccJerk-std()-Y            timebodyacceljerkstdy
tBodyAccJerk-std()-Z            timebodyacceljerkstdz
tBodyGyro-mean()-X              timebodygyromeanx
tBodyGyro-mean()-Y              timebodygyromeany
tBodyGyro-mean()-Z              timebodygyromeanz
tBodyGyro-std()-X               timebodygyrostdx
tBodyGyro-std()-Y               timebodygyrostdy
tBodyGyro-std()-Z               timebodygyrostdz
tBodyGyroJerk-mean()-X          timebodygyrojerkmeanx
tBodyGyroJerk-mean()-Y          timebodygyrojerkmeany
tBodyGyroJerk-mean()-Z          timebodygyrojerkmeanz
tBodyGyroJerk-std()-X           timebodygyrojerkstdx
tBodyGyroJerk-std()-Y           timebodygyrojerkstdy
tBodyGyroJerk-std()-Z           timebodygyrojerkstdz
tBodyAccMag-mean()              timebodyaccelmagnimean
tBodyAccMag-std()               timebodyaccelmagnistd
tGravityAccMag-mean()           timegravityaccelmagnimean
tGravityAccMag-std()            timegravityaccelmagnistd
tBodyAccJerkMag-mean()          timebodyacceljerkmagnimean
tBodyAccJerkMag-std()           timebodyacceljerkmagnistd
tBodyGyroMag-mean()             timebodygyromagnimean
tBodyGyroMag-std()              timebodygyromagnistd
tBodyGyroJerkMag-mean()         timebodygyrojerkmagnimean
tBodyGyroJerkMag-std()          timebodygyrojerkmagnistd
fBodyAcc-mean()-X               freqbodyaccelmeanx
fBodyAcc-mean()-Y               freqbodyaccelmeany
fBodyAcc-mean()-Z               freqbodyaccelmeanz
fBodyAcc-std()-X                freqbodyaccelstdx
fBodyAcc-std()-Y                freqbodyaccelstdy
fBodyAcc-std()-Z                freqbodyaccelstdz
fBodyAccJerk-mean()-X           freqbodyacceljerkmeanx
fBodyAccJerk-mean()-Y           freqbodyacceljerkmeany
fBodyAccJerk-mean()-Z           freqbodyacceljerkmeanz
fBodyAccJerk-std()-X            freqbodyacceljerkstdx
fBodyAccJerk-std()-Y            freqbodyacceljerkstdy
fBodyAccJerk-std()-Z            freqbodyacceljerkstdz
fBodyGyro-mean()-X              freqbodygyromeanx
fBodyGyro-mean()-Y              freqbodygyromeany
fBodyGyro-mean()-Z              freqbodygyromeanz
fBodyGyro-std()-X               freqbodygyrostdx
fBodyGyro-std()-Y               freqbodygyrostdy
fBodyGyro-std()-Z               freqbodygyrostdz
fBodyAccMag-mean()              freqbodyaccelmagnimean
fBodyAccMag-std()               freqbodyaccelmagnistd
fBodyBodyAccJerkMag-mean()      freqbodyacceljerkmagnimean
fBodyBodyAccJerkMag-std()       freqbodyacceljerkmagnistd
fBodyBodyGyroMag-mean()         freqbodygyromagnimean
fBodyBodyGyroMag-std()          freqbodygyromagnistd
fBodyBodyGyroJerkMag-mean()     freqbodygyrojerkmagnimean
fBodyBodyGyroJerkMag-std()      freqbodygyrojerkmagnistd
```

For more please see UCI HAR documentation:

- [UCI HAR Dataset.names](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names)
- `features.txt` in the UCI HAR zip archive
- `features_info.txt` in the UCI HAR zip archive
- `README.txt` in the UCI HAR zip archive


average
-------

Column 4: the average value of feature measurement

Type: Number, Range: [-1.0, 1.0], Continuous

Accelerometers measurements were measured in Hz, which have been normalised in
the UCI HAL data set. The means and standard deviations in this analysis were
calculated from these normalised values. This field thus contains the average
for each of normalised feature measurement by subject and activity.

For more details on feature measurements:

- `UCI HAR Dataset/README.txt`
- `UCI HAR Dataset/features_info.txt`.
