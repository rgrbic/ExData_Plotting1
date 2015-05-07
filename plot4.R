#clean env
rm(list = ls())

#load the data; first 90 days
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?", nrows=90*24*60)
data[,1] <- as.Date(data[,1],"%d/%m/%Y")

#subset data
dataSubSet <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#make new data frame with first column date time in POSIX format
x <- paste(dataSubSet$Date,dataSubSet$Time)
temp <- strptime(x, "%Y-%m-%d %H:%M:%S")
dataFinal <- data.frame(DateTime = temp, dataSubSet[,3:9])

#Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(dataFinal,{
  plot(DateTime, Global_active_power, type="l", col="black", xlab="", ylab = "Global Active Power")
  plot(DateTime, Voltage, type="l", col="black", xlab="datetime", ylab = "Global Active Power")
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering", col="black")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
  plot(DateTime, Global_reactive_power, type="l", col="black", xlab="datetime", ylab = "Global_reactive_power")  
})

#create png file
png(filename = "plot4.png", width=480, height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(dataFinal,{
  plot(DateTime, Global_active_power, type="l", col="black", xlab="", ylab = "Global Active Power")
  plot(DateTime, Voltage, type="l", col="black", xlab="datetime", ylab = "Voltage")
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering", col="black")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
  plot(DateTime, Global_reactive_power, type="l", col="black", xlab="datetime", ylab = "Global_reactive_power")  
})
dev.off()