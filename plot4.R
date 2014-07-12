# data files assumed to be in the subdirectory 'data' 
# of the directory containing the script
# SCC <- readRDS("data/Source_Classification_Code.rds")
# NEI <- readRDS("data/summarySCC_PM25.rds")

coal <- SCC[grepl("coal", SCC$EI.Sector, ignore.case=TRUE),]
codes <- coal[,c("SCC")]
coaldata <- NEI[NEI$SCC %in% codes,]

ctotal <- tapply(coaldata$Emissions, coaldata$year, sum)

plot(names(ctotal), ctotal, type="o", pch=16,
     xlab="Years", 
     ylab=expression('PM'[2.5]*' emissions (tons)'),
     main=expression("Yearly totals of PM"[2.5]*" emissions from coal sources in the U.S."))