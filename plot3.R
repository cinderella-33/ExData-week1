

library(dplyr)

#read data

temp <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
data <- read.delim(unz(temp, "household_power_consumption.txt"), sep = ";")
unlink(temp)

View(data)

data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

data2 <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

data2$posix <- as.POSIXct(strptime(paste(data2$Date, data2$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))

# par(col="red")

png(filename = "plot3.png", width = 480, height = 480)

with(data2, plot(x=posix, y=as.numeric(data2$Sub_metering_1), type = "l",
                 xlab = "", ylab = "Energy sub metering", yaxt = "n", col="black"))
axis(2, las=3, at=c(0,10,20,30))
lines(x=data2$posix, y=as.numeric(data2$Sub_metering_2), type = "l", col="red")
lines(x=data2$posix, y=as.numeric(data2$Sub_metering_3), type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)

dev.off()



