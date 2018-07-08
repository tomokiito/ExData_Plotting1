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


#################  plot1  #################

## Plot Histograms (plot1.R)
hist(mydata2$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",ylim = c(0,1200),
     col="Red")

## export file
dev.copy(png, file="plot1.png")
dev.off()
