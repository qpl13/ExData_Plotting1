# downlaod file and unzip

if(!file.exists("data.zip"))
  
  file_url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url,destfile="data.zip")
unzip("data.zip", exdir="C:/User/ren/documents/R/Myproject")

setwd ("c:/Users/ren/documents/R/myproject")

#read data file as data frame

homepower<- read.table("household_power_consumption.txt", 
                       header=TRUE, sep= ";",na.strings="?")


# combine Date and Time to form 1 column called time.
homepower$time <- paste(homepower$Date,homepower$Time)
# Change the time factor to Date type

homepower$Date<-as.Date(as.character(homepower$Date),"%d/%m/%Y")
homepower$time <- strptime(homepower$time, "%d/%m/%Y %H:%M:%S")

#subset data
start<- which(homepower$time==strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
end<- which(homepower$time==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

homepower_two_days<- homepower[start:end,]

# plot 3
# open file
png(filename="plot3.png",width = 480, height = 480)
plot(homepower_two_days$time, homepower_two_days$Sub_metering_1,type = "l",
     ylab="Energy sub metering", xlab="")
  lines(homepower_two_days$time, homepower_two_days$Sub_metering_2,col="red")
  lines(homepower_two_days$time, homepower_two_days$Sub_metering_3,col="blue")
    legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),
             col=c("black","red","blue"))

    # save file
    dev.off()