# Read first line of the data file to get the names.
names <- read.table(file = "household_power_consumption.txt", 
                    header=TRUE, sep=";", nrows=1)

# Read data beginning on February 1st 2007 is on the 66637th row
# subsetting work from before, there are 1440 observations per day-
# and so to grab Feb 1 and Feb 2, we need 2880 rows
data <- read.table("household_power_consumption.txt", sep=";", 
                         na.strings=c("NA","?"), skip=66637, nrows=2880)
# Add labels to the data file
names(data) <- names (names)

# Convert date and time columns to calendar format. (POSIXlt)
data$datetime <- strptime(paste(data$Date, data$Time), 
                          format = "%d/%m/%Y %H:%M:%S", tz = "CET")

par(mfrow = c(2, 2), mar = c(4, 6, 4, 0.5))

#Plot 1

with(data,plot(datetime,Global_active_power, type="l", 
               xlab="",ylab="Global Active Power(kilowatts)"))

# Plot 2
with(data,plot(datetime,Voltage, type="l", 
               xlab="datetime",ylab="Voltage"))


# Plot 3
with(data,plot(datetime,Sub_metering_1, type="l", 
               xlab="",ylab="Energy Sub Metering"))
with(data,lines(datetime,Sub_metering_2, col="red"))
with(data,lines(datetime,Sub_metering_3, col="blue"))
# Add legend
legend("topright", lty = 1,y.intersp=0.5,cex=0.5, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot 4

with(data,plot(datetime, Global_reactive_power,xlab="datetime",
                ylab="Global Active Power",type="l",col="black"))
# copy to file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()