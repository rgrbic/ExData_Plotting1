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

#Plot 3
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
with(dataFinal, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering", col="black"))
with(dataFinal, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(dataFinal, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#create png file
png(filename = "plot3.png", width=480, height=480)
with(dataFinal, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering", col="black"))
with(dataFinal, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(dataFinal, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()