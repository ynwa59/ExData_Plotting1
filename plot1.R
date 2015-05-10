plot1 <- function(){
        
        #read header
        header <- read.table("household_power_consumption.txt",header=FALSE, nrows=1, sep=";")        

        #read from 2007-02-01 and 2007-02-02        
        df <- read.table("household_power_consumption.txt",header=FALSE, skip=66637, nrows=2880, sep=";")

        #append header
        colnames(df) <- unlist(header, use.name=TRUE)
        
        #change date format
        newdate <- strptime(as.character(df$Date), "%d/%m/%Y")
        df$Date <- format(newdate, "%Y-%m-%d")
        
        # plot 1
        # Colored Histogram with Different Number of Bins
        hist(df$Global_active_power, breaks=12, col="red", xlab="Global Active Power (kilowatts)", main="Histogram of Global Active Power")        
        
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}