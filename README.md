# Predicting Activity Quality with Sensors

An exploration and analysis of machine learning techniques on a Human Activity Recognition (HAR) dataset. The project analyses weight lifting technique using sensors attached to the body and exercise equipment.

The data set used can be found at - [Groupware@LES](http://groupware.les.inf.puc-rio.br/har#weight_lifting_exercises). The related [paper](http://groupware.les.inf.puc-rio.br/public/papers/2013.Velloso.QAR-WLE.pdf) describes the techniques the group used to predicate correct technique and other related issues.

This project is an assignment as part of the Coursera [Practical Machine Learning](https://www.coursera.org/course/predmachlearn) course. The Goal is to use the data above to explore machine learning techniques and create a machine learning model to predict activity quality from sensors.

## Initial Data Analysis and Cleaning
- The first thing to do was import the data files. After that the first column, *X*, containing row numbers was removed. A seed was also set at this stage to ensure repeatability.
- Having a reasonably large data set like this, it was decided to split the initial training data 60:40 into a train and test set. Leaving the original testing set as a validation set.
- Focus then turned to removing useless attributes in the data set. First, `findCorrelation()` was used on the numeric attributes to find highly correlated variables, these highly correlated variables were then removed. In addition, variables that had values with little variation were found with `nearZeroVar()` and also removed.
- Attributes containing all *NA*'s or having strange values such as *#DIV* were removed next. This left us with a more manageable 37 variables from the 160 in the original data set. Finally, the character vectors were converted into factors.

## Machine Learning Model Creation
- After some playing around with different algorithms (regression, decision-trees), it was found that the accuracy results were not great, averaging about 50% accuracy.
- It was then decided to try a Random Forest algorithm using *caret* the *rf* method. This proved to be a highly accurate algorithm for prediction. It is also a bonus that cross-validation is not needed to validate the model as it is done internally.

## Model Testing and Validation
- The reported accuracy on the training set was 99%
- Using the model to predict on the testing set verified this with an accuracy of 99%
- The validation set produced 100% accuracy upon submitting the results online