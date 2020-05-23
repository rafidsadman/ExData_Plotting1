library(lubridate)

data <- read.table( "household_power_consumption.txt", sep = ";", header = TRUE)


data$datetime <- paste(data$Date, data$Time)

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data$datetime <- dmy_hms(data$datetime)

req_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

rm(data)

req_data$day <- wday(req_data$Date, label = TRUE, abbr = TRUE)

req_data$Sub_metering_1 <- as.numeric(req_data$Sub_metering_1)
req_data$Sub_metering_2 <- as.numeric(req_data$Sub_metering_2)
req_data$Sub_metering_3 <- as.numeric(req_data$Sub_metering_3)



png("plot3.png", width = 480, height = 480)
plot(req_data$datetime, req_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
points(req_data$datetime, req_data$Sub_metering_2, type = "l", col = "red")
points(req_data$datetime, req_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")
dev.off()