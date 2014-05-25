Coursera - Data Science specialization
---------------
## My Code Book for the "Getting and cleaning data project" :
In tis code book, I'll describe the data used for this project, the transformations made in the R script **run_analysis.R**, and the variables names.

## Data used :
As mentioned on the Peer Assignment page, "The data linked to from the course website represent data collected from the accelerometers from the **Samsung Galaxy S smartphone**. A full description is available at the [site] [1] where the data was obtained".

## Transformations made :

  - Scan the text files which contain the data.
  - Removing blank characters from the obtained vectors.
  - Creating matrix and data frames with the vectors.
  - Merging the train and test sets as demanded by the exercise.  
  - Giving names to the columns.
  - Extracting only the measurements on the mean and standard deviation as demanded using the grep function.
  - Replacing the labels by human-readable names instead of numbers.
  - Write the text file **final\_data\_1.txt** which contains the first tidy data set. 
  - Melting data to obtain the average of each variable for each activity and each subject. 
  - Write the text file **final\_data\_2.txt** which contains the second tidy data set. 

## Main variables used :
 * Process the data :
  * set\_train / set\_test : String vector scans of X\_train.txt and X\_test.txt files.
  * label\_train / label\_test : same for y\_train.txt and y\_test.txt.
  * subject\_train / subject\_test : same for subject\_train.txt and subject\_test.txt.
  * features : same for features.txt.
  * activity\_labels : same for activity\_labels.txt.
 * Getting matrix and frames :
  * set\_train\_frame and set\_test\_frame : data frames variables obtained with the set vectors.
  * label : numeric matrix from the vectors label\_train and label\_set
  * features : Vectors with the names of the features.
 * Extraction of the mean and standard deviation :
  * set\_extract : set where all the column with -mean() and -std() were kept.
  * features\_extract : same for the features.
 * Rename the labels with human-readable names :
  * label\_name : String vector with human-readable names for the activities.
  * label\_name\_frame : Frame made from this vector.
 * Merging the sets and the labels :
  * final\_data\_1 : cbind of the set and the activities.
 * Second tidy set : 
  * final\_melt : second tidy data set.

## Files :
 * **final\_data\_1.txt** : First tidy data set.
 * **final\_data\_2.txt** : Second tidy data set.

## More complementary information :
Look at the file README.md in the repo.


  [1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones