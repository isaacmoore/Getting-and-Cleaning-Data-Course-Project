# ----- Load activity labels and features data in R -----
activitylabels <- read.table("activity_labels.txt")[,2]
features <- read.table("features.txt")[,2]
# ----- Load test data into R -----
xTest <- read.table("X_test.txt")
yTest <- read.table("y_test.txt")
subjectTest <- read.table("subject_test.txt")
# ----- Load train data into R -----
xTrain <- read.table("X_train.txt")
yTrain <- read.table("y_train.txt")
subjectTrain <- read.table("subject_train.txt")
# ----- Merge the train and test data -----
x <- rbind(xTrain, xTest)
y <- rbind(yTrain, yTest)
subject <- rbind(subjectTrain, subjectTest)
# ----- Merge all data together -----
allData <- cbind(x,y,subject)
# ----- Filter mean and std from allData -----
meanstdcols <- grepl("mean\\(\\)", names(allData)) | grepl("std\\(\\)", names(allData))
meanstdcols[1:2] <- TRUE
allData <- allData[, meanstdcols]
# ----- Create the tidy dataset -----
library(reshape2)
melted <- melt(allData, id = c("subjectID", "activity"))
tidyData <- dcast(melted, subjectID + activity ~ variable, mean)
write.table(tidyData, "tidyData.txt", row.name = FALSE) 