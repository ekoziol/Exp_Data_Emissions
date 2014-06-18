# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

#read the data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

#aggregate the data
# create new data frame that aggregates the total emissions per year
NEI_Baltimore <- NEI[NEI$fips == "24510",]
emissionsPerYear <- aggregate(NEI_Baltimore$Emissions
                              ,by=list((NEI_Baltimore$year)),sum)
names(emissionsPerYear) <- c("Year", "totalEmissions")

#create the plot
png("plot2.png")
plot(emissionsPerYear, type="l", ylab="Total Emissions", xlab="Year",
     main = "Total Emissions Per Year for Baltimore City")
dev.off()