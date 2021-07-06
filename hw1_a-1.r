#########################################
####          HW 1- Part (a)         ###

# Read data set 
parks <- read.table("T1-11.txt")

dim(parks)

# Print data
parks

# Add variable names to data
colnames(parks) <- c("size", "visitors")

parks

# Create park names to add to the data
parkname <- c("Arcadia", "Bryce Canyon", "Cuyahoga Valley",
              "Everglades", "Grand Canyon", "Grand Tenton",
              "Great Smoky", "Hot Springs", "Olympic",
              "Mount Rainier","Rocky Mountain", "Shenandoah",
              "Yellostone", "Yosemite", "Zion")

# Adding row names to the parks data
rownames(parks) <- parkname

# Printing the data again
parks

dim(parks)

