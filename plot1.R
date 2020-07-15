## HOUSEKEEPING

# load required packages

library(sqldf)
library(lubridate)

# store required urls and file names

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- ".\\UCI_PowerConsumption.zip"
txtfile <- ".\\household_power_consumption.txt"

# download and unzip data if it does not already exist

if (!file.exists(zipfile)) download.file(url, zipfile)
if (!file.exists(txtfile)) unzip(zipfile)

# import data from 2007-02-01 and 2007-02-02

df <- read.csv.sql(txtfile, sep=";",
                   colClasses = c(rep("character",2), rep("numeric",7)),
                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

df$Date <- dmy(df$Date)

## CREATE PLOT 1

hist(df$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

## SAVE PLOT 1 TO PNG

png("plot1.png", width = 480, height = 480)

hist(df$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()