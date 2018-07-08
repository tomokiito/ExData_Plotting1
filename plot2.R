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


#################  plot2  #################

# Create date_time ("date" + "time")  ## class is POSIXct
library(lubridate)
mydata3 <- mutate(mydata2, datetime = dmy_hms(paste(mydata2$Date,mydata2$Time)))

# Plot data (plot2.R)
plot(mydata3$Global_active_power~mydata3$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# export file
dev.copy(png, file="plot2.png")
dev.off()
