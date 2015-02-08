# This script reads in a file of energy consumption data and selects
# data for Feb 1st and 2nd of year 2007.
# It produces a plot of global active power data for this two-day period.

# read in data file and focus on the Feb 1 and 2 days
pc <- read.table("household_power_consumption.txt", sep=';', stringsAsFactors = FALSE, header = TRUE)
feb <- pc[pc$Date == "1/2/2007" | pc$Date == "2/2/2007" ,]

# here we create and populate a new column of POSIXct dates based on the
# date and time columns
x <- paste(feb$Date, feb$Time)
datetime <- strptime(x, "%d/%m/%Y %H:%M:%S")
df <- cbind(feb, datetime)

df$Global_active_power <- as.numeric(df$Global_active_power)

# create png line plot with title and axis labels
png(filename = "plot2.png", width = 480, height = 480)
with(df, plot(datetime, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab=""))
lines(df$datetime, df$Global_active_power)
dev.off()

