# SRM 610: Statistical Methods III
# Module 2: Data Visualization

# How to load data from a txt file with first row being the variable names
# Set a working directory using setwd()
# Load the USairpollution data, and save it in usair object


usair = read.table("usairpollution.txt", header = TRUE)

# SO2: SO2 content of air in micrograms per cubic metre;
# temp: average annual temperature in degrees Fahrenheit;
# manu: number of manufacturing enterprises employing 20 or more workers;
# popul: population size (1970 census) in thousands;
# wind: average annual wind speed in miles per hour;
# precip: average annual precipitation in inches;
# predays: average number of days with precipitation per year.

# print first few observations
head(usair)

# what is the dimension of the data matrix?
dim(usair)

# Univariate Exploration through histogram and boxplots
hist(usair$SO2)

#layout(matrix(1:4, nc = 2))
hist(usair$SO2, main = "SO2", xlab = "SO2", prob = T) # plot the density


xlim <- with(usair, range(manu)) * 1.1
plot(popul ~ manu, data = usair, cex.lab = 0.9,
     xlab = "manu.lab" , ylab = "popul.lab", type = "n", xlim = xlim)



hist(usair$temp, main = "Temp", xlab = "Temp", prob = T) 
hist(usair$manu, main = "Manu", xlab = "Manufacturing", prob = T) 
hist(usair$popul, main = "Popul", xlab = "Population", prob = T) 


#layout(matrix(1:4, nc = 2))
hist(usair$wind, main = "wind", xlab = "wind", prob = T) # plot the density
hist(usair$precip, main = "precip", xlab = "precip", prob = T) 
hist(usair$predays, main = "predays", xlab = "predays", prob = T) 

#dev.off()

# All the boxplots in the same plot
boxplot(usair)


# Boxplot of SO2
summary(usair$SO2)
boxplot(usair$SO2)

layout(matrix(1:4, nc = 2))
boxplot(usair$SO2, main = "SO2")
boxplot(usair$temp, main = "temp")
boxplot(usair$manu, main = "manu")
boxplot(usair$popul, main = "popul")


# several plots in one


layout(matrix(c(2, 0, 1, 3), nrow = 2, byrow = TRUE),
       widths = c(2, 1), heights = c(1, 2), respect = TRUE)
xlim <- with(usair, range(manu)) * 1.1
plot(popul ~ manu, data = usair, cex.lab = 0.9,
     xlab = "manu.lab" , ylab = "popul.lab", type = "n", xlim = xlim)
with(usair, text(manu, popul, cex = 0.6,
                 labels = abbreviate(row.names(USairpollution))))
with(USairpollution, hist(manu, main = "", xlim = xlim))
with(USairpollution, boxplot(popul))



## Bivariate Scatterplot

# Defining the axes labels 
manu.lab = "Manufac with 20+ workers"
popul.lab = "Population size (1970) in thousands"

plot(popul ~ manu, data = usair, xlab = manu.lab, ylab = popul.lab)

size.lab = "Park Size, in acres"
visitor.lab = "Annual Visitors, in thousands"
plot(size ~ visitors, data = parks, xlab = size.lab, ylab = visitor.lab)

# Scatterplot with marginal distribution
plot(popul ~ manu, data = usair, xlab = manu.lab, ylab = popul.lab)
rug(usair$manu, side = 1)
rug(usair$popul, side = 2)

# Scatterplot with the city labels and marginal histogram, boxplot
layout(matrix(c(2, 0, 1, 3), nrow = 2, byrow = T), 
       widths = c(2, 1), heights = c(1, 2))
plot(popul ~ manu, data = usair, type ="n", xlab = manu.lab, ylab = popul.lab)
with(usair, text(manu, popul, labels = abbreviate(row.names(usair))))
with(usair, hist(manu))
with(usair, boxplot(popul))

#KW
plot(size ~ visitors, data = parks, type = "n", xlab = size.lab, ylab = visitor.lab)
with(parks, text(size, visitors, labels = abbreviate(row.names(parks))))
with


## Bivariate boxplot
require(MVA)

outcity1 = match(lab <- c("Chicago", "Detroit", "Cleveland", "Philadelphia","Houston"),
                 rownames(usair))
outcity = match(lab <- c("Chicago", "Detroit", "Cleveland", "Philadelphia"),
                rownames(usair))
x = usair[, c("manu", "popul")]
bvbox(x, mtitle = "", xlab = manu.lab, ylab = popul.lab)
text(x$manu[outcity], x$popul[outcity], labels = lab, pos = c(2, 2, 4, 2, 2))

# Calculating correlation betwewn manu and popul
with(usair, cor(manu, popul))

# Calculate the correlation between manu and popul after excluding the 
# outliers
with(usair, cor(manu[-outcity], popul[-outcity]))


# #####################
# Scatterplot Matrix  
# #####################

pairs(usair)

pairs(usair, pch =".", cex = 2.5) # gives slightly more redable graph

# Adding a straight line through the points

pairs(usair, 
      panel = function(x, y, ...) {
        points(x, y, ...)
        abline(lm(y ~ x), col = "red")
      },
      pch = ".", cex =  2.5
)

# Enhancing the bivariate scatterplot with estimated densities

# Need to install KernSmooth package
# Comment after you install it, so that you don't run it all the time
# install.packages("KernSmooth")

# ###############################
# Example use of pairs() function
# ###############################

# Recall measure2 data

## put histograms on the diagonal
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="maroon", ...)
}

# Draw straight lines through the data points
panel.line <- function(x, y, ...) {
  points(x, y, ...)
  abline(lm(y ~ x), col = "red")
}

# Calculate correlation coeff
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

# scatterplot matrix of measure2 data set with 
# histogram in the diagonals,
# straight lines through the points in the lower triangles, and
# correlation coefficients in the upper triangles
pairs(measure2, 
      diag.panel = panel.hist, 
      lower.panel = panel.line, 
      upper.panel = panel.cor)


# Load the package
library(KernSmooth)

?bkde2D # to access help file associated with this function

data(geyser, package="MASS")
x <- cbind(geyser$duration, geyser$waiting)
est <- bkde2D(x, bandwidth=c(1, 7))
persp(est$fhat, theta = 100, phi = 45)

layout(matrix(1:4, ncol = 2))
persp(est$fhat, theta = 0, phi = 45)
persp(est$fhat, theta = 60, phi = 45)
persp(est$fhat, theta = 90, phi = 45)
persp(est$fhat, theta = 100, phi = 45)

dev.off()  # Clears the graphic window

# Contour plot
contour(est$x1, est$x2, est$fhat)

# #############################################################
# Another Example of Contour plot of bivariate normal density 
# #############################################################
# Sources:
# https://stat.ethz.ch/pipermail/r-help/2003-September/038314.html
# http://www.ejwagenmakers.com/misc/Plotting_3d_in_R.pdf

library(MASS)
bivn <- mvrnorm(1000, mu = c(0, 0), Sigma = matrix(c(1, 0.75, 0.75, 1), 2))

# now we do a kernel density estimate
bivn.kde <- kde2d(bivn[,1], bivn[,2], n = 50)


# now plot your results
persp(bivn.kde, phi = 45, theta = 30)

# fancy perspective
persp(bivn.kde, phi = 45, theta = 30, shade = .1, border = NA)

# fancy contour with image
image(bivn.kde)
contour(bivn.kde, add = T)


# Really Fancy scatterplot with histogram and contours

# install.packages("ResourceSelection")
# library(ResourceSelection)
kdepairs(measure2)

# #################
# 3D Scatterplot
# #################

# install.packages("scatterplot3d")
# require(scatterplot3d)

# Plotting 3 variables together 

# Body Measurement Data
with(measure, scatterplot3d(chest, waist, hips, type = "h", 
                            pch = (1:2)[gender]))
legend(locator(), pch = 1:2, c("male", "female"))

# US Air pollution data

with(usair, scatterplot3d(temp, wind, SO2, type = "h"))

