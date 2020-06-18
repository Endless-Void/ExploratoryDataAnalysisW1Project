library(dplyr)
library(lubridate)
if(!file.exists("./data")){dir.create("./data")}
GeneralFiles <- list.files("./data", full.names = TRUE)
namesHPC <- read.table("./data/household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1)
RawHPC <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880)
names(RawHPC) <- namesHPC
RawHPC$Date <- strptime(RawHPC$Date, "%d/%m/%Y") ## We change the class of the "Date" column from "Character" to "Date"
RawHPC$Time <- hms(RawHPC$Time) ## We change the class of the "Time" column from "Character" to "POSIXt"

##Plot 1
plot1 <- function(){
        png(file = "plot1.png", width = 480, height = 480)
        hist(RawHPC$Global_active_power, col = "red",
             xlab = "Global Active Power (kilowatts)",
             main = "Global Active Power")
        dev.off()
}
plot1()
##dev.copy(png, file = "plot1.png", width = 480, height = 480)
##dev.off()

