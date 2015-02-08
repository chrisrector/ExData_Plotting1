# This script reads in a file of energy consumption data and produces
# a histogram of the global active power data. The plot includes data
# only for Feb 1st and 2nd of year 2007.

# read in data file
pc <- read.table("household_power_consumption.txt", sep=';', stringsAsFactors = FALSE, header = TRUE)
feb <- pc[pc$Date == "1/2/2007" | pc$Date == "2/2/2007" ,]

# here we create and populate a new column of POSIXct dates based on the
# date and time columns
x <- paste(feb$Date, feb$Time)
datetime <- strptime(x, "%d/%m/%Y %H:%M:%S")
df <- cbind(feb, datetime)

# histogram requires numberic data
df$Global_active_power <- as.numeric(df$Global_active_power)

# create png histogram with title and axis labels
png(filename = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

