# HW 6 - Due Tuesday October 18, 2016 in moodle and hardcopy in class. 
# Upload R file to Moodle with name: HW5_490IDS_YourClassID.R
# Do not remove any of the comments. These are marked by #

# Please ensure that no identifying information (other than your class ID) 
# is on your paper copy, including your name


# We will use the bootstrap technique to generate confidence intervals

# 1. Suppose we have a sample of data from an exponential distribution 
# with parameter lambda. In this case use lambda.hat = 1/mean(X). 

# As the number of observations increases, does the estimate for lambda 
# become roughly normally distributed? We will answer this question in
# the following parts.

# 1a. (1) Generate 100 observations of test data, with lambda=3. Remember
# to set your seed before carrying out any computations.
set.seed(0)
lambda=3
n=100
expsample <- rexp(100,3)

# 1b. (1) What is the mean of your test data? (give the code and the value)

mean(expsample)
#[1] 0.344049

# 1c. (1) What is your estimate lambda.hat? (give the code and the value)

lambda.hat <- 1/mean(expsample)
lambda.hat
#[1] 2.906563

# 2. Now use the bootstrap to estimate the distribution of 
# lambda.hat and create bootstrap confidence intervals for lambda, 
# rather than the approach in 1).

# 2a. (1) Form a set of bootstrap estimates of our parameter by generating B
# random samples as you did once in 1a but use lambda.hat since we do not
# know the true lambda in this case (keep n=100). Set B=1000, and again set
# your seed.

set.seed(0)
n=100
B=1000
mean_bssample <- replicate(B,1/mean(rexp(n,lambda.hat)))

# 2b. (1) Get a new estimate for lambda.hat from each of the bootstrap samples
# in 2a. You'll want to create a matrix to receive each value. You should 
# have 1000 estimates for lambda.hat now.

matrix_bs <- matrix(mean_bssample)
length(matrix_bs)
#[1] 1000

# 2c. (2) Now look at the sampling distribution for lambda.hat, using the hist
# function. Remember the graphing techniques discussed in class and use them 
# to make the plot look professional. Does the distribution look normal?

hist(matrix_bs,breaks=20,xlim=c(2,4),xlab="lambda.hat",main="Sampling distribution for lambda.hat",col="gray99")
# The distribution looks normal as we can see the histogram is quite symmetrical.

# 2d. (1) Calculate an estimate of the standard error of lambda.hat using your
# collection of bootstrap estimated parameters. What is your confidence interval?

se <- sd(matrix_bs)
se
#[1] 0.3074817
bs_upper <- lambda.hat + qnorm(.975)*se
bs_upper
bs_lower <- lambda.hat - qnorm(.975)*se
bs_lower
# The confidence interval is: [2.323442, 3.489683].

# 3a. (5) We made some decisions when we used the bootstrap above that we can now question. 
# Repeat the above creation of a confidence interval for a range of values of data
# (we had our sample size fixed at 100) and a range of bootstrap values (we had B 
# fixed at 1000). Suppose the sample size varies (100, 200, 300, .... , 1000) and 
# B varies (1000, 2000, ... , 10000). You will likely find it useful to write
# functions to carry out these calculations. Your final output should be 
# upper and lower pairs for the confidence intervals produced using the bootstrap
# method for each value of sample size and B.

# generalize 2b into a function, and vary inputs of sample size and B as we did above.

rm(list = ls()) # clear the environment
set.seed(0)
lambda = 3
lambda.hat <- 1/mean(rexp(100,3))

boot.sample <- function(sample.size, B){
  boot.sample <- matrix(replicate(B, 1/mean(rexp(sample.size,lambda.hat))))
  return(boot.sample)
}

n <- seq(100, 1000, by=100)
B <- seq(1000, 10000, by=1000)

bssample <- lapply(n, function(sample.size) lapply(B, function(B) boot.sample(sample.size, B)))
quantiles <- lapply(bssample, function(x) lapply(x, function(y) quantile(y,c(.025,0.975))))
CIlimits <- array(data=unlist(quantiles), c(2,10,10), list(c("Lower", "Upper"), B, n))
CIlimits

# 3b. (2) Plot your CI limits to show the effect of changing the sample size and 
# changing the number of bootstrap replications. What do you conclude?

w <- data.frame(CIlimits)
CIUpper <- w[!c(TRUE,FALSE),]
CIUpper
CILower <- w[c(TRUE,FALSE),]
CILower
CIUpper.v <- as.vector(unlist(CIUpper))
CILower.v <- as.vector(unlist(CILower))
plot(CIlimits)
#As we can see, as the number of bootstrap increase, the confidence interval decrease as the lower limit increases, and the upper limit decrease. 
#The changing in the sample size do not affect much. 
#The CI limits are approaching 3.0 as the number of bootstrap increase.


# 4a. (5) In 1961 John Tukey wrote an article called The Future of Data Analysis 
# (it is uploaded in moodle). Some people say it is prophetic regarding the 
# field of Data Science today. Do you agree or disagee? Why or why not? (Please 
# keep your answer less than 500 words).

#I agree that John Tukey’s article is prophetic regarding the field of Data Science today. First, as a statistician, Dr. Tukey realize the important of data analysis as a science just like mathematics by pointing out it as a ubiquitous problem that has intellectual content, organization into an understandable form, and reliance upon the test of experience as the ultimate standard of validity. It gives a lot of disciplines that shows the close connection between statistics, mathematics and data analysis. It brings the question of “what is data science” without actually define data analysis as data science, but it gives insights on how to practice data analysis and the importance of it. Dr. Tukey also talks about factor analysis to emphasize the complexity and dispersion of data.

#Especially in the eighth chapter: How shall we proceed?, Dr. Tukey talks about the necessary tools for us to actually conduct data analysis, and the relative statistical methods that could also be carry out during data analysis. One of his point that I strongly agree and I believe is prophetic is that, he mentions the need for iterative procedures in data analysis. As we learn in this class, functions and for loops all allow us to conduct quite straightforward calculation and also avoid repeated computation. Data science as said by Dr. Tukey, is an empirical science as it does involves empirical sampling. 

#Another important part of this book is that it emphases the importance of computer. It recognizes computers’ impact on storing data, saving massive time on computation and more accuracy it brings.


# 4b. (5) Relate the article to the Life Cycle of Data discussion from class. 
# You may wish to choose an example or idea from the article and clearly explore how it 
# relates to the Life Cycle of Data. (Please keep your answer less than 500 words).

#In Dr. Tukey’s article, he mentions the dangers of optimization in the introduction part. In his point of view, data analysis go through the natural chain of growth of five mains stages. A1’ recognition of problem, a1” one technique used, a2 competing techniques used, a3 rough comparisons of efficacy, a4 comparison in terms of a precise (and thereby inadequate) criterion, a5’ optimization in terms of a precise, and similarly inadequate criterion, a5” comparison in terms of several criteria. One of the two main commandments in connection with these problems is to urge the extension of work from each stage to the next, with special emphasis on the earlier stage. He pointed out that the earlier stage of the cycle of data analysis is as important as the later stages of analysis valued by statisticians. This is the same as what we learn in the life cycle of data. The collection and acquisition stage of data, as the very first stage, actually plays an important role for researchers to understand the original source, and maximize the potential for reusing and preservation of data over time. 

#In addition, as we know that data analysis and visualization of based on the existing dataset we collected, thus the errors can comes from both the original data and human-errors. Dr. Tukey also states similar point in his article. He said that, “Danger only comes from mathematical optimizing when the results are taken too seriously.” That being said, data analysis provides us guidance through the process more than just a final result. Another factor is that people based upon the historical circumstances than upon today’s condition, which means that even after the research is completed and data is archived, people may still use it in the future, and when they do, they would not only just look at the answer. With different conditions and factors change, we need to know the criteria set for the data in the first place, how do we filter and narrow down the dataset for study. Thus, listing out all the stages can help future researchers to have more understanding of the data analysis. 










	