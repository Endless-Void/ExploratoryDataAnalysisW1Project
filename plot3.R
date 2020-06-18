library(dplyr)
library(lubridate)
if(!file.exists("./data")){dir.create("./data")}
GeneralFiles <- list.files("./data", full.names = TRUE)
namesHPC <- read.table("./data/household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1)
RawHPC <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880)
names(RawHPC) <- namesHPC
RawHPC$Date <- strptime(RawHPC$Date, "%d/%m/%Y") ## We change the class of the "Date" column from "Character" to "Date"
RawHPC$Time <- hms(RawHPC$Time) ## We change the class of the "Time" column from "Character" to "POSIXt"
object.size(RawHPC) %>% print(units = "Mb", standard = "SI") ## Size of the Raw Data

##Plot 3
plot3 <- function(box){
        png(file = "plot3.png", width = 480, height = 480)
        with(RawHPC, plot(Date+Time,Sub_metering_1, type = "n", 
                          ylab = "Global Active Power (kilowatts)",
                          xlab = ""))
        with(RawHPC, points(Date+Time,Sub_metering_1, type = "l"))
        with(RawHPC, points(Date+Time,Sub_metering_2, type = "l", col = "red"))
        with(RawHPC, points(Date+Time,Sub_metering_3, type = "l", col = "blue"))
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = box)
        dev.off()
}
plot3("o")
##dev.copy(png, file = "plot3.png", width = 480, height = 480)
##dev.off()
