
# GETTING AND CLEANING DATA

the first point is:
##"Merges the training and the test sets to create one data set."

looking txt files seems that not all rows are separated in the same way (for example some values are saperate with "  " double space and other with a single space) so i read all txt files, for each lines of files i use gsub to transform double spaces to single space, save to txt files and read this news files with read.table and using sep=" ".

to merge datasets i use rbind() function

the question 2 is:
## "Extracts only the measurements on the mean and standard deviation for each measurement."

for each features i execute a print with mean and sd of that feature column

question 3 and 4 are:
## Uses descriptive activity names to name the activities in the data set
and
## Appropriately labels the data set with descriptive variable names.

i read activity_labels.txt activity and y test file and y train file. 
first i merge y train and y test and then i make a join with activity_labels.txt to add activities name.

then (point 4) i make dataset_elab with all dataset (train and test) and then new column of activities,

question 5 is:
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

for each activity i get a subset for each subset and foreach features i calculate mean then
all results are bind with rbind() and so the new dataset is done


in run_analysis.R there is all the code