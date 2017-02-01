# HW 1 Due Tuesday Sept 6, 2016. Upload R file to Moodle with name: HW1_490IDS_YOURUNI.R
# Do Not remove any of the comments. These are marked by #

###Name: Danning Du

# Load the data for this assignment into your R session 
# with the following command:

load(url("http://courseweb.lis.illinois.edu/~jguo24/SFTemps.rda"))

# Check to see that the data were loaded by running:
objects()
# This should show five variables: dates, dayOfMonth, month, temp, and year

# Use the length() function to find out how many observations there are.
length(dates)
length(dayOfMonth)
length(month)
length(temp)
length(year)

# For the following questions, use one of: head(), summary(),
# class(), min(), max(), hist(), quantile() to answer the questions.

# 1. (1) What was the coldest temperature recorded in this time period?
min(temp,na.rm=TRUE)
# The coldest temperature is 38.3

# 2. (1) What was the average temperature recorded in this time period?
mean(temp,na.rm=TRUE)
#The average temperature is 56.95646

# 3. (2) What does the distribution of temperatures look like, i.e.
# are there roughly as many warm as cold days, are the temps
# clustered around one value or spread evenly across the range
# of observed temperatures, etc.?
hist(temp)
# From the histogram, we can see that the distribution is a bell-shaped curve. 
# The temperatures are mostly clustered between 55 and 60, then 50 and 55, then 60 and 65. 

# 4. (1) Examine the first few values of dates. These are a special
# type of data. Confirm this with class().
head(dates)
# "1995-01-01" "1995-01-02" "1995-01-03" "1995-01-04" "1995-01-05" "1995-01-06"
class(dates)
# "Date"

# 5. (1) We would like to convert the temperature from Farenheit to Celsius.
# Below are several attempts to do so that each fail.  
# Try running each expression in R. 
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with the problem you find in the expression.

(temp -32)
### Error message here: No error message here
### Explanation here: All temperatures (except for NAs) are subtracted by 32. However, this will change all the values of the original variable temp. So we can assign the value of (temp -32) to a new variable called tempA: tempA = (temp -32)

(temp - 32)5/9
### Error message here: Error: unexpected numeric constant in "(temp - 32)5"
### Explanation here: There is no numeric operator between (temp - 32) and 5. To correct this: (temp - 32)*5

5/9(temp - 32)
### Error message here: Error: attempt to apply non-function
### Explanation here: There is no numeric operator between 5/9 and (temp - 32), so R misreads 5/9 as numeric function on the input of (temp - 32). Also we need parentheses for (5/9) to demarcate it to a function. So the correct one goes as: (5/9)*(temp - 32)

[temp - 32]5/9
### Error message here: Error: unexpected '[' in "["
### Explanation here: square brackets [ in r are used to get elements from a vector, indicating the positions of items in a vector or matrix. Parentheses ( are for fuction calls.

# 6. (1) Provide a well-formed expression that correctly performs the 
# calculation that we want. Assign the converted values to tempC.
tempC = (temp - 32)*5/9

# 7. Run the following code to make a plot.
# (don't worry right now about what this code is doing)

plot(temp~dates, col = rainbow(12)[month], type="p", pch=19, cex = 0.3)

# (1) Use the Zoom button in the Plots window to enlarge the plot.
# Resize the plot so that it is long and short, so it is easier to read.
# Include this plot in the homework your turn in.
png("Rplot1.png", height=300, width=900)
plot(temp~dates, col = rainbow(12)[month], type="p", pch=19, cex = 0.3)
dev.off()

# (1) Make an interesting observation about temp in the Bay Area
# based on this plot (something that you couldn't see with
# the calculations so far.)

### Your answer goes here: We can see from the plot that the temperature in the Bay Area increases and decreases in a cyclical pattern each year. In the first half of a year, the temperatures are mostly around 45 to 65 degrees. In the middle of year, the weather goes up to 70, and then the temperature goes down from around 60 to 45. We can also see from the outliars that there are extremely cold and hot days in some of these years. The plot makes it easier to identify cold and hot temperatures, the color also tells us that red means cold, and blue means hot. 

# (1) What interesting question about the weather in the SF Bay Area
# would you like to answer with these data, but don't yet know 
# how to do it? 

### Your answer goes here: I would like to see if there is any connection between the occurence of extremely cold and hot temperatures and the occurrence of natural disaster. 

# For the remainder of this assignment we will work with 
# one of the random number generators in R.

# 8. (5). Use the following information about you to generate
# some random values:  
#a. Use the day of the month you were born for the mean of the normal.
#b.	Use your year of birth for the standard deviation (sd) of the normal curve.
#c.	Generate 5 random values using the parameters from a and b.
#d.	Assign the values to a variable named with your first name.
#e.	Provide the values generated.
danning = rnorm(5,mean = 12,sd = 1994)
print(danning)
# 943.9174 -180.4300  348.6793 -269.8629 2495.0192

# 9. (1). Generate a vector called "normsamps" containing
# 100 random samples from a normal distribution with
# mean 2 and SD 1.
normsamps = rnorm(100,mean=2,sd=1)

# 10. (1). Calculate the mean and sd of the 100 values.
mean(normsamps)

sd(normsamps)

### The return values from your computation go here: The mean is 1.864056. The standard deviation is 0.9767868.

# 11. (1). Use implicit coercion of logical to numeric to calculate
# the fraction of the values in normsamps that are more than 3.
class(normsamps) 
# numeric
normsamps > 3
sum(normsamps > 3)/100
# 0.15

# 12. (1). Look up the help for rnorm.
# You will see a few other functions listed.  
# Use one of them to figure out about what answer you 
# should expect for the previous problem.  
# That is, find the area under the normal(2, 1) curve
# to the right of 3.  This should be the chance of getting
# a random value more than 3. What value do you expect? 
# What value did you get? Why might they be different?
?rnorm
pnorm(3,mean=2,sd=1,lower.tail=FALSE,log.p=FALSE)
# 0.1586553
# Because when we use implicit coercion of logical to numeric, TRUE means 1, and FALSE means 0. So normsamps that are more than 3 can only be integers.
# While the pnorm gives the area under the normal distribution of curve to the right of 3, since we only have 100 samples in this case, the resul is 0.15. If the sample size is large enough then we can get a mre precise result as pnorm.