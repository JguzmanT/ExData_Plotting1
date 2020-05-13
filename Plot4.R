#Plot4.R
#Author jguzmant
#Date 13/May/2020


#Opens Files
ElectricPC <- read.table("household_power_consumption.txt",skip = 1,sep=";",stringsAsFactors = FALSE)

#Since the Header names are split by . instead of ; it is necessary to name the cols here
colnames(ElectricPC) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Initially Date is loaded into the data frame as Character, though it must be changed to data
ElectricPC$Date <- as.Date(strptime(ElectricPC$Date,format="%d/%m/%Y",tz=""))

#It is only needed dates from 2007-02-01 to 2007-02-02 inclusive
FebruaryEPC <- subset(ElectricPC,Date >="2007-02-01" & Date <="2007-02-02")

#Global active power is also recognized as Character, it needs to be changed to numeric
FebruaryEPC$Global_active_power <- as.numeric(FebruaryEPC$Global_active_power)

#To have the series data, Date and time need to be merged into one field
DateTime <- paste(FebruaryEPC$Date,FebruaryEPC$Time)

#strptime to cast the field to Date
sDateTime <- strptime(DateTime, "%Y-%m-%d %H:%M:%S")

#Create four frames to place the plots
par(mfrow=c(2,2))

#Top-left plot Global Active Power
plot(x = sDateTime, y = FebruaryEPC$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Top-Right plot Voltage
plot(sDateTime,FebruaryEPC$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Bottom-left plot Energy sub metering
plot(x = sDateTime, y = FebruaryEPC$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x = sDateTime, y = FebruaryEPC$Sub_metering_2,col="red")
lines(x = sDateTime, y = FebruaryEPC$Sub_metering_3, col="blue")
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1),bty="n",cex=0.5)

#Bottom-right plot Global Reactive Power
plot(sDateTime,FebruaryEPC$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Copy plots to file
dev.copy(png,"Plot4.png")

#Release device
dev.off()

#Remove objects in R env
rm("DateTime","ElectricPC","FebruaryEPC","sDateTime")