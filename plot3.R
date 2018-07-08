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


#################  plot3  #################

# Create date_time ("date" + "time")  ## class is POSIXct
library(lubridate)
mydata3 <- mutate(mydata2, datetime = dmy_hms(paste(mydata2$Date,mydata2$Time)))

# Plot data (plot3.R)
with(mydata3, {
        plot(Sub_metering_1~datetime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~datetime, col='Red')
        lines(Sub_metering_3~datetime, col='Blue')
})
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, lwd=1)


# export file
dev.copy(png, file="plot3.png")
dev.off()
