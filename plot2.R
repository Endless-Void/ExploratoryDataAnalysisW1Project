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

##Plot 2
plot2 <- function(){
        png(file = "plot2.png", width = 480, height = 480)
        with(RawHPC, plot(Date+Time,Global_active_power, type = "l",
                          ylab = "Global Active Power (kilowatts)",
                          xlab = ""))
}
plot2()
##dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()