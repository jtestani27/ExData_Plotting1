# plot 1

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
        data$Time <- hms(data$Time)
        data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
        
# create plot 1
        data$Global_active_power <- as.numeric(data$Global_active_power)
        png(filename="plot1.png", width=480, height=480)
        hist(data$Global_active_power,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
        dev.off()
        