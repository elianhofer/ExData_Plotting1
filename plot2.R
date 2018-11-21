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

## Create line chart
plot(epc$date_time, epc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()
