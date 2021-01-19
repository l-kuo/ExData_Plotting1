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

png("plot2.png", width = 480, height = 480)

with(filteredData, plot(filteredData$dateTime, filteredData$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()
