## Download file if it doesn't exist
if (!file.exists("./ExpDataAnalysis/household_power_consumption.txt")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, destfile = "/ExpDataAnalysis/household_power_consumption.zip", method = "curl")
        unzip("household_power_consumption.zip", exdir = "./ExpDataAnalysis")
}

## read the data and subset into the dates needed for for plots
febdata <- function() {
        data <- read.table("household_power_consumption.txt", header = TRUE, sep =";",
                           colClasses = c("character", "character", rep("numeric", 7)), 
                           na.strings = "?")
        data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
        data$Date <- as.Date(data$Date, "%d/%m/%Y")
        febdates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
        data <- subset(data, Date %in% febdates)
        return(data)
}

plotsd <- febdata()

## Create a png of the fourth plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(plotsd$Time, plotsd$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

plot(plotsd$Time, plotsd$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

plot(plotsd$Time, plotsd$Sub_metering_1, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering")
lines(plotsd$Time, plotsd$Sub_metering_2, col = "red")
lines(plotsd$Time, plotsd$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, box.lwd = 0)

plot(plotsd$Time, plotsd$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

