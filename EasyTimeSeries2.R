library(zoo)

EasyTimeSeries <- function(x,y){

n <- ncol(x)
r <- nrow(x)
if( n != 2 ) {

print ("You can have only 2 columns in the dataset")

stopifnot(n != 2)

} 
else if ( r > 5000 ) {

print ("You cannot have more than 5000 rows in the dataset")

stopifnot(r > 5000)

}
else {
mydate=as.Date(x[,1]);

params <- colnames(x)

mydate2 <- mydate[order(mydate)]

temp.zoo<-zoo(x[,2],mydate)

m.av<-rollmean(temp.zoo, y,fill = list(NA, NULL, NA))

ggplot(x, aes(mydate, x[,2])) + geom_line() +
  geom_line(aes(mydate2,m.av),color="red",na.rm = TRUE) + xlab(params[1]) + ylab( params[2])
}
}
