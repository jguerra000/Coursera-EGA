
setwd("~/workspace/Repositories/Coursera-EGA")

# file <- download.file(url ="http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data.zip" )
# unzip(file)

if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

total_emissions <- aggregate(NEI$Emissions, list(NEI$year), sum)
names(total_emissions) <- c("Year", "Total")

png(filename = "./plot1.png", 
    width = 480, height = 480, 
    units = "px")

plot (total_emissions$Year, total_emissions$Total,
      xlab = "Year", 
      ylab = "Total (tons)",
      main="Total emissions of PM2.5 per year")

dev.off()


balt_data<- NEI[NEI$fips =="24510", ]
balt_total <- aggregate (balt_data$Emissions, list(balt_data$year), sum)
names(balt_total) <- c("Year", "Total")

png(filename = "./plot2.png", 
    width = 480, height = 480, 
    units = "px")

plot (balt_total$Year, balt_total$Total,
      xlab = "Year", 
      ylab = "Total (tons)",
      main="Total emissions of PM2.5 per year in Baltimore City")

dev.off()

png(filename = "./plot3.png", 
    width = 480, height = 480, 
    units = "px")

g <- ggplot(balt_data, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum", aes(group=type)) + 
  geom_point(stat = "summary", fun.y = "sum") +
  ylab(expression("Total PM2.5 Emissions (tons)")) +
  ggtitle("Total Emissions in Baltimore City from 1999 to 2008")

dev.off()




