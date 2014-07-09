## nothing here yet

# X - Download and extract dataset.
# X - Merges the training and the test sets to create one data set.
# X - Extracts only the measurements on the mean and standard deviation 
#     for each measurement. 
# X - Uses descriptive activity names to name the activities in the data set
# X - Appropriately labels the data set with descriptive variable names. 
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

# TODO: possible problem with activity matching up,also maybe subject?
mergeData <- function() {
  features = read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
  labels = read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
  
  test_data = read.table("data/UCI HAR Dataset/test/X_test.txt")
  test_labels = read.table("data/UCI HAR Dataset/test/y_test.txt")
  test_subjects = read.table("data/UCI HAR Dataset/test/subject_test.txt")
  
  test_activities = merge(test_labels, labels, by.x="V1", by.y="V1", sort=FALSE)
  
  test_data$subject <- test_subjects[[1]]
  test_data$activity <- test_activities[[2]]
  
  train_data = read.table("data/UCI HAR Dataset/train/X_train.txt")
  train_labels = read.table("data/UCI HAR Dataset/train/y_train.txt")
  train_subjects = read.table("data/UCI HAR Dataset/train/subject_train.txt")
  
  train_activities = merge(train_labels, labels, by.x="V1", by.y="V1", sort=FALSE)
  
  train_data$subject <- train_subjects[[1]]
  train_data$activity <- train_activities[[2]]
  
  mdata <- rbind(train_data, test_data)
  names(mdata) <- c(features[[2]], "subject", "activity")
  mdata
}

extractData <- function(data) {
  msCols = grep("(mean|std)\\(\\)", names(data), value=TRUE, ignore.case=TRUE)
  xdata = data[c(msCols, "subject", "activity")]
  xnames = names(xdata)
  xnames = tolower(xnames)
  xnames = sub("\\(\\)", "", xnames)
  xnames = sub("-(\\w+)-([XYZ])$", "_\\2-axis_\\1", xnames, ignore.case=TRUE)
  xnames = sub("-([^a])", "_\\1", xnames)
  names(xdata) <- xnames
  xdata
}
