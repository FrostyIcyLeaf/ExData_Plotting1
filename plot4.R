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
png(filename = "plot4.png",
    width = 480,
    height = 480)

#Plotting
#Setting the scene for 4 plots in one
par(mfrow = c(2, 2))

#Plot 1
plot(
    x = my_data2$Date,
    y = my_data2$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power"
)

#Plot 2
plot(
    x = my_data2$Date,
    y = my_data2$Voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
)

#Plot 3
plot(
    x = my_data2$Date,
    y = my_data2$Sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy sub metering",
    col = "black"
)
lines(x = my_data2$Date,
      y = my_data2$Sub_metering_2,
      col = "red")
lines(x = my_data2$Date,
      y = my_data2$Sub_metering_3,
      col = "blue")
legend(
    "topright",
    lty = c(1, 1, 1),
    bty = "n",
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

#Plot 4
plot(
    x = my_data2$Date,
    y = my_data2$Global_reactive_power,
    type = "l",
    xlab = "datetime",
    ylab = "Global_reactive_power"
)

#Closing PNG device
dev.off()