library(sqldf)

#Change the path of your file accordingly
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")
myfile<-"household_power_consumption.txt"

house<-read.csv.sql(myfile, sep=";",sql = 'select * from file where Date="1/2/2007" OR Date="2/2/2007"')
house$datetime<-paste(house$Date, house$Time)
house$datetime<-strptime(house$datetime, "%d/%m/%Y %H:%M:%S")

png("plot1.png", width = 480, height = 480)
hist(house$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()