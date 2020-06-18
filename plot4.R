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
plot4 <- function(){
        png(file = "plot4.png", width = 480, height = 480)
        par(mfrow = c(2,2))
        ##1
        plot2()
        ##2
        with(RawHPC, plot(Date+Time,Voltage, type = "l", xlab = "datetime"))
        #3
        plot3("n")
        #4
        with(RawHPC, plot(Date+Time,Global_reactive_power, type = "l", xlab = "datetime"))
        dev.off()
        par(mfrow = c(1,1))
}
plot4()
##dev.copy(png, file = "plot4.png", width = 480, height = 480)
##dev.off()
##par(mfrow = c(1,1))