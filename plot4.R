## PLOT4
## In order to execute this script, let's download the following zip file:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## then, the .txt file is unzipped and saved to the  working directory
destfile="household_power_consumption.zip"    
fileURL <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"   
if(!file.exists(destfile)) {
    download.file(fileURL ,destfile,method="auto") }

unzip ("household_power_consumption.zip")

## we read the table. It has a header and  ';' as separator; 
## character '?' in the file represents missing values (NA).
data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"))

## subset the dates whose data are going to be plotted
epc12feb <- subset(data1, Date == "1/2/2007" | Date == "2/2/2007")

## remove the table with all the data to free memory
remove (list = c("data1"))

## We're going to set the locale to english, 
## so any reviewer can check that the labels for the days are properly display in english.
Sys.setlocale("LC_ALL","English")

## Since the date and time columns are factors, 
## we're going to add a new variable with Date and Time stored as a POSIXlt
epc12feb$datetime <- strptime(paste(as.character(epc12feb$Date), as.character(epc12feb$Time)),  
                              "%d/%m/%Y %H:%M:%S" ) 

## Save to png graphical device
png("plot4.png", width= 480, height = 480)
## we're going to represent 4 plots in a 2x2 format. We will fill by columns.
par(mfcol = c(2,2))  

## plot the graphic of the Global Active Power with lines, the proper  labels
with(epc12feb, plot(datetime, Global_active_power, type = "l", xlab="",ylab = "Global Active Power"))

## plot the graphic of the 3 sub_metering variables and the legend
with(epc12feb, plot(datetime, Sub_metering_1, type = "l", xlab="",ylab = "Energy sub metering"))
with(epc12feb, lines(datetime, Sub_metering_2, col = "red"))
with(epc12feb, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright",lty=1, bty = "n", col = c("black", "red", "blue"), 
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

##plot voltage vs datetime
with(epc12feb, plot(datetime, Voltage , type = "l"))

##plot Global_reactive_power vs datetime
with(epc12feb, plot (datetime, Global_reactive_power , type = "l"))


dev.off()

## Check that in your working directory the file plot4.png has been created. End plot4