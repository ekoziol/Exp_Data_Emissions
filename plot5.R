# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City? 


#read the data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# aggregate data
vehicleSources <- SCC[grepl("vehicle", SCC$SCC.Level.Two, 
                            ignore.case = TRUE),"SCC"]
NEI_Baltimore <- NEI[NEI$fips == "24510",]
baltimoreVehicles <- NEI_Baltimore[is.element(NEI_Baltimore$SCC, 
                                              vehicleSources),]
df_melt <- melt(baltimoreVehicles, id="year", measure.vars="Emissions")
emissionsVehicles <- dcast(df_melt, year~variable, sum)

# plot data
png("plot5.png")
print(qplot(year, Emissions, data = emissionsCoalComb) + geom_line() + 
          labs(x="Year") + labs(y = "Total Emissions") + 
          labs(title = "Total Emissions from Motor Vehicles 
               in the Baltimore City"))
dev.off()