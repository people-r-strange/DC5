#Exploratory Analysis of Radiation Data 

library(readr)
library(tidyverse)
library(openair)

MobileSensorReadings <- read_csv("DC5-Data/Sensor Data and Maps/MobileSensorReadings.csv")
View(MobileSensorReadings)

StaticSensorReadings <- read_csv("DC5-Data/Sensor Data and Maps/StaticSensorReadings.csv")
View(StaticSensorReadings)

#Hourly average of radiation values 
Hourly_average_static_reading <- aggregate(
  list(value = StaticSensorReadings$Value), 
  list(hourofday = cut(StaticSensorReadings$Timestamp, "1 hour")), 
          mean)

#Separate by date 


#Visualize Hourly radiation 
ggplot(Hourly_average_static_reading, aes(x=hourofday, y=value)) + geom_col()