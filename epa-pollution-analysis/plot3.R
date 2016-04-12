library(ggplot2)
library(reshape2)

# data files assumed to be in the subdirectory 'data' 
# of the directory containing the script
SCC <- readRDS("data/Source_Classification_Code.rds")
NEI <- readRDS("data/summarySCC_PM25.rds")

png(filename = "plot3.png", width = 520, height = 520)

bl <- subset(NEI, fips == "24510")

typeyr <- tapply(bl$Emissions, list(bl$year, bl$type), sum)

types <- data.frame(year=row.names(typeyr), 
                  typeyr, 
                  row.names=c(1:4), 
                  stringsAsFactors=F)

mt <- melt(types, id.vars="year")
mt$year <- as.integer(mt$year)

gp <- ggplot(mt, aes(x=year, y=value, fill=variable)) 
gp <- gp + geom_line() + geom_point(size=4, shape=21)
gp <- gp + ggtitle("Total yearly PM2.5 emissions in Baltimore, MD by source")
gp <- gp + xlab("Years") + ylab("PM2.5 Emissions (tons)") + labs(fill="Sources")
print(gp)

dev.off()