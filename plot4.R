# this is plot4.R

setwd("~/Exploratory Data Analysis/ExData_Plotting1")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, "household_power_consumption.zip")

dateDownloaded <- date()

dateDownloaded

unzip("household_power_consumption.zip")

# read household power file.  note that missing values are coded as ? in the
# file.  colClasses specifies type for each column in file. 

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                    na.strings="?", colClasses=c("character","character",
                                                 "numeric","numeric","numeric",
                                                 "numeric","numeric","numeric",
                                                 "numeric"))

# for the graphs showing power consumption by minute across days, we need
# to combine both date and time into one column. 

power$datetime <- paste(power$Date, power$Time)

power$Date <- as.Date(power$Date, "%d/%m/%Y")

power$datetime <- strptime(power$datetime, "%d/%m/%Y %H:%M:%S")

# subset the data to just the two days we are interested in.

power <- power[power$Date=="2007-02-01"|power$Date=="2007-02-02",]

png(filename="plot4.png", width=480, height=480, units="px")

# create display of 4 graphs in one figure 

par(mfrow = c(2,2))

### UPPER LEFT QUADRANT
# produce line plot of global active power by each minute for two days, 
# provide text for y axis label, suppress text for x axis label. 

with(power, plot(datetime, Global_active_power,
     ylab="Global Active Power", xlab="", type="l"))

### UPPER RIGHT QUADRANT
# produce a line plot of voltage by each minute for two days.

with(power, plot(datetime, Voltage, type="l"))

### LOWER LEFT QUADRANT
# produce line plots of sub meter power by each minute for two days, 
# provide text for y axis label, suppress text for x axis label, and
# do NOT draw box around legend. 

with(power, plot(datetime, Sub_metering_1, 
     ylab="Energy sub metering", xlab="", type="l"))
with(power, lines(datetime, Sub_metering_2, col="red")) 
with(power, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")

### LOWER RIGHT QUADRANT
# produce a line plot of global reactive power by each minute for two days.

with(power, plot(datetime, Global_reactive_power, type="l"))

#close PNG device

dev.off()