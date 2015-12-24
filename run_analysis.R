## Step 1
#Test Section read X and y data:
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt", col.names = "label")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")

# Train section read X and y data
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt", col.names = "label")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

#create x, y and subject dataset
x_data <- rbind(x_train, x_test)

y_data <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)

## Step 2
#Load measurements from mean and standard deviation 
features <- read.table("features.txt")

mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

x_data <- x_data[, mean_and_std_features]

names(x_data) <- features[mean_and_std_features, 2]

## Step 3
#Name the activities in the data set
activities <- read.table("activity_labels.txt")

y_data[, 1] <- activities[y_data[, 1], 2]

names(y_data) <- "activity"

##Step 4
#Appropriately labels the data set with descriptive variable names
names(subject_data) <- "subject"

# Combine data  in a cbind
comb_data <- cbind(x_data, y_data, subject_data)
#write.table(comb_data, "comb_data.txt", row.names = FALSE)

##Step 5
#Independent tidy data set with the average of each variable 
tidy <- ddply(comb_data, .(subject, activity), function(x) colMeans(x[, 1:66])) 

write.table(tidy, "tidy.txt", row.name=FALSE)