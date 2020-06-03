library("data.table")

# Make sure to download file into working directory
# Get working Directory path
data_dir <- getwd()

# Reading Data
data <- fread(paste0(data_dir,"/household_power_consumption.txt"), sep = ";"
                  , header = TRUE, na.strings = "?")
head(data)

# Convert Date column to Date Type
data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
class(data$Date)

# Select Dates from "2007-02-01" to "2007-02-02"
data <- data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
dim(data)

# Create PNG File
png("plot1.png", height = 480, width = 480)

# Plot Date Vs House-Hold-Energy
hist(data$Global_active_power, col='red',
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Return to screen
dev.off()

