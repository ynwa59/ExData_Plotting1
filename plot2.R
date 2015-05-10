plot2 <- function(){
        
        #read header
        header <- read.table("household_power_consumption.txt",header=FALSE, nrows=1, sep=";")        
        
        #read from 2007-02-01 and 2007-02-02        
        df <- read.table("household_power_consumption.txt",header=FALSE, skip=66637, nrows=2880, sep=";")
        
        #append header
        colnames(df) <- unlist(header, use.name=TRUE)
        
        #change date format
        newdate <- strptime(as.character(df$Date), "%d/%m/%Y")
        df$Date <- format(newdate, "%Y-%m-%d")
        
        # plot 2
        #add a column calls timestamp
        #POSIXct converts to day of the week
        df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)))
        plot.default(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        
        dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
        cat("Plot2.png has been saved in", getwd())
}