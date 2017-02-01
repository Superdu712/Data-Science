# HW 4 Due Tuesday Sept 27, 2016. Upload R file to Moodle with name: HW2_490IDS_YOUR_CLASSID.R
# Notice we are using the new system with your unique class ID. You should have received an email with
# your unique class ID. Please make sure that ID is the only information on your hw that identifies you. 
# Do not remove any of the comments. These are marked by #

# Name: Danning Du

### Part 1: Linear Regression Concepts
## These questions do not require coding but will explore some important concepts
## from lecture 5.

## "Regression" refers to the simple linear regression equation:
##    y = B0 + B1*x
## This homework will not discuss any multivariate regression.

## 1. (1 pt)
## What is the interpretation of the coefficient B1? 
## (What meaning does it represent?)

## Your answer: Coefficient B1 is the slope of the linear regression line. B1 represents the difference in the predicted value of y for each one-unit difference in x. When B1 equals 0, the fitted line is flat.

## 2. (1 pt)
## If the residual sum of squares (RSS) of my regression is exactly 0, what does
## that mean about my model?

## Your answer: If RSS equals 0, the predicted values of y are equal to the actual y (mean value of y). In this case, the fitted line is a horizontal line, and the predictor x, cannot linearly predict the y value.

## 3. (2 pt)
## Outliers are problems for many statistical methods, but are particularly problematic
## for linear regression. Why is that? It may help to define what outlier means in this case.
## (Hint: Think of how residuals are calculated)

## Your answer: Outliers are high leverage data points that fall horizontally away from the center of the cloud. The observed values for these points are very different from that predicted by the regression model.
## Residual is the vertical distance between the predicted value y and the observed y on the regression line. Outlier has a large residual, so the least square line regression is particularly vulnerable to outliers beacuse the distance to the best-fit line is squared when calculating residuals, which amplifies the influence of the farthest points.

### Part 2: Sampling and Point Estimation

## The following problems will use the ggplot2movies data set and explore
## the average movie length of films in the year 2000.

## Load the data by running the following code
install.packages("ggplot2movies")
library(ggplot2movies)
data(movies)

## 4. (2 pts)
## Subset the data frame to ONLY include movies released in 2000.

movies <- movies[movies$year == 2000,]

## Use the sample function to generate a vector of 1s and 2s that is the same
## length as the subsetted data frame. Use this vector to split
## the 'length' variable into two vectors, length1 and length2.

## IMPORTANT: Make sure to run the following seed function before you run your sample
## function. Run them back to back each time you want to run the sample function.


## Check: If you did this properly, you will have 1035 elements in length1 and 1013 elements
## in length2.

set.seed(1848)
movies_sample <- sample(c(1,2),2048,replace=TRUE) 
length1 <- split(movies$length,movies_sample)[1]
length2 <- split(movies$length,movies_sample)[2]

summary(length1)
summary(length2)

## 5. (3 pts)
## Calculate the mean and the standard deviation for each of the two
## vectors, length1 and length2. Use this information to create a 95% 
## confidence interval for your sample means. Compare the confidence 
## intervals -- do they seem to agree or disagree?

length1 <- as.numeric(unlist(length1))
length2 <- as.numeric(unlist(length2))

mean1 <- mean(length1)
mean1
sd1 <- sd(length1)
sd1
n1 <- length(length1)
n1
mean2 <- mean(length2)
mean2
sd2 <- sd(length2)
sd2
n2 <- length(length2)
n2

error1 <- qnorm(.975)*sd1/sqrt(n1)
error1
left1 <- mean1 - error1
right1 <- mean1 + error1
c(left1,right1)

error2 <- qnorm(.975)*sd2/sqrt(n2)
error2
left2 <- mean2 - error2
right2 <- mean2 + error2
c(left2,right2)

## Your answer here: The 95% confidence interval of length1 is [75.89488,80.77758], for length 2 is [77.59929,82.44218]. They seem to agree.

## 6. (4 pts)
## Draw 100 observations from a standard normal distribution. Calculate the sample mean.
## Repeat this 100 times, storing each sample mean in a vector called mean_dist.
## Plot a histogram of mean_dist to display the sampling distribution.
## How closely does your histogram resemble the standard normal? Explain why it does or does not.

norm <- rnorm(100)
mean(norm)

mean_dist <- rep(NA,100)
for (i in 1:100){
    norm <- rnorm(100)
    mean_dist[i] <- mean(norm)
    }
mean_dist
hist(mean_dist)
## Your answer here: The histogram resembles very closely to the standard normal distribution. As the center of mass is close to the true mean, thus we can see that, in the long run, the sample mean is even closer to the population mean.

## 7. (3 pts)
## Write a function that implements Q6.

## Your answer here

HW.Bootstrap=function(distn,n,reps){
  set.seed(1848)
  bootstrap_mean <- rep(NA,reps)
  for (i in 1:reps){
    distn
    bootstrap_mean[i] <- mean(distn)
  }
}
hist(bootstrap_mean)

### Part 3: Linear Regression
## This problem will use the Boston Housing data set.
## Before starting this problem, we will declare a null hypthosesis that the
## crime rate has no effect on the housing value for Boston suburbs.
## That is: H0: B1 = 0
##          HA: B1 =/= 0
## We will attempt to reject this hypothesis by using a linear regression

# Load the data
housing <- read.table(url("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"),sep="")
names(housing) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV")

## 7. (2 pt)
## Fit a linear regression using the housing data using CRIM (crime rate) to predict
## MEDV (median home value). Examine the model diagnostics using plot(). Would you consider this a good
## model or not? Explain.

fit <- lm(MEDV~CRIM,data=housing)
fit

plot(MEDV~CRIM,data=housing, xlab = "Crime Rate", ylab = "Median Home Value")
abline(fit)
summary(fit)

## I do not consider it as a good model. The linear model appears to be a pretty good fit to the data in the CRIM range of 0-40. However, the overall relationship between Crime Rate and Median Home Value appears to be overall non-linear, and the model does not explain how the Median Home Value changes from 10-50 when the Crime Rate is 0.

## 8. (2 pts)
## Using the information from summary() on your model, create a 95% confidence interval 
## for the CRIM coefficient 

summary(fit)$coefficients
c <- summary(fit)$coefficients[2, 1]
e <- summary(fit)$coefficients[2, 2]
t <- qt(0.975, summary(fit)$df[2])
low <- c - t*e
high <- c + t*e
c("2.5%"=low,"97.5%"=high)

## 9. (2 pts)
## Based on the result from question 8, would you reject the null hypothesis or not?
## (Assume a significance level of 0.05). Explain.

## Your answer: We can reject the null hypothesis. As the confidence interval we calculated above does not contain the null hypothesis value, the results are statistically significant. Also, since the p-value 2.2e-16 is a very very small number less than your significance level 0.05, indicating that your test can reject the null hypothesis with a high degree of significant.

## 10. (1 pt)
## Pretend that the null hypothesis is true. Based on your decision in the previous
## question, would you be committing a decision error? If so, which one?

## Your answer: Yes, rejecting null hypothesis when it is true and in favor of the alternative hypothesis will result in a Type 1 Error.

## 11. (1 pt)
## Use the variable definitions from this site:
## https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.names
## Discuss what your regression results mean in the context of the data (using appropriate units)
## (Hint: Think back to Question 1)

## Your answer: In this model, CRIM has negative coefficient -0.4151903, it tells us that the Median value of owner-occupied homes in $1000's will decrease by 0.4151903 for 1 capita increase in the crime rate by town. 

## 12. (2 pt)
## Describe the LifeCycle of Data for Part 3 of this homework.

## 1. Discovery: We will use the Boston Housing data set and the null hypothesis given to do a linear regression analysis.
## 2. Data Preparation: Acquire the data set by loading the data into RStudio.
## 3. Model Building: Build a linear regression model using CRIM to predict MEDV in the housing data.
## 4. Visualizing Data: Use plot function to display the output of the model built. 
## 5. Performing analytics over data: Use summary function to create confidence interval for CRIM coefficient.
## 6. Evaluation and Interpretation: Use result from summary to evaluate whether to reject the null hypothesis. Finally, interprating the regression result from the machine learning database of the housing dataset.

