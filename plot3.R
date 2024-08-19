library(datasets)
library(dplyr)

file_path <- "/Users/jaredlim/Downloads/household_power_consumption.txt"
table <- read.csv(file, header = TRUE, sep = ";", stringsAsFactors=FALSE,
                  na.strings = "?",
                  colClasses = c('character','character', 'numeric','numeric',
                                 'numeric','numeric','numeric','numeric',
                                 'numeric'))

table$Date <- as.Date(table$Date, format = "%d/%m/%Y")

## table <- subset(table, Datae >= as.Date("2007-2-1") & 
##                   Date <= as.Date("2007-2-2"))

table <- table %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

datetime <- paste(table$Date, table$Time)
Datetime <- as.POSIXct(datetime)

table <- cbind(Datetime, table)
table$Date <- NULL
table$Time <- NULL

table <- table[complete.cases(table), ]

png(filename = "Plot 3.png", width = 480, height = 480)

p3 <- plot(table$Datetime, table$Sub_metering_1, type="l", 
           ylab="Energy sub metering", xlab="", col = "Black")
p3 <- lines(table$Datetime, table$Sub_metering_2, col="Red")
p3 <- lines(table$Datetime, table$Sub_metering_3, col="Blue")
p3 <- legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                                  "Sub_metering_1"),
             col=c("Black", "Red", "Blue"), lty="solid")

dev.off()

