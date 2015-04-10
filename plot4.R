##Code assumes that datafile = household_power_consumption.txt is already unzipped in working directory
#Read in data
energydata=read.table("household_power_consumption.txt", sep=";",na.strings="?",header=TRUE)

#Change class of date column from 'factor' to 'date'
energydata$Date=as.Date(energydata$Date, format="%d/%m/%Y")

#obtain required rows
requireddata=subset(energydata, energydata$Date=="2007-02-01"| energydata$Date =="2007-02-02")

#Combine Date and Time columns into 1 column
requireddata$DateTime=paste(requireddata$Date,requireddata$Time, sep= " ")

#Change class of DateTime column posixlt
requireddata$DateTime=strptime(requireddata$DateTime, format="%Y-%m-%d %H:%M:%S")

#Set 4 subplots and adjust axis and x,y label font size
par(mfrow=c(2,2),cex.lab=0.5, cex.axis=0.5)
#Plot topleft subplot
plot1=plot(requireddata$DateTime, requireddata$Global_active_power, ylab="Global Active Power", xlab=NA,type="l")
#Plot topright subplot
plot2=plot(requireddata$DateTime, requireddata$Voltage, xlab="datetime", ylab="Voltage",type="l")
#Plot bottomleft subplot
plot3=plot(x=requireddata$DateTime, y= requireddata$Sub_metering_1, ylab="Energy sub metering", xlab=NA,type="n")
lines(x=requireddata$DateTime, y= requireddata$Sub_metering_1,type="l")
lines(x=requireddata$DateTime, y= requireddata$Sub_metering_2,type="l", col="red")
lines(x=requireddata$DateTime, y= requireddata$Sub_metering_3,type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("Black","Red","Blue"), cex=0.5, bty="n")
#Plot bottomright subplot
plot4=plot(requireddata$DateTime, requireddata$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime",type="l")

#Save plot as png
dev.copy(png, file = "plot4.png")
dev.off()