
library(sqldf)

#Change the path of your file accordingly
myfile<-"C:/Users/sadiq.rehmani/Desktop/Coursera/household_power_consumption.txt"


house<-read.csv.sql(myfile, sep=";",sql = 'select * from file where Date="1/2/2007" OR Date="2/2/2007"')
house$Date<-as.Date(house$Date, "%d/%m/%Y")
house$datetime<-paste(house$Date, house$Time)
house$datetime<-strptime(house$datetime, "%Y-%m-%d %H:%M:%S")

png("plot4.png", width = 480, height = 480)
opar<-par()
par(mfrow=c(2,2), oma=c(2,2,2,2))
plot(house$datetime, house$Global_active_power, type = "l", ylab="Global Active Power", xlab="")
plot(house$datetime, house$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(house$datetime, house$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(house$datetime, house$Sub_metering_1)
lines(house$datetime, house$Sub_metering_2, col="red")
lines(house$datetime, house$Sub_metering_3, col="blue")
legend("topright", col=c("black","red", "blue"), legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"), lty=1, cex=0.6)
plot(house$datetime, house$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()
par(opar)