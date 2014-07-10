Tidy DataSet Creation
==================

Scripts and documentation for creating a tidy dataset from wearable computing sensor data. The source data can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Usage

- The first step is to install the [reshape2](http://cran.r-project.org/web/packages/reshape2/index.html) package using
```R
install.packages("reshape2")
```
- Next set the working directory and then import the functions into the R environment
```R
setwd("<download_dir>")
source("run_analysis.R")
```
- To create the tidy data file, *tidydata.csv*, simply run
```R
tidydata()
```
- To read the file back into R use
```R
data <- read.csv("tidydata.csv")
```
- It is also possible to run the process in a number of smaller steps after the script has been sourced:
	1. load the reshape2 library ``library(reshape2)``
	2. run ``getData()`` to download the data from the internet
	3. run ``md <- mergeData()`` to merge the train and test data together
	4. run ``ed <- extractData(md)`` to extract the relevant variables and rename the columns
	5. finally run ``createTidySet(ed)`` to create and write the tidy data to disk