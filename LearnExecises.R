library(caret)

raw <- read.csv("data/pml-training.csv", stringsAsFactors=FALSE)
validate <- read.csv("data/pml-testing.csv", stringsAsFactors=FALSE)

tidydata <- raw[,-c(1)]

set.seed(38484)

tindex <- createDataPartition(y=tidydata$classe, p=0.6, list=FALSE)
training <- tidydata[tindex,]
testing <- tidydata[-tindex,]

numColsIdx <- sapply(training, is.numeric)
numCols <- training[,numColsIdx]

corMartrix <- cor(numCols, use="pairwise.complete.obs")
corCols <- findCorrelation(corMartrix)
numZero <- nearZeroVar(numCols)

rmCols <- union(corCols, numZero)

training <- training[,-rmCols]

nonNACols <- unname(sapply(training, function(x){ sum(is.na(x)) <= 0 }))

training <- training[,nonNACols]

training <- training[,!grepl("#DIV", training)]

training$classe <- as.factor(training$classe)
training$user_name <- as.factor(training$user_name)
training$new_window <- as.factor(training$new_window)

fitModel <- train(classe ~ ., data=training, method="rf")
trainAccuracy <- fitModel$results$Accuracy[1]

predictTest <- predict(fitModel, newdata=testing)
testAccuracy <- sum(testing$classe == prf)/length(testing$classe)

submissionPrediction <- predict(fitModel, newdata=validate)


