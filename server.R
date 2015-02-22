
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(weatherData)
library(ggplot2)
library(dplyr)

if(!exists("weatherXI")){
    weatherXI <- getWeatherForDate(station_id = "ZLXY", start_date = "2014-11-01", end_date = "2015-01-31", station_type = "ID", opt_custom_columns = TRUE, custom_columns = c(3,6,9,12,15,18,20,21))
    weatherXI <- mutate(weatherXI, Date = as.character(Date))
}

shinyServer(function(input, output) {

   subData <- reactive({
       filter(weatherXI, Date >= as.character(input$dates[1]) & Date <= as.character(input$dates[2]))[, c("Date", input$features)]
    })
   
    
  output$weatherPlot <- renderPlot({
      wData <- subData()
      wData <- mutate(wData, Date = as.Date(Date))
      qplot(x = wData[,1], y = wData[,2], data = wData, geom = input$geoms,
            environment = environment(),
            main = "2014~2015 Winter Weather Condition in Xi'an, China",
            xlab = "Date", ylab = input$features)
    

  })
  
  output$weatherTable <- renderDataTable({
     return(weatherXI)
#       return(subData())
  })

})
