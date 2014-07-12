# data files assumed to be in the subdirectory 'data' 
# of the directory containing the script
# SCC <- readRDS("data/Source_Classification_Code.rds")
# NEI <- readRDS("data/summarySCC_PM25.rds")

bl <- subset(NEI, fips == "24510")
la <- subset(NEI, fips == "06037")

motor <- SCC[grepl("mobile", SCC$EI.Sector, ignore.case=TRUE),]
codes <- motor[,c("SCC")]

motorbl <- bl[bl$SCC %in% codes,]
motorla <- la[la$SCC %in% codes,]

bltotal <- tapply(motorbl$Emissions, motorbl$year, sum)
latotal <- tapply(motorla$Emissions, motorla$year, sum)

bltotal <- log10(bltotal)
latotal <- log10(latotal)

rng <- range(bltotal, latotal)

par(mfrow=c(1,1), mar=c(5,5,4,3))
plot(names(bltotal), bltotal, type="o", pch=16,
     xlab="Years", ylim=rng, col="blue",
     ylab=expression('PM'[2.5]*' emissions (log'[10]*')'),
     #main=expression("Comparison of log scaled PM"[2.5]*" emissions between Baltimore City and LA County "))
     main="Comparison of log scaled PM2.5 emissions between \nBaltimore City and LA County ")
points(names(latotal), latotal, pch=15)
lines(names(latotal), latotal)
legend("center", 
       legend = c("LA County", "Baltimore City"),
       col = c("black","blue"),
       lwd = 1)
