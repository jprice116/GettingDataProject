
OriginalWd <- getwd()

#Load data.table and reshape2 packages
require("data.table", character.only=TRUE, quietly=TRUE)
require("reshape2", character.only=TRUE, quietly=TRUE)

#Download zip file and unzip
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data")){dir.create("./data")}
setwd("./data")
if(!file.exists("Dataset.zip")){download.file(fileUrl,destfile="./Dataset.zip", mode="wb")
                                unzip("Dataset.zip")}

#Set working directory to "UCI HAR Dataset"
setwd("./UCI HAR Dataset")

#Use fread to read data files
message("  Reading downloaded files...")
Features <- fread(file.path("features.txt"))
ActivityLabels <- fread(file.path("activity_labels.txt"))
SubjectTrain <- fread(file.path("train", "subject_train.txt"))
SubjectTest  <- fread(file.path("test", "subject_test.txt" ))
LabelTrain <- fread(file.path("train", "Y_train.txt"))
LabelTest  <- fread(file.path("test", "Y_test.txt" ))

#Use data.table and read.table to read "X_train.txt" and "X_test.txt"
#because fread will not work
DataTrain <- data.table(read.table(file.path("train", "X_train.txt")))
message("  ...still reading downloaded files...")
DataTest <- data.table(read.table(file.path("test", "X_test.txt")))
message("  Done reading files!")

setwd(OriginalWd)

#Merge the training and the test sets to create one data set (Requirement 1)
Subject <- rbind(SubjectTrain, SubjectTest)
Label <- rbind(LabelTrain, LabelTest)
HarData <- rbind(DataTrain, DataTest)

#Apply distinct names to variables (Requirement 4)
setnames(Subject, "V1", "SubjectNumber")
setnames(Label, "V1", "ActivityNumber")
setnames(Features, names(Features), 
         c("FeatureNumber", "FeatureName"))
setnames(ActivityLabels, names(ActivityLabels), 
         c("ActivityNumber", "ActivityName"))

#Merge data tables
HarData <- cbind(Subject, Label, HarData)
setkey(HarData, SubjectNumber, ActivityNumber)

#Subset only the measurements on the mean and standard deviation from Features
SubFeatures <- Features[grepl("mean\\(\\)|std\\(\\)", FeatureName)]

#Extracts only the measurements on the mean and standard deviation for each 
#measurement (Requirement 2)
SubFeatures$FeatureCode <- SubFeatures[, paste0("V", FeatureNumber)]
SubColVec <- c(key(HarData), SubFeatures$FeatureCode)
HarData <- HarData[, SubColVec, with = FALSE]

#Append activity names to data (Requirement 3)
HarData <- merge(HarData, ActivityLabels, 
                 by="ActivityNumber", all.x = TRUE)
setkey(HarData, SubjectNumber, ActivityNumber, ActivityName)

#Transform data such that each row represents one observation
HarData <- data.table(melt(HarData, key(HarData), 
                           variable.name = "FeatureCode"))

#Append feature names to data
HarData <- merge(HarData, 
                 SubFeatures[ , list(FeatureNumber, FeatureCode, FeatureName)], 
                 by="FeatureCode", all.x = TRUE)

HarData$Activity <- factor(HarData$ActivityName)
HarData$Feature <- factor(HarData$FeatureName)

#Load dplyr package
require("dplyr", character.only=TRUE, quietly=TRUE)

#Create a data frame tbl.
HarData <- tbl_df(HarData)

#Clear out unnecessary variables and columns
rm(list = c("ActivityLabels", "DataTest", "DataTrain", "Features", "fileUrl",
            "Label", "LabelTest", "LabelTrain", "OriginalWd", "SubColVec", 
            "SubFeatures", "Subject", "SubjectTest", "SubjectTrain"))
HarData <- HarData %>%
        select(SubjectNumber, Activity, Feature, value) %>%
        arrange(SubjectNumber)

#Create a second, independent tidy data set with the average of each 
#variable for each activity and each subject (Requirement 5)
tidyResult <- HarData %>%
        group_by(SubjectNumber, Activity, Feature) %>%
        summarize(AverageValue = mean(value))

#Write the tidy data result to a txt file
write.table(tidyResult, 
            file = "./data/tidyResult.txt", 
            quote=FALSE, sep="\t", row.names=FALSE)

message(Sys.time(), "  tidyResult.txt created & saved to data folder")
