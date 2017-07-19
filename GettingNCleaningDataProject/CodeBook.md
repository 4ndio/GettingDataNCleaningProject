## Variable used in run_analysis R script
activityLabels holds the 6 different activities like Walking, Walking_Upstairs etc
features holds all the different measurements collected for each activity
featuredFiltered holds the index for each of the measurements relating to Mean or Standard deviation
featuresFiltered.names holds the labels/names of the measurements

train and test hold the clean data for each of the sets against the subjects and activity
allData holds the data of combined train and test sets.
allData mean eventually is the source of the tidy data set which holds the average of each variable for each activity and each subject


## Transformations used
to obtain just the needed measurements/features, script use grep function
to name the features in a more appropriate way, script uses gsub function to eliminate special characters
cbind function is used to include the Subjects and Activities columns sagainst the train records
rbind function is used to merge the train and test datasets