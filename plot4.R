## Load package "data.table"
library(data.table)

## Download and unzip the dataset:
filename <- "electricpowerconsumption.zip"
if (!file.exists("filename")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename, method="curl")
}
if (!file.exists("household_power_consumption.txt")) { 
        unzip(filename)
}

## Load data into R
epc_data <- fread("household_power_consumption.txt", na.strings = "?")

## Convert date format and subset data
epc_data$Date <- as.Date(epc_data$Date, format = "%d/%m/%Y")
epc <- subset(epc_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## Create date-time column
date_time <- paste(epc$Date, epc$Time)
epc$date_time <- as.POSIXct(date_time)

## Create plot area with two columns and two rows
par(mfcol= c(2,2), mar=c(4,4,2,1))

## Plot 1
plot(epc$date_time, epc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Plot 2
plot(epc$date_time, epc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black","red","blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.9, y.intersp=0.5)
lines(epc$date_time, epc$Sub_metering_1, col = "black")
lines(epc$date_time, epc$Sub_metering_2, col = "red")
lines(epc$date_time, epc$Sub_metering_3, col = "blue")

## Plot 3
plot(epc$date_time, epc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Plot 4
plot(epc$date_time, epc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## Copy to PNG format
dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()
