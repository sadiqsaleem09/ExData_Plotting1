library(sqldf)

#Change the path of your file accordingly
myfile<-"C:/Users/sadiq.rehmani/Desktop/Coursera/household_power_consumption.txt"

house<-read.csv.sql(myfile, sep=";",sql = 'select * from file where Date="1/2/2007" OR Date="2/2/2007"')
house$Date<-as.Date(house$Date, "%d/%m/%Y")
house$datetime<-paste(house$Date, house$Time)
house$datetime<-strptime(house$datetime, "%Y-%m-%d %H:%M:%S")

png("plot2.png", width = 480, height = 480)
plot(house$datetime, house$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()