if (!file.exists("household_power_consumption.txt")){
    unzip("../exdata_data_household_power_consumption.zip")
}

library("data.table")
myFile <- fread("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";")

myFile$Date <- as.Date(myFile$Date, format = "%d/%m/%Y")

filteredData <- with(myFile, myFile[myFile$Date <= "2007-02-02" & myFile$Date >= "2007-02-01",])

rm(myFile)

dateTime <- paste(filteredData$Date, filteredData$Time, sep = " ")

filteredData$dateTime <- as.POSIXct(dateTime)

png("plot3.png", width = 480, height = 480)

plot(filteredData$Sub_metering_1 ~ filteredData$dateTime, col = "black", type = "l", xlab = "", ylab = "Energy Sub Metering")

lines(filteredData$Sub_metering_2 ~ filteredData$dateTime, col = 'red')

lines(filteredData$Sub_metering_3 ~ filteredData$dateTime, col = "blue")

legend("topright", lty = 1, lwd = 2, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
