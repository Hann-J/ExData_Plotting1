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

datetime <- paste(table$Date, table$Time)
Datetime <- as.POSIXct(datetime)

table <- cbind(Datetime, table)
table$Date <- NULL
table$Time <- NULL

table <- table[complete.cases(table), ]

png(filename = "Plot 2.png", width = 480, height = 480)
p2 <- plot(table$Datetime, table$Global_active_power, type='l', xlab = "",
           ylab = "Global Active Power (kilowatt)")

## library(ggplot2)

## p2 <- ggplot(table, aes(Datetime, Global_active_power) + geom_line() + labs(
##  ylab="Global Active Power (kilowatts)", xlab = ""))

dev.off()

