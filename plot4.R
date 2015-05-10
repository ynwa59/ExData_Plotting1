plot4 <- function(){
        
        #read header
        header <- read.table("household_power_consumption.txt",header=FALSE, nrows=1, sep=";")        
        
        #read from 2007-02-01 and 2007-02-02        
        df <- read.table("household_power_consumption.txt",header=FALSE, skip=66637, nrows=2880, sep=";")
        
        #append header
        colnames(df) <- unlist(header, use.name=TRUE)
        
        #change date format
        newdate <- strptime(as.character(df$Date), "%d/%m/%Y")
        df$Date <- format(newdate, "%Y-%m-%d")
        
        #POSIXct converts to day of the week
        df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)))
        
        # for multiple lot figure
        par(mfrow=c(2,2))
        
        # plot 4
        plot.default(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        plot.default(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot.default(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(df$timestamp,df$Sub_metering_2,col="red")
        lines(df$timestamp,df$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", 
                                                          "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
        plot.default(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("Plot4.png has been saved in", getwd())
}