library(lubridate)

data <- read.table( "household_power_consumption.txt", sep = ";", header = TRUE)

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

req_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

rm(data)

req_data$Global_active_power <- as.numeric(req_data$Global_active_power)

png("plot1.png", width = 480, height = 480)
with(req_data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()
