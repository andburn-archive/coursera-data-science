# data files assumed to be in the subdirectory 'data' 
# of the directory containing the script
# SCC <- readRDS("data/Source_Classification_Code.rds")
# NEI <- readRDS("data/summarySCC_PM25.rds")

bl <- subset(NEI, fips == "24510")

motor <- SCC[grepl("mobile", SCC$EI.Sector, ignore.case=TRUE),]
codes <- motor[,c("SCC")]
motordata <- bl[bl$SCC %in% codes,]

mtotal <- tapply(motordata$Emissions, motordata$year, sum)

plot(names(mtotal), mtotal, type="o", pch=16,
     xlab="Years", 
     ylab=expression('PM'[2.5]*' emissions (tons)'),
     main=expression("Yearly totals of PM"[2.5]*" emissions from \nvehicular sources in Balitmore, MD"))
