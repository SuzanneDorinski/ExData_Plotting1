# this is plot2.R

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

png(filename="plot2.png", width=480, height=480, units="px")

# produce line plot of global active power by each minute for two days, 
# provide text for y axis label, suppress text for x axis label. 

with(power, plot(datetime, Global_active_power, 
     ylab="Global Active Power (kilowatts)", xlab="", type="l"))

#close PNG device

dev.off()