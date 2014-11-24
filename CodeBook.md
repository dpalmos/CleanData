### Data source

The data used for this exercise was sourced from:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Available online at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


### Raw data

All information in this section is taken from the README and features_info file provided by the researchers together with the data set (citation above).

* DATA SUBSETS: The study is partitioned into two groups, test and training. Each group has a separate corresponding text file for subjects, activities and measured variables.

* SUBJECTS: The study was participated in by 30 volunteers identified by the numbers 1 to 30. They were assigned randomly to represent either data subset, with 70% of the subjects being selected for generating the training data and the remaining 30% for the test data. The numerical subject identifiers are in the file subject_(train|test).txt

* ACTIVITIES: Each subject had to perform six activities: walking, walking_upstairs, walking_downstairs, sitting, standing, and laying. Like the subjects, the activities are represented numerically as well using the numbers 1 to 6. The file activity_labels.txt links the numerical label to the activity it represents. The activities done by the subjects are in y_(train|test).txt

* MEASURED VARIABLES: The subjects performed the activities while wearing a smartphone which had a built-in accelerometer and gyroscope. Each record then is povided with a triaxial acceleration from the accelerometer and a triaxial angular velocity from the gyroscope. From these, several variables were calculated whose labels were provided by the researchers in the file features.txt. A short description of the variables and its nomenclature are as follows:
      
      - variables begin with a either a t of an f; t denotes time so these variables are the time domain signals, while f denotes frequency so these variables, which were obtained by applying a Fast Fourier Transform (FTT), indicate frequency domain signals
      
      - the next information provided in the variable names is whether the acceleration signal is from the gravitational component (indicated as "Gravity") or body motion component (indicated as "Body")
      
      - the third component of the variable name is either "Acc" or "Gyro" to indicate whether the signal was measured from the accelerometer ("Acc") o the gyroscope ("Gyro")

      - another measure that was provided was the jerk signals, which were obtained by deriving the body linear acceleration and angular velocity in time
      
      - the final component is an "X", "Y" or "Z" to denote the 3 axial signals in these directions 

The combination of all these produces 33 different variables. The following set of statistical measures were taken for these variables (taken directly from the features_info.txt file):
      
      - mean(): Mean value
      - std(): Standard deviation
      - mad(): Median absolute deviation 
      - max(): Largest value in array
      - min(): Smallest value in array
      - sma(): Signal magnitude area
      - energy(): Energy measure
      - iqr(): Interquartile range 
      - entropy(): Signal entropy
      - arCoeff(): Autoregresion coefficients with Burg order equal to 4
      - correlation(): correlation coefficient between two signals
      - maxInds(): index of the frequency component with largest magnitude
      - meanFreq(): Weighted average of the frequency components to obtain a mean frequency
      - skewness(): skewness of the frequency domain signal 
      - kurtosis(): kurtosis of the frequency domain signal 
      - bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window
      - angle(): Angle between to vectors

All observations for these variables are in the files X_(train|test).txt


### Tidy data

For the tidy data set, all data were merged in one table. This is a two-step process which includes combining first the subject, y (activity labels) and X (observations) tables of each data set (train and test), and then combining the train and test data sets.

* SUBJECTS:The numerical identifier (1 to 30) for subjects were retained as is.

* ACTIVITIES: The activities in the raw data were identified numerically. These were changed into the descriptive names in the tidy data such that the activity column displays the labels walking, walking_upstairs, walking_downstairs, sitting, standing, and laying instead of the numbers 1 to 6.

* MEASURED VARIABLES: The raw data had 33 variables, and each had 17 different statistical measures taken for it (for a total of 561 variables). In the tidy data, only the mean and standard deviations were taken for these variables, which totals to 66 variables. Adding in the column for subject ID and activity, the tidy data then has 68 columns to represent the 68 variables.

The variable names were retained as described above, except that the characters -, ( and ) which were present in the raw data variable names were changed to a dot so that its syntax is valid in R.

* AGGREGATING THE DATA: The raw data contained 10,299 observations. Aside from extracting only the mean and standard deviation variables, the observations for these variables were averaged based on subject and activity. Since there are 30 subjects and each performed 6 activities, the tidy data has 180 observations.

