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

#Plot curve
plot2=plot(requireddata$DateTime, requireddata$Global_active_power, ylab="Global Active Power (kilowatts)", xlab=NA,type="l")


#Save plot as png
dev.copy(png, file = "plot2.png")
dev.off()