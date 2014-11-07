
library(sqldf)

#Change the path of your file accordingly
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")
myfile<-"household_power_consumption.txt"

house<-read.csv.sql(myfile, sep=";",sql = 'select * from file where Date="1/2/2007" OR Date="2/2/2007"')
house$Date<-as.Date(house$Date, "%d/%m/%Y")
house$datetime<-paste(house$Date, house$Time)
house$datetime<-strptime(house$datetime, "%d/%m/%Y %H:%M:%S")

png("plot4.png", width = 480, height = 480)
opar<-par()
par(mfrow=c(2,2), oma=c(2,2,2,2))
plot(house$datetime, house$Global_active_power, type = "l", ylab="Global Active Power", xlab="")
plot(house$datetime, house$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(house$datetime, house$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(house$datetime, house$Sub_metering_2, col="red")
lines(house$datetime, house$Sub_metering_3, col="blue")
legend("topright", col=c("black","red", "blue"), legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"), lty=1, cex=0.8, bty="n")
plot(house$datetime, house$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()
par(opar)
