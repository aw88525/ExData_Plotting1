#load the data
skip=grep("\\b1/2/2007|\\b2/2/2007", readLines("household_power_consumption.txt"))
powerConsum <- read.table("household_power_consumption.txt",
                          skip = skip[1]-1, nrows = length(skip), sep=";", 
                          stringsAsFactors = FALSE)

names(powerConsum) <- c("Date", "Time", "Global_active_power", 
                        "Global_reactive_power", "Voltage", "Global_intensity",
                        "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

x <- paste(powerConsum$Date, powerConsum$Time)
library(dplyr)
powerConsumnew <- select(powerConsum, -Date, -Time)
powerConsumnew[as.character(powerConsumnew) == "?"] <- NA
DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
powerConsumnew <- cbind(DateTime, powerConsumnew)

png(file = "plot3.png", width = 480, height = 480)
with(powerConsumnew, plot(powerConsumnew$DateTime, powerConsumnew$Sub_metering_1, col = "black", type = 'l', 
                          xlab = "", ylab = "Energy sub metering"))
lines(powerConsumnew$DateTime, powerConsumnew$Sub_metering_2, col = "red", type = 'l', 
                          xlab = "", ylab = "Energy sub metering")
lines(powerConsumnew$DateTime, powerConsumnew$Sub_metering_3, col = "blue", type = 'l', 
                          xlab = "", ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black","red", "blue"), lty = 1)
dev.off()