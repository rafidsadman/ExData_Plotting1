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
req_data$Voltage <- as.numeric(req_data$Voltage)
req_data$Sub_metering_1 <- as.numeric(req_data$Sub_metering_1)
req_data$Sub_metering_2 <- as.numeric(req_data$Sub_metering_2)
req_data$Sub_metering_3 <- as.numeric(req_data$Sub_metering_3)
req_data$Global_reactive_power <- as.numeric(req_data$Global_reactive_power)

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))


#plot1
plot(req_data$datetime, req_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#plot2
plot(req_data$datetime, req_data$Voltage , type = "l", xlab = "datetime", ylab = "Voltage")


#plot3
plot(req_data$datetime, req_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
points(req_data$datetime, req_data$Sub_metering_2, type = "l", col = "red")
points(req_data$datetime, req_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")

#plot4
plot(req_data$datetime, req_data$Global_reactive_power , type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()