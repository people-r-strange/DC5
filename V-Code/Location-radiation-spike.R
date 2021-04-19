#Targeted Location of Radiation Spikes 
library(readr)
library(tidyverse)
library(openair)
library(xts)

MobileSensorReadings <- read_csv("DC5-Data/Sensor Data and Maps/MobileSensorReadings.csv")
View(MobileSensorReadings)

#Separate date and time columns
MobileReadings <- separate(MobileSensorReadings, Timestamp, c("date", "time"), sep = " ")

#Apr 08 16:00-23:00 
Apr_08_Spike <- filter(MobileReadings, time >= '16:00' & time <= '23:00')

#merge Lat and Long columns into one column 
Apr_08_Spike$Coordinates <- paste(Apr_08_Spike$Long, Apr_08_Spike$Lat, sep=", ")

#Filter Apr_08 coordinates for 16:00 
Apr_08_16h <- Apr_08_Spike %>%
  filter(time=='16:00:00')

#Mean Longitude 
mean(Apr_08_16h$Long) ##-119.87

#Mean Latitude
mean(Apr_08_16h$Lat) ##0.13

#Mean Coordinates for Apr_08 @ 16:00 
## **0.13,-119.87** 

#Scatterplot of apr_08 @16:00 coordinates 
ggplot(Apr_08_16h, aes(x = Lat, y = Long)) + geom_point()

ggplot(Apr_08_Spike, aes(x=Lat, y = Long)) + geom_point() + 
  labs(title = "Coordinates of Radiation Measurements on April 8th", 
       subtitle="Between 16:00 and 23:00, when radiation levels > 15",
       y = "Longitude", 
       x = "Latitude") 
