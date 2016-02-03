library(data.table)
url <- "./household_power_consumption.txt"
powerCons <- read.table(url, skip = 66637, nrows = 2880, header = FALSE, colClasses = "character", sep = ";")

colnames(powerCons) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

powerCons$Date <- as.Date(powerCons$Date, format="%d/%m/%Y")
datetime <- paste(powerCons$Date, powerCons$Time)
powerCons$Datetime <- as.POSIXct(datetime)
powerCons$Global_active_power <- as.numeric(powerCons$Global_active_power)

png(file = "plot2.png", width = 480, height = 480, units = "px")
with(powerCons, 
         plot(Global_active_power~Datetime, type="l", xlab="", ylab = "Global Active Power(kilowatts)")
     )
dev.off()