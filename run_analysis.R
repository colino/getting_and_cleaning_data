
# carico i dataset

feature_file <- "./features.txt"
feature_vect <- read.table(feature_file, 
                           sep=" ", 
                           fill=FALSE, stringsAsFactors=F)
feature_vect <- feature_vect[,-1]

# vector of features
feature_vect
length(feature_vect)

test_x <- "./X_test.txt"
test_set_x <- read.table(test_x, 
                       sep="\t", 
                       fill=TRUE, stringsAsFactors=F)
dim(test_set_x)
test_set_x <- unlist(lapply(X=test_set_x, function(x) gsub(pattern="  ",replacement=" ", x=x)))
writeLines(text=test_set_x , con="./test_set_x.txt")
test_set_x <- read.table(file="./test_set_x.txt", 
                         sep=" ", 
                         stringsAsFactors=F)
test_set_x <- test_set_x[-1]
row.names(test_set_x) <- NULL

train_x <- "./X_train.txt"
train_set_x <- read.table(train_x, 
                         sep="\t", 
                         fill=TRUE, stringsAsFactors=F)
dim(train_set_x)
train_set_x <- unlist(lapply(X=train_set_x, function(x) gsub(pattern="  ",replacement=" ", x=x)))
writeLines(text=train_set_x , con="./train_set_x.txt")
train_set_x <- read.table(file="./train_set_x.txt", 
                         sep=" ", 
                         stringsAsFactors=F)
train_set_x <- train_set_x[-1]
row.names(train_set_x) <- NULL


# merge train and test

dataset <- rbind(train_set_x, test_set_x)
# add colnames to dataset
colnames(dataset) <- feature_vect

# save dataset 
write.table(x=dataset , file="./dataset_with_train_and_test.txt",sep=";",col.names=T, row.names=F)

# Question2 ---------------------------------------------------------------
# Extracts only the measurements on the mean and standard deviation for each measurement. 

for(i in 1:length(feature_vect))
{
  m_value <- mean(dataset[,i])
  sd_value <- sd(dataset[,i])
  
  print(paste0(feature_vect[i],": Mean: ",m_value,"; SD: ",sd_value))
}


# Question3 ---------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set

test_activity <- readLines(con="./y_test.txt")
length(test_activity)
train_activity <- readLines(con="./y_train.txt")
length(train_activity)

# vado a sostituire i valori numerici con le labels
# leggo le labels:
lbl <- read.table(file="./activity_labels.txt", sep=" ",head=F)
colnames(lbl) <- c("id","Activity")

lst_activity <- c(train_activity, test_activity)
lst_activity <- as.data.frame(lst_activity)
colnames(lst_activity) <- "id"

activity <- join(x=lst_activity, y=lbl, by="id")
head(activity)
activity <- activity[,'Activity']

dataset_elab <- cbind(activity, dataset)
summary(dataset_elab)
colnames(dataset_elab)


# Question5 ---------------------------------------------------------------

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(sqldf)
new_feature_vect <- c("activity",feature_vect)
length(new_feature_vect)

ds_activity_walking <- dataset_elab[dataset_elab$activity == "WALKING",]
activity_walking <- "WALKING"
for(i in 2:length(new_feature_vect))
{
  m_value <- mean(ds_activity_walking[,i])
  activity_walking <- c(activity_walking, m_value)
}

ds_activity_walking_upstairs <- dataset_elab[dataset_elab$activity == "WALKING_UPSTAIRS",]
activity_walking_upstairs <- "WALKING_UPSTAIRS"
for(i in 2:length(new_feature_vect))
{
  m_value <- mean(ds_activity_walking_upstairs[,i])
  activity_walking_upstairs <- c(activity_walking_upstairs, m_value)
}

ds_activity_walking_downstairs <- dataset_elab[dataset_elab$activity == "WALKING_DOWNSTAIRS",]
activity_walking_downstairs <- "WALKING_DOWNSTAIRS"
for(i in 2:length(new_feature_vect))
{
  m_value <- mean(ds_activity_walking_downstairs[,i])
  activity_walking_downstairs <- c(activity_walking_downstairs, m_value)
}

ds_activity_walking_sitting <- dataset_elab[dataset_elab$activity == "SITTING",]
activity_walking_sitting <- "SITTING"
for(i in 2:length(new_feature_vect))
{
  m_value <- mean(ds_activity_walking_sitting[,i])
  activity_walking_sitting <- c(activity_walking_sitting, m_value)
}

ds_activity_walking_standing <- dataset_elab[dataset_elab$activity == "STANDING",]
activity_walking_standing <- "STANDING"
for(i in 2:length(new_feature_vect))
{
  m_value <- mean(ds_activity_walking_standing[,i])
  activity_walking_standing <- c(activity_walking_standing, m_value)
}

ds_activity_walking_laying <- dataset_elab[dataset_elab$activity == "LAYING",]
activity_walking_laying <- "STANDING"
for(i in 2:length(new_feature_vect))
{
  m_value <- mean(ds_activity_walking_laying[,i])
  activity_walking_laying <- c(activity_walking_laying, m_value)
}


activity_avg <- rbind(activity_walking, activity_walking_upstairs, activity_walking_downstairs, activity_walking_sitting,
                      activity_walking_standing, activity_walking_laying)