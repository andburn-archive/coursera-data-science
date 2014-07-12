# data files assumed to be in the subdirectory 'data' 
# of the directory containing the script
SCC <- readRDS("data/Source_Classification_Code.rds")
NEI <- readRDS("data/summarySCC_PM25.rds")

# plot 2 (total)
par(mar=c(5,5,4,2))
bl <- subset(NEI, fips == "24510")
sumyr <- tapply(bl$Emissions, bl$year, sum)
sumdf <- data.frame(year=names(sumyr), total=sumyr, 
                    stringsAsFactors=FALSE)
plot(sumdf$year, sumdf$total, type="o", pch=16,
     xlab="Years", 
     ylab=expression('PM'[2.5]*' emissions (tons)'),
     main=expression("Yearly totals of PM"[2.5]*" emissions for Baltimore, MD"))