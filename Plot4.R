library("data.table")

# Make sure to download file into working directory
# Get working Directory path
data_dir <- getwd()

# Reading Data
data <- fread(input = "household_power_consumption.txt", na.strings = "?")
head(data)

# Prevents Scientific Notation
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Select Dates from "2007-02-01" to "2007-02-02"
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
dim(data)

# Create PNG File
png("plot4.png", height = 480, width = 480)

par(mfrow=c(2,2))

#Plot 1
plot(data[,dateTime], data[,Global_active_power], type='l', xlab = "", ylab = "Global Active Power")

#Plot 2
plot(data[,dateTime], data[,Voltage], type='l', xlab = "datetime", ylab = "Voltage")

#Plot 3
plot(data[,dateTime], data[,Sub_metering_1], type = "l", xlab = "", ylab="Energy sub metering")
lines(data[,dateTime], data[,Sub_metering_2], col = "red")
lines(data[,dateTime], data[,Sub_metering_3], col = "blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black", "red", "blue"))

#Plot 4
plot(data[,dateTime], data[,Global_reactive_power], type='l', xlab = "datetime", ylab = "Global Reactive Power")

# Return to screen
dev.off()
