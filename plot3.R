plot3 <- function(){
        
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
        
        # plot 3
        plot.default(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(df$timestamp,df$Sub_metering_2,col="red")
        lines(df$timestamp,df$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ",
                "Sub_metering_2  ", "Sub_metering_3  "),lty=c(5,2,3), lwd=c(1,1,1), cex=0.5)
        
        dev.copy(png, file="plot3.png", width=480, height=480)
        dev.off()
        cat("Plot3.png has been saved in", getwd())
}