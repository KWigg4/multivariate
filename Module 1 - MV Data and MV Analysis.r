
# SRM 610: Statistical Methods III
# Module 1: Multivariate Data and Multivariate Analysis

# Installing a package

# install.packages("MVA")

# Loding the package: use library("packagename") or require("Packagename") 
# require(MVA) 

library(MVA)


# # Saving the data sets to external files
# write.table(hypo, file = "hypo.txt")
# write.table(measure, file = "measure.txt")
# write.table(USairpollution, file = "USairpollution.txt")

# How to load data from txt file with first row being the variable names

hypo = read.table("hypo.txt", header = TRUE)
measure = read.table("measure.txt", header = TRUE)
exam = read.table("exam.txt", header = TRUE)
pollution = read.table("USairpollution.txt", header = TRUE)



#################################
# hypo data
#################################

# Printing the hypo data
hypo
dim(hypo)

#################################
# measure data
#################################

# Dimension of measure data 
# How many variables and how many observations are there
dim(measure)

# Showing only first few observations
head(measure)

head(parks)

# Show measure data
measure


#################################
# exam data
#################################

dim(exam)
exam

#################################
# US Air pollution data
#################################
head(USairpollution)

#################################
# Introduction to Matrices
#################################


# Creating a variable and storing a single data in it

x = 10
x

x = c(1,2,3,4)

# Creating a matrix

x = matrix(c(1,2,3,4), ncol = 1)
x

# Crete a 2x2 matrix

y = matrix(c(1, 2, 3, 4), ncol = 2)
y

z = matrix(c(10, 20, 2, 3), ncol = 2)
z

# multiply y and z matrices

yz = y %*% z
yz

# multiply x an y

x %*% y 

# Inverse of yz

yz.inv = solve(yz)
yz.inv

# 


#################################
# Covariance 
#################################

measure # displays the data
parks
# Selecting numerical variables only
measure2 = measure[ , c("chest", "waist", "hips")]
measure2

parks2 = parks[ ,c("size","visitors")]
parks2

#
cov(measure2)


# Calculating the variance of the first column, i.e., chest
var(measure2[,1])


# SUbsetting: selecting  data for a given value of another variable
# It returns all the variables, but only those observations that match
# with the subsetting variable

# listing the variables of the measure data set
names(measure)
head(measure)

subset(measure, gender=="female")
subset(measure, gender=="male")

# Calculating Covariance for each subset
cov(subset(measure, gender=="female")[, c("chest", "waist", "hips")])
cov(subset(measure, gender=="male")[, c("chest", "waist", "hips")])



#################################
# Correlation
#################################

# Correlation matrix for the three numerical variable of the data set
cor(measure2)

# Calculating correlation for each subset
cor(subset(measure, gender=="female")[, c("chest", "waist", "hips")])
cor(subset(measure, gender=="male")[, c("chest", "waist", "hips")])

#################################
# Probability Distribution
#################################

hist(USairpollution$predays)


#################################
# Checking Univariate Normality
# using normal probaiblity plot
#################################

# We want to draw all the three plots in a rectangular arry
# with 2 rows and 2 columns

layout(matrix(1:4, nc=2))

qqnorm(measure[, "chest"], main = "Chest")
qqline(measure[, "chest"])

qqnorm(measure[, "waist"], main = "Waist")
qqline(measure[, "waist"])

qqnorm(measure[, "hips"], main = "Hips")
qqline(measure[, "hips"])





