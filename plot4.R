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

df$datetime <- dmy_hms(paste(df$Date, " ", df$Time))

## CREATE PLOT 4

par(mfrow = c(2,2))

with(df, {

plot(datetime, Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power")

plot(datetime, Voltage, type = "l")

plot(datetime, Sub_metering_1, type = "l",
     xlab =  "",
     ylab = "Energy sub metering")
lines(datetime, Sub_metering_2, col = "red")
lines(datetime, Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

plot(datetime, Global_reactive_power, type = "l")

})

## SAVE PLOT 4 TO PNG

dev.copy(png, file="plot3.png", height=480, width=480)

dev.off()