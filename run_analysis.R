## nothing here yet

# X - Download and extract dataset.
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation 
#     for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - Creates a second, independent tidy data set with the average of each 
#     variable for each activity and each subject. 

getData <- function () {
  url = "https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
  dir = "data"
  # create temporary file
  temp <- tempfile()
  # download dataset from url
  download.file(url, temp)
  # check data dir exists
  if (!file.exists(dir)) {
    # and create it if it doesn't
    dir.create(dir)
  }
  # unzip the contents into data dir
  unzip(temp, exdir=dir)
}

mergeData <- function() {
  features = read.table("data/UCI HAR Dataset/features.txt")
  test_data = read.table("data/UCI HAR Dataset/test/X_test.txt")
  test_labels = read.table("data/UCI HAR Dataset/test/y_test.txt")
}
