library(dplyr)
library(lubridate)
library(car)
if(!file.exists("./data")){dir.create("./data")}
GeneralFiles <- list.files("./data", full.names = TRUE)
namesHPC <- read.table("./data/household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1)
RawHPC <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880)
names(RawHPC) <- namesHPC
RawHPC$Date <- strptime(RawHPC$Date, "%d/%m/%Y") ## We change the class of the "Date" column from "Character" to "Date"
RawHPC$Time <- hms(RawHPC$Time) ## We change the class of the "Time" column from "Character" to "POSIXt"
object.size(RawHPC) %>% print(units = "Mb", standard = "SI") ## Size of the Raw Data
##Plot 1
plot1 <- function(){
hist(RawHPC$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
}
plot1()
##Plot 2
plot2 <- function(){
with(RawHPC, plot(Date+Time,Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""))
}
plot2()
##Plot 3
plot3 <- function(box){
with(RawHPC, plot(Date+Time,Sub_metering_1, type = "n", 
                  ylab = "Global Active Power (kilowatts)",
                  xlab = ""))
with(RawHPC, points(Date+Time,Sub_metering_1, type = "l"))
with(RawHPC, points(Date+Time,Sub_metering_2, type = "l", col = "red"))
with(RawHPC, points(Date+Time,Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = box)
}
plot3()
##plot 4
plot4 <- function(){
par(mfrow = c(2,2))
##1
plot2()
##2
with(RawHPC, plot(Date+Time,Voltage, type = "l", xlab = "datetime"))
#3
plot3()
#4
with(RawHPC, plot(Date+Time,Global_reactive_power, type = "l", xlab = "datetime"))
}
plot4()
