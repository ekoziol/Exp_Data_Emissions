# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in 
# motor vehicle emissions?

#read the data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# aggregate data
vehicleSources <- SCC[grepl("vehicle", SCC$SCC.Level.Two, 
                            ignore.case = TRUE),"SCC"]
# Baltimore
NEI_BaltLA <- NEI[(NEI$fips == "24510") | (NEI$fips == "06037"),]
BaltLAVehicles <- NEI_BaltLA[is.element(NEI_BaltLA$SCC, 
                                              vehicleSources),]
df_melt <- melt(BaltLAVehicles, id=c("year", "fips"), measure.vars="Emissions")
emissionsBaltLA <- dcast(df_melt, year+fips~variable, sum)
emissionsBaltLA[emissionsBaltLA$fips == "24510", "fips"] <- 
    "Baltimore City"
emissionsBaltLA[emissionsBaltLA$fips == "06037", "fips"] <- "LA"


# plot data
png("plot6.png")
print(qplot(year, Emissions, data = emissionsBaltLA, col=fips) + geom_line() + 
          labs(x="Year") + labs(y = "Total Emissions") + 
          labs(title = "Total Emissions from Motor Vehicles 
               in the Baltimore City and LA") +
          scale_color_discrete(name = "City"))
dev.off()