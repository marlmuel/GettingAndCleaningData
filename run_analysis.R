# Assignment Smartphone acceleration and angle velocity
# 5. Mai 2017 
# Marlen Müller

# read in feature data
setwd("~/Desktop/CourseraDataScience/UCI HAR Dataset")
features <- read.csv("features.txt", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
feature_name <- gsub("[0-9]+ ","",features[,1])
feature_id <- as.numeric(rownames(features))


# read in training data: subjects, labels and observations
train_subjects <- read.csv("train/subject_train.txt", header = FALSE)
train_labels <- read.csv("train/y_train.txt", header = FALSE)
train_obs <- read.csv("train/X_train.txt", header = FALSE, sep = "")
#column bind labels and subjects
train_set <- cbind(train_obs, train_labels, train_subjects)

# 4. assign column names for each feature
colnames(train_set) <- c(feature_name, "labels", "subjects")

# read in test data: subjects, labels and observations
test_subjects <- read.csv("test/subject_test.txt", header = FALSE)
test_labels <- read.csv("test/y_test.txt", header = FALSE)
test_obs <- read.csv("test/X_test.txt", header = FALSE, sep = "")
#column bind labels and subjects
test_set <- cbind(test_obs, test_labels, test_subjects)
# 4. assign column names for each feature
colnames(test_set) <- c(feature_name, "labels", "subjects")

# 1. merge training and test data
all_set <- rbind(train_set, test_set)

# 2. subset dataset only for mean and standard deviation
mean_sd_index <- grep("mean|std|labels|subjects", colnames(all_set))
mean_sd <- all_set[ ,mean_sd_index]

# 3. add descriptive names for labels
activity_labels <- read.csv("activity_labels.txt", sep = " ", header = FALSE, stringsAsFactors = FALSE)

for (i in 1:dim(mean_sd)[1]){
    if (mean_sd$labels[i] == 1) mean_sd$activity[i] <- activity_labels[1,2]
    if (mean_sd$labels[i] == 2) mean_sd$activity[i] <- activity_labels[2,2]
    if (mean_sd$labels[i] == 3) mean_sd$activity[i] <- activity_labels[3,2]
    if (mean_sd$labels[i] == 4) mean_sd$activity[i] <- activity_labels[4,2]
    if (mean_sd$labels[i] == 5) mean_sd$activity[i] <- activity_labels[5,2]
    if (mean_sd$labels[i] == 6) mean_sd$activity[i] <- activity_labels[6,2]
}

# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the 
# average of each variable for each activity and each subject.

tidy_ds <- sapply(split(mean_sd, list(mean_sd$activity, mean_sd$subjects)), function(x) colMeans(x[,1:79]))
# transpose tidy_ds
t_tidy_ds <- t(tidy_ds)

splitAct <- strsplit(rownames(t_tidy_ds),"\\.")
# add activity
firstElement <- function(x){x[1]}
activity <- sapply(splitAct, firstElement)
t_tidy_ds <- cbind(t_tidy_ds, activity=activity)

# add subject
secondElement <- function(x){x[2]}
subject <- sapply(splitAct, secondElement)
t_tidy_ds <- cbind(t_tidy_ds, subject=subject)
rownames(t_tidy_ds) <- NULL
write.table(x = t_tidy_ds, file = "t_tidy_ds.txt", quote = FALSE, sep = "\t")

