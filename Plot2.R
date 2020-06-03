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
png("plot2.png", height = 480, width = 480)

plot(x = data[,dateTime], 
     y = data[,Global_active_power], 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Return to screen
dev.off()
