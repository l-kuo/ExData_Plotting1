if (!file.exists("household_power_consumption.txt")){
        unzip("../exdata_data_household_power_consumption.zip")
}

library("data.table")
myFile <- fread("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";")

myFile$Date <- as.Date(myFile$Date, format = "%d/%m/%Y")

filteredData <- with(myFile, myFile[myFile$Date <= "2007-02-02" & myFile$Date >= "2007-02-01",])

rm(myFile)

png(filename = "plot1.png", width = 480, height = 480)

hist(filteredData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

dev.off()
