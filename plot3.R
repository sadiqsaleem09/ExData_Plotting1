library(sqldf)

#Change the path of your file accordingly
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")
myfile<-"household_power_consumption.txt"

house<-read.csv.sql(myfile, sep=";",sql = 'select * from file where Date="1/2/2007" OR Date="2/2/2007"')
house$datetime<-paste(house$Date, house$Time)
house$datetime<-strptime(house$datetime, "%d/%m/%Y %H:%M:%S")

png("plot3.png", width = 480, height = 480)
plot(house$datetime, house$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(house$datetime, house$Sub_metering_2, col="red")
lines(house$datetime, house$Sub_metering_3, col="blue")
legend("topright", col=c("black","red", "blue"), legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"), lty=1, cex=0.8)
dev.off()