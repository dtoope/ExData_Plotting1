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

# Plot xy graph
with(data,plot(datetime,Global_active_power, type="l", 
               xlab="",ylab="Global Active Power(kilowatts)"))
# copy to file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()