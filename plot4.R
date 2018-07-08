library(dplyr)

# Read data
mydata <- read.table("household_power_consumption.txt",
                     header=T,na.strings="?",sep=";") %>%
                     as_data_frame

# Select date and time colum
my.date <- select(mydata,Date:Time)

# Start at "2007/02/01 00:00:00"
my.date.srt <- which(my.date$Date == "1/2/2007" & my.date$Time == "00:00:00")

# End   at "2007/02/02 23:59:00"
my.date.end <- which(my.date$Date == "2/2/2007" & my.date$Time == "23:59:00")

# Set data
mydata2 <- mydata[my.date.srt:my.date.end,]


#################  plot4  #################

# Create date_time ("date" + "time")  ## class is POSIXct
library(lubridate)
mydata3 <- mutate(mydata2, datetime = dmy_hms(paste(mydata2$Date,mydata2$Time)))

# 4 plot
par(mfcol=c(2,2),mar=c(4, 4, 2, 1))

# (1) plot2.R
plot(mydata3$Global_active_power~mydata3$datetime, type="l", ylab="Global Active Power", xlab="")


# (2) plot3.R
with(mydata3, {
        plot(Sub_metering_1~datetime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~datetime, col='Red')
        lines(Sub_metering_3~datetime, col='Blue')
})
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, lwd=1, bty="n", cex=0.8)

# (3) plot Voltage
plot(mydata3$Voltage~mydata3$datetime, type="l", ylab="Voltage", xlab="datetime")

# (4) plot Reactive power
plot(mydata3$Global_reactive_power~mydata3$datetime, type="l",
     ylab="Global_reactive_power",cex.axis = 0.8,
     xlab="datetime")


# export file
dev.copy(png, file="plot4.png")
dev.off()
