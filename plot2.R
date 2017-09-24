#Read data from file assuming the file to be in the working directory.
my_data <-
    read.table(
        "household_power_consumption.txt",
        header = TRUE,
        sep = ";",
        na.strings = "?",
        dec = ".",
        colClasses = c(
            "character",
            "character",
            "numeric",
            "numeric",
            "numeric",
            "numeric",
            "numeric",
            "numeric",
            "numeric"
        )
    )

#Convert data types Date and Time types respectively and storing the combined DateTime stamp in the Date column
my_dates <- my_data$Date
my_times <- my_data$Time
x <- paste(my_dates, my_times)
my_data$Date <- strptime(x, "%d/%m/%Y %H:%M:%S")

#Subsetting data for the two releavnt days
my_data2 <-
    subset(my_data, Date >= "2007-02-01" & Date < "2007-02-03")

#Opening PNG device
png(filename = "plot2.png",
    width = 480,
    height = 480)

#Plotting
plot(
    x = my_data2$Date,
    y = my_data2$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)

#Closing PNG device
dev.off()