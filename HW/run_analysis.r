remove(list = ls())
# 0. set working directory
#wd <- "D:(2)Study/R/3_GettingData/L2"
#setwd(wd)
data.x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
data.x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")

#1. Merges the training and the test sets to create one data set.
data.merge <- merge(data.x.test, data.x.train, all = TRUE)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
feature <- read.table("./UCI HAR Dataset/features.txt")
data.select <- subset(data.merge, select = grepl("mean", as.character(feature$V2)) | grepl("std", as.character(feature$V2)))

#3. Uses descriptive activity names to name the activities in the data set
data.y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
data.y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
data.activity <- rbind(data.y.test, data.y.train)
names(data.activity) <- "activity"
activity <- factor(data.activity$activity, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
data.xy <- cbind(activity, data.select)

# 4. Appropriately labels the data set with descriptive variable names. 
tmp <- as.vector(feature$V2)
feature.select <- tmp[grepl("mean", tmp) | grepl("std", tmp)]
names(data.xy)[2:80] <- feature.select

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(data.y.test, data.y.train)
data.xy.sub <- cbind(subject, data.xy)
names(data.xy.sub)[1] <- "subject"
tidy1 <- data.xy.sub[order(data.xy.sub$subject),]

write.table(tidy1, file = "tidy_data.txt", row.names = FALSE)






