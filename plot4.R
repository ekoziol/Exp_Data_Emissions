# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

# require libraries
require(reshape2)
require(ggplot2)

# read the data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# aggregate data
scc_coal_comb <- SCC[(grepl("Combustion", SCC$SCC.Level.One)) & 
                         (grepl("Coal", SCC$SCC.Level.Three)),"SCC"]
nei_coal_comb <- NEI[is.element(NEI$SCC, scc_coal_comb),]
df_melt <- melt(nei_coal_comb, id="year", measure.vars="Emissions")
emissionsCoalComb <- dcast(df_melt, year~variable, sum)

# plot data
png("plot4.png")
print(qplot(year, Emissions, data = emissionsCoalComb) + geom_line() + 
    labs(x="Year") + labs(y = "Total Emissions") + 
    labs(title = "Total Emissions from Coal Combustion in the US"))
dev.off()