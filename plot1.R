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
## Create png file of the first plot
plotsd <- febdata()
png("plot1.png", width=480, height=480)
hist(plotsd$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowats)", ylab = "Frequency")
dev.off()
