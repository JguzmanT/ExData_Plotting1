#Plot3.R
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

#Create plot, first put Sub meterin 1 data
plot(x = sDateTime, y = FebruaryEPC$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

#Add Data from Sub metering 2
points(x = sDateTime, y = FebruaryEPC$Sub_metering_2, type="l",col="red")

#Add data from sub metering 3
points(x = sDateTime, y = FebruaryEPC$Sub_metering_3, type="l",col="blue")

#Add labels to the right corner
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1,lwd=1)

#Save plot to Plot3.png
dev.copy(png,"Plot3.png")
dev.off()

rm("DateTime","ElectricPC","FebruaryEPC","sDateTime")