#SCC <- readRDS("data/Source_Classification_Code.rds")
#NEI <- readRDS("data/summarySCC_PM25.rds")

# plot 1 (total)
par(mar=c(5,6,4,2))
sumyr <- tapply(NEI$Emissions, NEI$year, sum)
sumdf <- data.frame(year=names(sumyr), total=sumyr/1000000, stringsAsFactors=FALSE)
plot(sumdf$year, sumdf$total, type="o", pch=16,
     xlab="Years", 
     ylab=expression('PM'[2.5]*' emissions (millions of tons)'),
     main=expression("Yearly totals of PM"[2.5]*" emissions in the U.S."))

# plot 1 (mean)
# meanyr <- tapply(NEI$Emissions, NEI$year, mean)
# meandf <- data.frame(year=names(meanyr), value=meanyr, stringsAsFactors=FALSE)
# plot(meandf$year, meandf$value, type="o", pch=16, 
#      xlab="Years", 
#      ylab=expression('PM'[25]*' Emissions'),
#      main="Emissions by Year")