library(datasets)
library(dplyr)

file_path <- "/Users/jaredlim/Downloads/household_power_consumption.txt"
table <- read.csv(file, header = TRUE, sep = ";", stringsAsFactors=FALSE,
                  na.strings = "?",
                  colClasses = c('character','character', 'numeric','numeric',
                                 'numeric','numeric','numeric','numeric',
                                 'numeric'))

table$Date <- as.Date(table$Date, format = "%d/%m/%Y")

## table <- subset(table, Date >= as.Date("2007-2-1") & 
##                   Date <= as.Date("2007-2-2"))

table <- table %>%
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

png(filename = "Plot 1.png", width = 480, height = 480)
hist(as.numeric(table$Global_active_power), main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()


