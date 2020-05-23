library(lubridate)

data <- read.table( "household_power_consumption.txt", sep = ";", header = TRUE)


data$datetime <- paste(data$Date, data$Time)

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data$datetime <- dmy_hms(data$datetime)

req_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

rm(data)

req_data$day <- wday(req_data$Date, label = TRUE, abbr = TRUE)

req_data$Global_active_power <- as.numeric(req_data$Global_active_power)

png("plot2.png", width = 480, height = 480)
plot(req_data$datetime, req_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()