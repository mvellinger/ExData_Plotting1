# We will assume the raw data file is located in our working directory
#file name
"household_power_consumption.txt"

# having taken a look at the data in the file (via a simple read.csv() command)
# I am opting to prepare a vector for the column names and column classes, this
# will make it easier to work with the data going forwards.
# in addition we will 

column.names = c("date", "time", "global.active.power", "global.reactive.power", "voltage", "global.intensity", "sub.metering1", "sub.metering2", "sub.metering3")
column.classes = c("character", "character", rep("numeric",7) )

# read file, specify that the NA character in the file is "?", and apply
# our preset column names ans classes.
raw.data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", col.names=column.names, colClasses=column.classes, na.strings="?")

# convert the date column to Date type, then subset the dataframe to only contain
# the dates we are after.

raw.data$date = as.Date(raw.data$date, format="%d/%m/%Y")
data <- raw.data[raw.data$date >= as.Date("2007-02-01") & raw.data$date<=as.Date("2007-02-02"),]

#create plot and save as png
png(filename="plot3.png", width=480, height=480, units="px")
with(data, {
    plot(sub.metering1,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
    lines(x=sub.metering2, col="red")
    lines(x=sub.metering3, col="blue")
})
axis(1, at=c(1, as.integer(nrow(data)/2), nrow(data)), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()