# data files assumed to be in the subdirectory 'data' 
# of the directory containing the script
SCC <- readRDS("data/Source_Classification_Code.rds")
NEI <- readRDS("data/summarySCC_PM25.rds")

png(filename = "plot1.png", width = 520, height = 520)

par(mfrow=c(1,1), mar=c(5,5,4,2))

sumyr <- tapply(NEI$Emissions, NEI$year, sum)
sumdf <- data.frame(year=names(sumyr), total=sumyr/1000000, 
                    stringsAsFactors=FALSE)

plot(sumdf$year, sumdf$total, type="o", pch=16,
     xlab="Years", 
     ylab=expression('PM'[2.5]*' emissions (millions of tons)'),
     main=expression("Yearly totals of PM"[2.5]*" emissions in the U.S."))

dev.off()