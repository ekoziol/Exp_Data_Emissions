# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.

#read the data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# create new data frame that aggregates the total emissions per year
emissionsPerYear <- aggregate(NEI$Emissions,by=list((NEI$year)),sum)
names(emissionsPerYear) <- c("Year", "totalEmissions")

#create the plot
png("plot1.png")
plot(emissionsPerYear, type="l", ylab="Total Emissions", xlab="Year",
     main = "Total Emissions Per Year")
dev.off()