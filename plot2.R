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

#Plot 2
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
with(dataFinal, plot(DateTime, Global_active_power, type="l", col="black", xlab="", ylab = "Global Active Power (kilowatts)"), cex.lab=0.75, cex.axis=0.75)

#create png file
png(filename = "plot2.png", width=480, height=480)
with(dataFinal, plot(DateTime, Global_active_power, type="l", col="black", xlab="", ylab = "Global Active Power (kilowatts)"))
dev.off()