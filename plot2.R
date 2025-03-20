zipFile <- "exdata_data_household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile))
  unzip(zipFile)

library(data.table)
data <- fread(data_file, na.strings = "?", sep = ";")

data[, Date := as.Date(Date, format="%d/%m/%Y")]

filtered_data <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

filtered_data[, DateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

filtered_data[, Global_active_power := as.numeric(Global_active_power)]

head(filtered_data)

png("plot2.png", width = 480, height = 480)

plot(filtered_data$DateTime, filtered_data$Global_active_power, 
     type = "l",
     col = "black", 
     ylab = "Global Active Power (kilowatts)"
)
dev.off()
