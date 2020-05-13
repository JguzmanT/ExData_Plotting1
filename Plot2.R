#Plot2.R
#Author jguzmant
#Date 13/May/2020


#Open Files
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

#Create plot Global Active Power
plot(x = sDateTime, y = FebruaryEPC$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Save plot to file Plot2.png
dev.copy(png,"Plot2.png")
dev.off()

rm("DateTime","ElectricPC","FebruaryEPC","sDateTime")
