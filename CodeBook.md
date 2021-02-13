Code Book 

In this file I will explain the codes in "run_analysis_final.R". The file has a series of codes that cleans and presents the data in a better way.
It is divided in the following steps:

1. Loading the required packages
Package "dplyr" and "data.table" were used.

2. Downloading the data
The data was presented in a .zip file, so it had to be downloaded and unzipped to use it.

3. Reading the data
The data was presented in a .txt file. In order to read the data, I used "read.table" and assigned names to the columns with "col.names", since they were not named.

4. Merging the datasets
Since the data had a section x, y and subject  were divided in "test" and "train", I merged the data in a single table. First I merged x_train with x_test using "rbind".
After, I did the same with y_test and y_train and also with subject_train and subject_test. 
Finally, I merged the three variables in a single dataframe called DataMerged, with the function cbind.

5. Extracting the important measurements
Only the measuremnets that include "mean" and "std" were relevant, so I extracted those with the select and contains functions. This was stored in ImportantData.

6. Descriptive names to label the activities
The label for activities were improved, since they were not good. The codes that were in the other datasets were used.

7. Label the data with descriptive names
Labelled the data with names that were useful, since the names from the codes were not descriptive. This was done with gsub and names functions.

8. Created a new tidy variable with the average of each variable for each activity and subject.
This was done grouping activities and subjects with group_by and after the average was found with summarise_all and the mean function. This was stored in GoodData
Later, I wrote a table with the data and saved in a .txt file with write.table.
Finally, we can look at the table with the View() function.

Files of the script:

features: (561 obs of 2 variables) features.txt They are the features of movement given in the dataset.

activities: (6 obs of 2 variables) activity_labels.txt. The activities performed by the people that participated in the experiment, it also contains its codes.

subject_test: (2947 of 1 variable) subject_test.txt. The data of the 30 volunteers were divided in test and train. The test section contains the data of 9/30 volunteers. 

x_test: (2947 of 1 variable) subject_test.txt. The data of the 30 volunteers were divided in test and train. The test section contains the data of 9/30 volunteers.

y_test: (7352 of 1 variable) subject_test.txt. The data of the 30 volunteers were divided in test and train. The test section contains the data of 9/30 volunteers.

subject_train: (7352 obs of 1 variable) subject_train.txt. The data of the 30 volunteers were divided in test and train. The train section contains the data of 21/30 volunteers. 

x_train: (7352 obs of 1 variable) subject_train.txt. The data of the 30 volunteers were divided in test and train. The train section contains the data of 21/30 volunteers. 

y_train: (7352 obs of 1 variable) subject_train.txt. The data of the 30 volunteers were divided in test and train. The train section contains the data of 21/30 volunteers. 
