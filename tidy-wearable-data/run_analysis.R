
##  
##  Gets the required data from the internet and unzips it to a data directory
##
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

##
##  Merge the training and test data sets together
##
mergeData <- function() {
  # read in the features file, these represent the variable or column names
  features = read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
  names(features) = c("id", "name")
  
  # read in the labels file, these represent the names of the activities
  activities = read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
  names(activities) = c("id", "activity")
  
  # read in the test measurements, activities and subjects
  test_data = read.table("data/UCI HAR Dataset/test/X_test.txt")
  test_labels = read.table("data/UCI HAR Dataset/test/y_test.txt")
  test_subjects = read.table("data/UCI HAR Dataset/test/subject_test.txt")
  # add subject column to main test data
  test_data$subject <- test_subjects[[1]]
  # add activity id column to main test data
  test_data$activityid <- test_labels[[1]]
  
  # perform the same procedure on training data
  train_data = read.table("data/UCI HAR Dataset/train/X_train.txt")
  train_labels = read.table("data/UCI HAR Dataset/train/y_train.txt")
  train_subjects = read.table("data/UCI HAR Dataset/train/subject_train.txt")
  train_data$subject <- train_subjects[[1]]
  train_data$activityid <- train_labels[[1]]
  
  # join the training and test together
  mdata <- rbind(train_data, test_data)
  
  # merge the activity names into the main data, in their own column
  mdata <- merge(mdata, activities, by.x="activityid", by.y="id")
  # use the proper column names from the features file
  names(mdata) <- c("activityid", features[[2]], "subject", "activity")
  # return merged data set
  mdata
}

###
### Extracts the required columns from the full data set and improves the column names
###
extractData <- function(data) {
  # get the columns that contain only mean() or std()
  msCols = grep("(mean|std)\\(\\)", names(data), value=TRUE, ignore.case=TRUE)
  # extract out only those columns
  xdata = data[c(msCols, "subject", "activity", "activityid")]
  
  xnames = names(xdata)
  # change the names to all lower case
  xnames = tolower(xnames)
  # tidy up the names, remove () and make it clear what X,Y,Z refer to
  xnames = sub("\\(\\)", "", xnames)
  xnames = sub("-(\\w+)-([XYZ])$", "_\\2-axis_\\1", xnames, ignore.case=TRUE)
  xnames = sub("-([^a])", "_\\1", xnames)
  
  # set the new column names
  names(xdata) <- xnames
  xdata
}

##
##  Create the required tidy data set
##
createTidySet <- function(data) {
  # melt the data set to long format
  melted = melt(data, c("activityid","activity","subject"))
  # recast to wide format based on subject and activity, aggregating the mean for each column
  recast = dcast(melted, subject + activity + activityid ~ variable, fun.aggregate=mean)
  # write tidy data to a csv file (removing the row number information)
  write.csv(recast, "tidydata.csv", row.names=FALSE)
}

##
## Run all the methods to make a tidy data set
##
tidydata <- function() {
  library(reshape2)
  getData()
  md = mergeData()
  ed = extractData(md)
  createTidySet(ed)
}

