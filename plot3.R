# This script reads in a file of energy consumption data and selects
# data for Feb 1st and 2nd of year 2007.
# It produces a plot with three lines, one for each sub meter
# over this two-day period.

# read in data file and focus on the Feb 1 and 2 days
pc <- read.table("household_power_consumption.txt", sep=';', stringsAsFactors = FALSE, header = TRUE)
feb <- pc[pc$Date == "1/2/2007" | pc$Date == "2/2/2007" ,]

# here we create and populate a new column of POSIXct dates based on the
# date and time columns
x <- paste(feb$Date, feb$Time)
datetime <- strptime(x, "%d/%m/%Y %H:%M:%S")
df <- cbind(feb, datetime)

df$Global_active_power <- as.numeric(df$Global_active_power)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)


# create png line plot of all 3 sub metering values
png(filename = "plot3.png", width = 480, height = 480)
with(df, plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
lines(df$datetime, df$Sub_metering_1, col="black")
lines(df$datetime, df$Sub_metering_2, col="red")
lines(df$datetime, df$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), lwd = c(2.5,2.5,2.5), col = c("black", "red", "blue"))
dev.off()

