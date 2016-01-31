library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Calculate the Moving Average for your TimeSeries"),

  # Sidebar with a slider input for number of observations
  sidebarPanel(
	fileInput('file1', 'Choose input CSV File',
              #accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
              accept=c('text/csv')),
	numericInput("days", "Moving Average Window:", 10),
	actionButton("goButton", "Calculate"),
	includeHTML("EasyTimeSeries.html")
  ),

  # Show a plot of the generated distribution
  mainPanel(
    verbatimTextOutput("summary"),
    plotOutput("plot")
    
  )
))
