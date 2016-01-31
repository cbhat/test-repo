library(shiny)
library(zoo)
library(ggplot2)


# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {

  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #

  output$summary <- renderPrint({

if ( input$goButton > 0 ) {
inFile <- input$file1

    if (is.null(inFile))
      return(NULL)
    x <- read.csv(inFile$datapath)
    y <- input$days




n <- ncol(x)
r <- nrow(x)
if( n != 2 ) {

print (paste0("You can have only 2 columns in the dataset,got ", n))


}
else if ( r > 5000 ) {

print (paste0("You cannot have more than 5000 rows in the dataset, got ", r))


}

else if ( (y + 1) > r ) {

print( paste0( "The number of days selected exceeds the number of days available in the dataset, by ", (y+ 1 -r)))
}
else {
print( paste0( "Input Dataset Size " , r, ", Moving average window size ", y))
}

}
})


  output$plot <- renderPlot({

if ( input$goButton > 0  ) {

 inFile <- input$file1

    if (is.null(inFile))
      return(NULL)
    
    #x <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
    x <- read.csv(inFile$datapath)



y <- input$days

n <- ncol(x)
r <- nrow(x)
if( n != 2 ) {

stopifnot(n != 2)

} 
else if ( r > 5000 ) {


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

  })


  })
