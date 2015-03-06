# this is plot1.R

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

power$Date <- as.Date(power$Date, "%d/%m/%Y")

# subset the data to just the two days we are interested in.

power <- power[power$Date=="2007-02-01"|power$Date=="2007-02-02",]

# produce histogram with red bars.  set text for title and label for x axis. 

png(filename="plot1.png", width=480, height=480, units="px")

hist(power$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

#close PNG device

dev.off()