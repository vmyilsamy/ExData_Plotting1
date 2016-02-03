library(data.table)
url <- "./household_power_consumption.txt"
powerCons <- read.table(url, skip = 66637, nrows = 2880, header = FALSE, colClasses = "character", sep = ";")

colnames(powerCons) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

powerCons$Date <- as.Date(powerCons$Date, format="%d/%m/%Y")
datetime <- paste(powerCons$Date, powerCons$Time)
powerCons$Datetime <- as.POSIXct(datetime)
powerCons$Global_active_power <- as.numeric(powerCons$Global_active_power)
powerCons$Global_reactive_power <- as.numeric(powerCons$Global_reactive_power)
powerCons$Voltage <- as.numeric(powerCons$Voltage)
powerCons$Sub_metering_1 <- as.numeric(powerCons$Sub_metering_1)
powerCons$Sub_metering_2 <- as.numeric(powerCons$Sub_metering_2)
powerCons$Sub_metering_3 <- as.numeric(powerCons$Sub_metering_3)


png(file = "plot4.png", width = 480, height = 480, units = "px")
with(powerCons, 
     {
         par(mfrow=c(2,2))
         plot(Global_active_power~Datetime, type="l", xlab="", ylab = "Global Active Power")
         plot(Voltage~Datetime, type="l", xlab="datetime", ylab = "Voltage")
         plot(Sub_metering_1~Datetime, type="l", xlab="", ylab = "Energy sub metering")
         lines(Sub_metering_2~Datetime, col = "red")
         lines(Sub_metering_3~Datetime, col = "blue")
         legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
         plot(Global_reactive_power~Datetime, type="l")
     })
dev.off()