# HW 3 - Due Tuesday Sept 20, 2016. Upload R file to Moodle with name: HW3_490IDS_YOURNETID.R
# Do Not remove any of the comments. These are marked by #
# The .R file will contain your code and answers to questions.

#Name: Danning Du

# Main topic: Using the "apply" family function

#Q1 (5 pts)
# Given a function below,
myfunc <- function(z) return(c(z,z^2, z^3%/%2))
#(1) Examine the following code, and briefly explain what it is doing.
y = 2:8
myfunc(y)
matrix(myfunc(y),ncol=3)
### Your explanation: myfunc(y) with y=2:8 generates a list of elements with the value of c(y,y^2, y^3%/%2)) that fill the matrix, ncol=3 specify the dimension of the matrix, which means the matrix has 3 columns. nrow is not specified in this code, so it is made to infer it from the length of data.
#(2) Simplify the code in (1) using one of the "apply" functions and save the result as m.
###code & resultt

m <- t(apply(matrix(y),1,myfunc))
m
#       [,1] [,2] [,3]
# [1,]    2    4    4
# [2,]    3    9   13
# [3,]    4   16   32
# [4,]    5   25   62
# [5,]    6   36  108
# [6,]    7   49  171
# [7,]    8   64  256

#(3) Find the row product of m.
###code & result

apply(m,1,prod)
# [1]     32    351   2048   7750  23328  58653 131072

#(4) Find the column sum of m in two ways.
###code & result

apply(m,2,sum)
# [1]  35 203 646

colSums(m)
# [1]  35 203 646

#(5) Could you divide all the values by 2 in two ways?
### code & result

m/2
#     [,1] [,2]  [,3]
# [1,]  1.0  2.0   2.0
# [2,]  1.5  4.5   6.5
# [3,]  2.0  8.0  16.0
# [4,]  2.5 12.5  31.0
# [5,]  3.0 18.0  54.0
# [6,]  3.5 24.5  85.5
# [7,]  4.0 32.0 128.0

t(sapply(y,myfunc))/2
#     [,1] [,2]  [,3]
# [1,]  1.0  2.0   2.0
# [2,]  1.5  4.5   6.5
# [3,]  2.0  8.0  16.0
# [4,]  2.5 12.5  31.0
# [5,]  3.0 18.0  54.0
# [6,]  3.5 24.5  85.5
# [7,]  4.0 32.0 128.0

#Q2 (8 pts)
#Create a list with 2 elements as follows:
l <- list(a = 1:10, b = 11:20)
#(1) What is the product of the values in each element?

lapply(l,prod)
#$a
#[1] 3628800

#$b
#[1] 670442572800

# The product of the values in element a is 3628800, in element b is 670442572800.

#(2) What is the (sample) variance of the values in each element?

lapply(l,var)
#$a
#[1] 9.166667

#$b
#[1] 9.166667

#The (sample) variance of the values in element a is 9.166667, in element b is 9.166667.

#(3) What type of object is returned if you use lapply? sapply? Show your R code that finds these answers.

class(lapply(l,prod))
# [1] "list"
class(lapply(l,var))
# [1] "list"

class(sapply(l,prod))
# [1] "numeric"
class(sapply(l,var))
# [1] "numeric"

# Use lapply: list is returned. Use sapply: numeric is returned.

# Now create the following list:
l.2 <- list(c = c(21:30), d = c(31:40))
#(4) What is the sum of the corresponding elements of l and l.2, using one function call?

mapply(sum, l$a, l$b, l.2$c, l.2$d)
# [1]  64  68  72  76  80  84  88  92  96 100

#(5) Take the log of each element in the list l:

rapply(l,log)

#(6) First change l and l.2 into matrixes, make each element in the list as column,
### your code here

l <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
colnames(l) <- c("a","b")
l

l.2 <- matrix(c(21:30, 31:40), nrow = 10, ncol = 2)
colnames(l.2) <- c("c","d")
l.2

#Then, form a list named mylist using l,l.2 and m (from Q1) (in this order).
### your code here

mylist <- list(l,l.2,m)

#Then, select the first column of each elements in mylist in one function call (hint '[' is the select operator).
### your code here

lapply(mylist,'[',,1)

#Q3 (3 pts)
# Let's load our friend family data again.
load(url("http://courseweb.lis.illinois.edu/~jguo24/family.rda"))
#(1) Find the mean bmi by gender in one function call.

tapply(fbmi,fgender,mean)
#        m        f 
# 25.73898 23.02564 

#(2) Could you get a vector of what the type of variables the dataset is made of？

rapply(family,class)

#(3) Could you sort the firstName in height descending order?

family[order(fheight,decreasing=TRUE),c("firstName","height")]

#Q4 (2 pts)
# There is a famous dataset in R called "iris." It should already be loaded
# in R for you. If you type in ?iris you can see some documentation. Familiarize 
# yourself with this dataset.
#(1) Find the mean petal length by species.
### code & result

tapply(iris$Petal.Length,iris$Species,mean)
# setosa versicolor  virginica 
#  1.462      4.260      5.552 

#(2) Now obtain the sum of the first 4 variables, by species, but using only one function call.
### code & result

by(iris[,1:4],iris$Species,colSums)
# iris$Species: setosa
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 250.3        171.4         73.1         12.3 
# ---------------------------------------------------------------------------- 
# iris$Species: versicolor
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 296.8        138.5        213.0         66.3 
# ---------------------------------------------------------------------------- 
# iris$Species: virginica
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 329.4        148.7        277.6        101.3 

#Q5 (2 pts)
#Below are two statements, their results have different structure, 
lapply(1:4, function(x) x^3)
sapply(1:4, function(x) x^3)
# Could you change one of them to make the two statements return the same results (type of object)?

# Change lapply(1:4, function(x) x^3) to:
as.numeric(lapply(1:4, function(x) x^3))
# [1]  1  8 27 64
# Which is the same as:
sapply(1:4, function(x) x^3)
# [1]  1  8 27 64

#Q6. (5 pts) Using the family data, fit a linear regression model to predict 
# weight from height. Place your code and output (the model) below. 

fit <- lm(weight~height,data=family)
fit

# How do you interpret this model?

summary(fit)
plot(weight~height,data=family)
abline(fit)

# From this output, we have determined that the intercept is -455.666 and the coefficient for fheight is 9.154. Therefore, the complete regression equation is fweight = -455.666 + 9.154*fheight. This equation tells us that the predicted weight will increase by 9.154 for every 1 unit increase in the height.
# As the p-value 9.287e-05 is much less than 0.05, we reject the null hypothesis that β = 0. Hence there is a significant relationship between height and weight in the linear regression model of the data set family.

# Create a scatterplot of height vs weight. Add the linear regression line you found above.

plot(weight~height,data=family, xlab = "Height (inches)", ylab = "Weight (lbs)", xlim=c(60,74), ylim=c(100,220), pch=2, cex=1.0, frame.plot=FALSE, col="blue", main="Weight vs Height")
abline(fit,col="orange")

# Provide an interpretation for your plot.
# There is a positive association between height and weight. As height increases, weight increases. 
# Also, as we can see, the dots are close to the linear regression line, so height and weight have a strong positive correlation.