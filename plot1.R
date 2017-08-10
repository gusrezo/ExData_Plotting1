## PLOT1
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
##character '?' in the file represents missing values (NA).
data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"))

## subset the dates whose data are going to be plotted
epc12feb <- subset(data1, Date == "1/2/2007" | Date == "2/2/2007")

## remove the table with all the data to free memory
remove (list = c("data1"))


## Save to png graphical device
png("plot1.png", width= 480, height = 480)
## we're going to represent just 1 plot 
par(mfcol = c(1,1)) 

## plot the histogram of the Global Active Power with the proper color and labels
hist(epc12feb$Global_active_power, col = "red", main = "Global Active Power" , 
     xlab = "Global Active Power (kilowatts)")

dev.off()
## Check that in your working directory the file plot1.png has been created. End plot1