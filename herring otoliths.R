#load faraway package
library(faraway)
library(tidyverse)
library(plyr)

#set working directory
setwd("~/Dropbox/Jessica Qualley/MSc/ES 582/Data Project/Herring Otoliths")

#read herring otolith csv file with combined data
herring <- read.csv("HerringOtolithDatabase 15 Jan 2020_JQ.csv", header=TRUE)

#look at variable structure
str(herring)

#create a data frame
herring_data <- data.frame(sal.id = herring$FishCode,
                           her.id = herring$PreyID,
                           oto.length = herring$AverageLength,
                           oto.width = herring$AverageWidth,
                           oto.perimeter = herring$AveragePerimeter,
                           oto.area = herring$AverageArea,
                           digestion = herring$Digestion,
                           her.length = herring$ActualFishLen,
                           her.length.predict = herring$AVGPredictedLength,
                           her.weight = herring$ActualFishWeight,
                           sal.sp = herring$SalmonSpecies,
                           sal.sex = herring$SalmonSex,
                           sal.length = herring$SalmonLength,
                           sal.weight = herring$SalmonWeight,
                           coll.year = herring$CollectionYear,
                           coll.doy = herring$CollectionDayofYear,
                           lat = herring$Latitude,
                           long = herring$Longitude)

#filter only chinook and data from 2018
herring_data2 <- herring_data %>% filter(herring_data$sal.sp == "ch" & herring_data$coll.year == "2018")

#check that filter worked - note that the output still shows multiple species levels although looking at the dataframe I think it filtered correctly...
levels(herring_data2$sal.sp)


#plot lat/long as continuous variable
x11()
plot(herring_data2$long, herring_data2$lat, xlim = c(-122, -128), ylim = c(48, 50.5))

#EXAMPLE 1 - MAKING DOT CHARTS

#add column for number of rows
herring_data3 <- herring_data2
n <- nrow(herring_data3)
herring_data3$row <- 1:n

x11()
par(mfrow = c(3, 2))

#actual herring length - digestion 1, 2, and 3 herring only
with(herring_data3, plot(her.length, row, las = 1, type = "n", xlab = "Actual Herring Length [mm]", ylab = "Row Number"))
abline (h = seq(1, n, by = 5), col = "lightgrey")
with(herring_data3, points(her.length, row, las = 1, type = "p", pch = 19, cex = 0.5))

#predicted herring length - digestion 1, 2, 3, and 4 predicted lengths from linear regression using otolith width
with(herring_data3, plot(her.length.predict, row, las = 1, type = "n", xlab = "Predicted Herring Length [mm]", ylab = "Row Number"))
abline (h = seq(1, n, by = 5), col = "lightgrey")
with(herring_data3, points(her.length.predict, row, las = 1, type = "p", pch = 19, cex = 0.5))

#actual herring weight - digestion 1, 2, and 3 herring only
with(herring_data3, plot(her.weight, row, las = 1, type = "n", xlab = "Actual Herring Weight [g]", ylab = "Row Number"))
abline (h = seq(1, n, by = 5), col = "lightgrey")
with(herring_data3, points(her.weight, row, las = 1, type = "p", pch = 19, cex = 0.5))

#actual salmon length - all salmon that ate herring - note that some numbers are ranges and have weird symbols...
#where lengths were not recorded, they were calculated using length-weight relationship
with(herring_data3, plot(sal.length, row, las = 1, type = "n", xlab = "Actual Salmon Length [mm]", ylab = "Row Number"))
abline (h = seq(1, n, by = 5), col = "lightgrey")
with(herring_data3, points(sal.length, row, las = 1, type = "p", pch = 19, cex = 0.5))

#actual salmon weight - raw salmon weights no back calculations
with(herring_data3, plot(sal.weight, row, las = 1, type = "n", xlab = "Actual Salmon Weight [lbs]", ylab = "Row Number"))
abline (h = seq(1, n, by = 5), col = "lightgrey")
with(herring_data3, points(sal.weight, row, las = 1, type = "p", pch = 19, cex = 0.5))

#day of year
with(herring_data3, plot(coll.doy, row, las = 1, type = "n", xlab = "Day of Year in 2018", ylab = "Row Number"))
abline (h = seq(1, n, by = 5), col = "lightgrey")
with(herring_data3, points(coll.doy, row, las = 1, type = "p", pch = 19, cex = 0.5))


#EXAMPLE 2 - CHECKING FOR COLLINEARITY

#create data frame for pairwise scatter with only 3 explanatory variables - salmon lenght, weight and collection day of year
herring_collinearity <- data.frame(herring_data3$sal.length, herring_data3$sal.weight, herring_data3$coll.doy)
#create pairwise scatterplot with salmon length, weight and day of year
plot(herring_collinearity[1:3], cex = 0.5, pch = 19, col = rgb(0, 0, 0, 0.5), 
                   labels = c("Chinook\nLength [mm]", "Chinook\nWeight [lbs]", "Collection\nDay in 2018"))

#convert sal.length to numeric
as.numeric(herring_data3$sal.length)
#pairwise correlation coefficients for multiple variables
print(cor(na.omit(herring_data3[ ,c("sal.length", "sal.weight", "coll.doy")])), digits = 2)

#variance inflation factors
print(vif(na.omit(herring_data3[ ,c("sal.length", "sal.weight", "coll.doy")])))


#EXAMPLE 3 - IS THE DATASET BALANCED?

head(herring_data3, n = 3)

#make a table of...having a hard time because of the way the csv file is set up
herring_table <- 
  
?group_data
     
