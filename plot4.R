zipFile <- "exdata_data_household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile))
  unzip(zipFile)

library(data.table)

data <- fread(data_file, na.strings = "?", sep = ";")

data[, Date := as.Date(Date, format="%d/%m/%Y")]

filtered_data <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

filtered_data[, DateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

filtered_data[, Global_reactive_power := as.numeric(Global_reactive_power)]

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

plot(filtered_data$DateTime, filtered_data$Global_active_power, 
     type = "l", 
     col = "black", 
     xlab = "", 
     ylab = "Global Active Power")

plot(filtered_data$DateTime, filtered_data$Voltage, 
     type = "l", 
     col = "black", 
     xlab = "datetime", 
     ylab = "Voltage")

plot(filtered_data$DateTime, filtered_data$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xlab = "", 
     ylab = "Energy Sub Metering")

lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

plot(filtered_data$DateTime, filtered_data$Global_reactive_power, 
     type = "l",
     xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()
