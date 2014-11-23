### Details for the script run_analysis.R


#### PART 1: Merge test and training data sets

1. ```list.files``` produces a character vector containing all the filenames in the working directory (where the data set of interest, under the folder *UCI HAR Dataset* is assumed to be located). ```full.names = TRUE``` includes the directory path so the character vector can be used to call the files in the next step. In this step, two vectors are created: test_files and training_files. Each vector contains three filenames, including full path nanem, corresponding to the subject, X and y files. 

2. Using a ```for``` loop, a file in the vector created in step 1 is loaded in R using ```read.table```. The second file is opened and appended to the first file using ```cbind```, and, in a similar fashion, the third file is opened and appended to the first and second files. This step contains two loops, one for test data and one for training data, and consequently produces two tables corresponding to each set.

3. The two tables are combined using ```rbind``` and placed in the vector called complete_data.

4. The loop in step 2 combined columns in the order specified by the vector containing the filenames, which is arranged alphabetically so the file *y.txt* which contains the activity labels became the last column in the table. This step rearranges the columns so that the first column is the subject identifier, the second column is the activity label, and the succeeding columns are all the measured variables.


#### PART 2: Label the data set with descriptive variable names

1. A file is provided with the given data set, *features.txt*, that contains the names of all the measured variables. This is read into R using ```read.table``` and assigned to a vector called variables. Column 1 contains row labels and column 2 contains the descriptive variable names.

2. This step coerces Column 2 of variables, which is a factor, to be of the type character so the function ```make.names``` can be used. This will correct the variable names' syntax since they contain invalid characters such as - , (  and ). ```unique = TRUE``` makes all variable names unique such that if there are repetitive names, a numerical identifier will be affixed at the end to distinguish these names.

3. The previous step changed the invalid characters to a dot, which created a lot of dots and changed the variable names, for example, from "tBodyAcc-mean()-X" to "tBodyAcc.mean...X". Using ```gsub```, these dots are replaced with just one dot to clean up the variable names.

4. Using ```colnames```, the character vector created in the previous steps are made column names of the table created in Part 1, plus "subject.ID" and "activity" for the first two columns.


#### PART 3: Extract only the measurements on the mean and standard deviation of each variable

1. Using ```grep```, all column names with "mean" OR "std" in it are fished out and placed in a vector named signif_cols. ```ignore.case``` is set to FALSE to exclude the column names containing the string "gravityMean" which are part of variables pertaining to angles, which we don't want.

2. ```grep``` is used again but this time to search for variable names containing "meanFreq", which we don't want in our mean and standard deviation subset either. ```invert``` is set to TRUE so that the code returns the values which DO NOT match the specified pattern (which is "meanFreq"). So this step returns every column name that does not containt "meanFreq".

3. The character vector produced in the previous steps, composed of column names that has "mean" and "std" ("gravityMean" and "meanFreq" EXCLUDED), are used to subset only the columns that measure the mean and standard deviation of each variable in the data set, plus the subject and activity column. This new table is assigned to a vector called subset_mean_sd.


#### PART 4: Use descriptive activity names to name the activities in the data set

1. A file is provided with the given data set, *activity_labels.txt*, which contain the activity class label (numbers 1 to 6) with its corresponding descriptive activity name (walking, walking_upstairs, walking_downstairs, sitting, standing, laying). This file is loaded into R using ```read.table``` and assigned to the vector act_names.

2. The activity class labels (number 1 to 6), which are what's used in the current data set, are converted into a factor using the ```factor``` function. This function was also used to specify the numbers as the levels that are to be replaced with its corresponding descriptive name using the ```labels``` argument. This new data set which uses descriptive names to identify the activities are put in a vector called descriptive_data.


#### PART 5: From the data set in Part 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

1. The ```aggregate``` function splits data into subsets and computes summary statistics for each subset. The first argument is the set of data to be manipulated, which in this case is columns 3:68 of the descriptive_data created from the previous part. The second argument contains the variable or variables according to which the data will be divided into. In this case, we want the data to be subset according to activity and subject ID, so that is specified using the ```by``` argument. And then finally, we specify what summary statistics we want to compute for the data subsets using the ```FUN``` argument. So what this step does is subset the measured variables in columns 3 to 68 according to activity and subject ID, and then compute the mean for each subset. It returns the data in a table format, which is assigned to a vector called averaged_data.

2. The previous step made the activity the first column and then subject ID the second column. This step just rearranges the columns so that the subject ID is the first column and the activity becomes the second column.

3. Step 1 removed the column names for subject ID and activity, so this step simply reassigns the column names using the ```colnames``` function. 


### EXTRAS

#### Writing the table as a text file for submission.

The function ```write.table``` is used to write the tidy data set, averaged_data, into a text file with file name *tidyData.txt*.


#### Reading the text file into R (for evaluators)

Use the following code to read and view the text file in R:

```
tidyData <- read.table("tidyData.txt", header = TRUE)
View(tidyData)
```