#Exploratory Analysis of Radiation Data 

library(readr)
library(tidyverse)
library(openair)

StaticSensorReadings <- read_csv("DC5-Data/Sensor Data and Maps/StaticSensorReadings.csv")
View(StaticSensorReadings)

#Hourly average of radiation values 
Hourly_average_static_reading <- aggregate(
  list(value = StaticSensorReadings$Value), 
  list(hourofday = cut(StaticSensorReadings$Timestamp, "1 hour")), 
          mean)

#Separate date and time columns
SensorReading <- separate(Hourly_average_static_reading, hourofday, c("date", "time"), sep = " ")

#Separate by date 
apr_06 <- SensorReading %>%
  filter(date=='2020-04-06')

apr_07 <- SensorReading %>%
  filter(date=='2020-04-07')

apr_08 <- SensorReading %>%
  filter(date=='2020-04-08')

apr_09 <- SensorReading %>%
  filter(date=='2020-04-09')

apr_10 <- SensorReading %>%
  filter(date=='2020-04-10')

#Visualize Hourly radiation for apr 06
ggplot(apr_06, aes(x=time, y=value)) + 
  geom_col() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Hourly Radiation Levels on April 6th ", 
       y = "Value", 
       x = "Time")

#Visualize Hourly radiation for apr 07
ggplot(apr_07, aes(x=time, y=value)) + 
  geom_col() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Hourly Radiation Levels on April 7th ", 
       y = "Value", 
       x = "Time")

#Visualize Hourly radiation for apr 08
apr_08 %>% 
  mutate(highlight_flag = ifelse(value >= '15', T, F)) %>% 
  ggplot(aes(x = time, y = value)) +
  geom_col(aes(fill = highlight_flag)) + 
  scale_fill_manual(values = c('#595959', 'red'), name = "Radiation Level > 15.00") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Hourly Radiation Levels on April 8th", 
       subtitle="Radiation levels spike at 16:00 and remain elevated",
       y = "Value", 
       x = "Time") 
    
#Visualize Hourly radiation for apr 09
apr_09 %>% 
  mutate(highlight_flag = ifelse(value >= '15', T, F)) %>% 
  ggplot(aes(x = time, y = value)) +
  geom_col(aes(fill = highlight_flag)) + 
  scale_fill_manual(values = c('#595959', 'red'), name = "Radiation Level > 15.00") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Hourly Radiation Levels on April 9th", 
       subtitle="Radiation levels spike at 15:00 and again at 20:00",
       y = "Value", 
       x = "Time") 

#Visualize Hourly radiation for apr 10
apr_10 %>% 
  mutate(highlight_flag = ifelse(value >= '15', T, F)) %>% 
  ggplot(aes(x = time, y = value)) +
  geom_col(aes(fill = highlight_flag)) + 
  scale_fill_manual(values = c('red'), name = "Radiation Level > 15.00") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Hourly Radiation Levels on April 10th",
       y = "Value", 
       x = "Time") 
