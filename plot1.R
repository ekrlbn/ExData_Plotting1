zipFile <- "exdata_data_household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile))
  unzip(zipFile)

library(data.table)
data <- fread(data_file, na.strings = "?", sep = ";")

head(data)

data[, Date := as.Date(Date, format="%d/%m/%Y")]

filtered_data <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

head(filtered_data)

filtered_data[, Global_active_power := as.numeric(Global_active_power)]
png ("plot1.png", width = 480, height = 480)
hist(filtered_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
