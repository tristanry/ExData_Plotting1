library(data.table)
library(lubridate)

if(!dir.exists("./data")){
    dir.create("./data")
}

#collect & unzip dataset  
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip ", destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

dt_hpc <- data.table::fread(file.path("./data", "household_power_consumption.txt"), header = TRUE, colClasses = c("Date", "Time", rep("numeric", 7)), na.strings = "?")

#filter the data on two days 
dt_hpc_select <- dt_hpc[(dt_hpc$Date == "1/2/2007" |  dt_hpc$Date == "2/2/2007"), ]

#format the date & time columns 
dt_hpc_select$Time <-  dmy_hms(paste(dt_hpc_select$Date, dt_hpc_select$Time))
dt_hpc_select$Date <- dmy(dt_hpc_select$Date)


#4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot( dt_hpc_select$Time, dt_hpc_select$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot( dt_hpc_select$Time, dt_hpc_select$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot( dt_hpc_select$Time, dt_hpc_select$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dt_hpc_select$Time, dt_hpc_select$Sub_metering_2, col = "red")
lines(dt_hpc_select$Time, dt_hpc_select$Sub_metering_3, col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty = 1,  bty = "n")
plot( dt_hpc_select$Time, dt_hpc_select$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
