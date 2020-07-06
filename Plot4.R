# plot 4

# Download files and save to the workspace
filename <- "UCI_Household_Power.zip"

# does the archive already exist? if n: download
if (!file.exists(filename)) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,filename,method="curl")
}

# does the unzipped file already exist? if n: unzip the download
if (!file.exists("household_power_consumption.txt")) {
        unzip(filename)
}

# read unzipped data
data <- read.csv("./household_power_consumption.txt", header=TRUE,  na.strings = "?",sep=';')

# subset based on date
library(lubridate)
data$Date <- dmy(data$Date)
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# create plot 4
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- ymd_hms(data$DateTime)

png(filename="plot4.png", width=480, height=480)
        # set to 2x2 grid and smaller margins
par(mfcol=c(2,2), margins=c(2,2,1,1))
        # plot 1 of 4
plot(data$DateTime, data$Global_active_power,type="l" ,ylab="Global Active Power (kilowatts)",xlab="")
        # plot 2 of 4
plot(data$DateTime, data$Sub_metering_1,type="l" ,ylab="Energy sub metering",xlab="")
points(data$DateTime, data$Sub_metering_2, type="l", col="red")
points(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=1)
        # plot 3 of 4
plot(data$DateTime,data$Voltage,type="l", ylab="Voltage",xlab="datetime")
        # plot 4 of 4
plot(data$DateTime,data$Global_reactive_power,type="l", ylab="Global_reactive_power",xlab="datetime")
        # close dev
dev.off()


