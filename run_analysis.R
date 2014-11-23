## put all filenames in a vector
test_files <- list.files("UCI HAR Dataset//test", pattern = "*.txt", full.names = TRUE)
training_files <- list.files("UCI HAR Dataset//train", pattern = "*.txt", full.names = TRUE)


## read files one by one and append to previous file

for (file in test_files){
      if (!exists("test_data")){
            test_data <- read.table(file)
      }
      else if (exists("test_data")){
            intermediate <- read.table(file)
            test_data <- cbind(test_data, intermediate)
      } 
}

for (file in training_files){
      if (!exists("training_data")){
            training_data <- read.table(file)
      }
      else if (exists("training_data")){
            intermediate <- read.table(file)
            training_data <- cbind(training_data, intermediate)
      }
}


## merge test and training data
complete_data <- rbind(test_data, training_data)

## rearrange columns
complete_data <- complete_data[,c(1, 563, 2:562)]

## label data set with descriptive variable names
variables <- read.table("UCI HAR Dataset//features.txt")
var_names <- make.names(as.character(variables[,2]), unique = TRUE)
var_names <- gsub("...",".", var_names, fixed = TRUE)
colnames(complete_data) <- c("subject.ID", "activity", var_names)

##subset mean and standard deviation columns
signif_cols <- colnames(complete_data)[grep("mean|std", colnames(complete_data), ignore.case = FALSE)]
signif_cols <- signif_cols[grep("meanFreq", signif_cols, invert = TRUE)]
subset_mean_sd <- complete_data[, c("subject.ID", "activity", signif_cols)]

## change activity class labels to descriptive names
## load activity_labels.txt into R as a table, convert to factors
act_names <- read.table("UCI HAR Dataset//activity_labels.txt")
descriptive_data <- within(subset_mean_sd, {
      activity <- factor(subset_mean_sd$activity, levels = act_names$V1, labels = act_names$V2)
})

## get average of each variable for each activity and each subject
averaged_data <- aggregate(descriptive_data[,3:68], by = list(descriptive_data$activity, descriptive_data$subject.ID), FUN = mean)
averaged_data <- averaged_data[,c(2, 1, 3:68)]
colnames(averaged_data)[1:2] <- c("subject.ID", "activity")

## write final tidy data into a text file for submission
write.table(averaged_data, file = "tidyData.txt", row.name = FALSE)
