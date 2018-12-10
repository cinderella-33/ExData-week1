

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

png(filename = "plot2.png", width = 480, height = 480)

with(data2, plot(x=posix, y=as.numeric(data2$Global_active_power)/1000, type = "l",
                 xlab = "", ylab = "Global Active Power (kilowatts)"))
#, xaxt="n"
#axis(side = 1, )
dev.off()



