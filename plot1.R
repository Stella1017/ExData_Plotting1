## set working directory and unzip file
setwd("~/4_Exploratory_Data/Week1")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- download.file(url, destfile = "zipfile.zip", method = "curl" )
unzip(zipfile, files = "household_power_consumption.txt")

## load data
## skip the rows until it finds a row with "1/2/2007" (2007-Feb-1st)
## nrow = 1 /min * 60 min/hr * 24 hr/day * 2 days = 2880
powerconsume <- read.table("./household_power_consumption.txt", sep = ";", skip = grep("1/2/2007", readLines("./household_power_consumption.txt")) - 1, nrow = 2880)
## will return a warning message that only first element of result of "grep" will be used

## rename columns
colnames(powerconsume) = c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage","Global_intensity", "Sub_metering_1","Sub_metering_2","Sub_metering_3")

## convert Date and Time to Date/Time classes
powerconsume$Date = as.Date(powerconsume$Date, format = "%d/%m/%Y")
x <- paste(powerconsume$Date, as.character(powerconsume$Time))
powerconsume$Time = strptime(x, "%Y-%m-%d %H:%M:%S")

library(datasets)
## Plot 1
hist(powerconsume$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png") ##copy it to png file
dev.off()




