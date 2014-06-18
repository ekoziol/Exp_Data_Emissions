# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
require(reshape2)
require(ggplot2)
# read the data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# aggregate data
NEI_Baltimore <- NEI[NEI$fips == "24510",]
df_melt <- melt(NEI_Baltimore, id = c("year", "type"), 
                measure.vars= "Emissions")
emissionsPerYearType <- dcast(df_melt, year+type ~ variable, sum)

# plot the data
png("plot3.png")
print(qplot(year, Emissions, data = emissionsPerYearType, color = type) + 
    geom_line() + labs(x="Year") + labs(y = "Total Emissions") + 
    labs(title = "Total Emissions per Year by Type of Measurement") + 
    scale_color_discrete(name = "Measurement Type"))
dev.off()