library(dplyr)
library(gamair)

#set working directory
setwd("~/Dropbox/Jessica Qualley/MSc/ES 582/Data Project")

#read herring582.csv file with combined data
herring <- read.csv("herring582.csv", header=TRUE, stringsAsFactors=TRUE)

#look at data structure
str(herring)

#create data frame
herring_data <- data.frame(fish.id = herring$code,
                           unidentified = herring$unidentified,
                           coll.date = herring$date_serial,
                           cohort = herring$group,
                           growth.1 = herring$avg_year1,
                           growth.2 = herring$avg_year2,
                           lat = herring$lat,
                           long = herring$long)
                  

#remove any rows with na values - these are cases where left and right otoliths were missing or unreadable
#one case where there is NA in lat/long which I don't want to get rid of...
herring_data2 <- na.omit(herring_data)




