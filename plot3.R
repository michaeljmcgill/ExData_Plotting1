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

df$DateTime <- dmy_hms(paste(df$Date, " ", df$Time))

## CREATE PLOT 3

plot(df$DateTime, df$Sub_metering_1, type = "l",
     xlab =  "",
     ylab = "Energy sub metering")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend("topright", lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

## SAVE PLOT 3 TO PNG

dev.copy(png, file="plot3.png", height=480, width=480)

dev.off()