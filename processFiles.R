library(plotrix)
library(RColorBrewer)
data <- read.delim("FieldMuseum.txt", stringsAsFactors=FALSE)
money <- data[,which(grepl("X", names(data)))]
money <- apply(money, 2, as.numeric)
money <- data.frame(t(money))
colnames(money) <- data$ShortName

export.type <- "png"

SaveImage <- function(name, export.type) {
  if (export.type=="png") {
    png(file=paste(name, export.type, sep="."), width=700, height=700)
  }
  if (export.type=="pdf") {
    pdf(file=paste(name, export.type, sep="."), width=6, height=6)
    
  }
}

SaveImage("AssetsVsInvestment", export.type)
x <- money$investment_return/1e6
y <- (money$net_assets_ending-money$net_assets_beginning)/1e6
plot(x, y, bty="n", xlab="Investment return ($M)", ylab="Net asset growth ($M)", pch=16, asp=1, col=ifelse(y<0, "red", "black")) 
abline(h=0, lty="dotted")
abline(v=0, lty="dotted")
abline(a=0, b=1, lty="dashed")
thigmophobe.labels(x,y,money$year,col=ifelse(y<0, "red", "black")) 
dev.off()

SaveImage("GrowthResidualsVsMuseumResearchEtc", export.type)
x <- abs(money$collections_research + money$conservation + money$exhibitions + money$education)/1e6
y <- (money$net_assets_ending - money$net_assets_beginning - money$investment_return - money$rate_swaps)/1e6
plot(x, y, bty="n", xlab="Spending on collections, research,\nconservation, exhibitions, and education ($M)", ylab="Net asset growth NOT explained by investments or rate swaps ($M)", pch=16, col=ifelse(y<0, "red", "black"))
abline(h=0, lty="dotted")
thigmophobe.labels(x,y,money$year,col=ifelse(y<0, "red", "black")) 
dev.off()

DiffFromStart <- function(x) {
  x<-abs(x)
  return(x-x[1]) 
}

PercentDiffFromStart <- function(x) {
  x<-abs(x)
  return(100*(x-x[1])/x[1]) 
}


cols2plot<-c("collections_research", "education", "conservation", "administration", "marketing", "exhibitions")
mypalette<-brewer.pal(length(cols2plot),"Dark2")

SaveImage("PercentSpendingChange", export.type)
plot(x=c(2005, 2015), y=range(c(PercentDiffFromStart(money$exhibitions), PercentDiffFromStart(money$collections_research), PercentDiffFromStart(money$education), PercentDiffFromStart(money$conservation), PercentDiffFromStart(money$administration), PercentDiffFromStart(money$marketing))), ylim=c(-50, 200), xlab="Year", ylab="% Difference from 2005 spending", type="n", bty="n",xaxt="n")
axis(side=1, at=money$year, labels=money$year)

label.pos<-rep(NA, length(cols2plot))
label.text<-rep(NA, length(cols2plot))
for (col.index in sequence(length(cols2plot))) {
   y<-PercentDiffFromStart(money[,which(names(money)==cols2plot[col.index])])
   lines(money$year, y, col=mypalette[col.index])
   label.pos[col.index]<-y[length(y)]
   if(cols2plot[col.index]=="conservation") {
     label.pos[col.index]<-(-3)
   }
   label.text[col.index]<-paste(gsub("_","&",cols2plot[col.index]), round(y[length(y)],1), "%")
}
thigmophobe.labels(rep(max(money$year), length(cols2plot)), label.pos, labels=label.text, text.pos=4,  col=mypalette, cex=1.2)
abline(h=0, lty="dotted")
dev.off()

SaveImage("MonetarySpendingChange", export.type)
plot(x=c(2005, 2015), y=range(c(DiffFromStart(money$exhibitions), DiffFromStart(money$collections_research), DiffFromStart(money$education), DiffFromStart(money$conservation), DiffFromStart(money$administration), DiffFromStart(money$marketing))/1e6), xlab="Year", ylab="Difference from 2005 spending ($M)", type="n", bty="n",xaxt="n")
axis(side=1, at=money$year, labels=money$year)

label.pos<-rep(NA, length(cols2plot))
label.text<-rep(NA, length(cols2plot))
for (col.index in sequence(length(cols2plot))) {
  y<-DiffFromStart(money[,which(names(money)==cols2plot[col.index])])/1e6
  lines(money$year, y, col=mypalette[col.index])
  label.pos[col.index]<-y[length(y)]
  label.text[col.index]<-paste(gsub("_","&",cols2plot[col.index]), " $", round(y[length(y)],1), "M", sep="")
  if(cols2plot[col.index]=="conservation") {
    label.pos[col.index]<-(-0.6)
  }
}
abline(h=0, lty="dotted")
thigmophobe.labels(rep(max(money$year), length(cols2plot)), label.pos, labels=label.text, text.pos=4,  col=mypalette)
dev.off()

SaveImage("MarketingImpact", export.type)
x<-abs(money$marketing)/1e6
y<-(money$admissions+money$memberships)/1e6
model<-lm(y~x)
plot(x, y, xlim=c(0,6), bty="n", pch=16, xlab="Marketing ($M)", ylab="Admissions+Memberships ($M)",col=ifelse((money$net_assets_ending-money$net_assets_beginning)<0, "red", "black"), asp=1)
thigmophobe.labels(x,y,money$year,col=ifelse((money$net_assets_ending-money$net_assets_beginning)<0, "red", "black"))
lines(x=c(0,6), y=predict(model, newdata=data.frame(x=c(0,6))), lty="dotted")
text(x=4, y=predict(model, newdata=data.frame(x=4)), labels=paste("$1 more in marketing results in \n$", round(model$coefficients[2], 2), " more in admissions+memberships\n(incorrectly assuming no other factors)", sep=""), srt=atan(model$coefficients[2])/pi*180.0, cex=0.7, pos=1)
dev.off()