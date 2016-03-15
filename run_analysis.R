# ----- Load activity labels and features data in R -----
activitylabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

# ----- Load test data into R -----
xTest <- read.table("X_test.txt")
yTest <- read.table("y_test.txt")
subjectTest <- read.table("subject_test.txt")

# ----- Load train data into R -----
xTrain <- read.table("X_train.txt")
yTrain <- read.table("y_train.txt")
subjectTrain <- read.table("subject_train.txt")

# ----- Merge the train and test data -----
train <- cbind(xTrain, yTrain, subjectTrain)
test <- cbind(xTest, yTest, subjectTest)

# ----- Merge all data together -----
allData <- rbind(train, test)

# ----- Filter mean and std from allData -----
meanstd <- grep(".*(mean|std).*", features$V2)

# ----- Add titles -----
titles <- c("Subject","activity")
titles <- c(titles, as.character(features[meanstd,]$V2))
names(allData) <- titles
for (i in 1:6) {
        allData$activity[allData$activity == i] <- as.character(activitylabels$V2[i])
}

# ----- Create the tidy dataset -----
library(reshape2)
melted <- melt(allData, id = c("Subject", "activity"))
tidyData <- dcast(melted, Subject + activity ~ variable, mean)
write.table(tidyData, "tidyData.txt", row.name = FALSE) 
