
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(ggplot2)
library(markdown)

Sys.setlocale(category = "LC_ALL", locale = "en_US.utf8")

shinyUI(navbarPage("Winter Weather",
                   tabPanel("Plot",
                            sidebarLayout(
                                sidebarPanel(
                                    dateRangeInput(inputId = "dates", label = "Pick a range",
                                                   start = "2014-11-03", end = "2015-01-30",
                                                   min = "2014-11-01", max = "2015-02-01"),
                                    
                                    br(),
                                    
                                    radioButtons(inputId = "geoms", label = "Plot type",
                                                       choices = c("Point" = "point", "Area" = "area",
                                                                      "Path" = "path", "Raster" = "raster"),
                                                       selected = "path"),
                                    
                                    br(),
                                    
                                    selectInput(inputId = "features", label = "Condition",
                                                choices = c("Temperature" = "Mean_TemperatureC",
                                                            "DewPoint" = "MeanDew_PointC", "Humidity" = "Mean_Humidity",
                                                            "SeaLevelPressure" = "Mean_Sea_Level_PressurehPa",
                                                            "Visibility" = "Mean_VisibilityKm", "WindSpeed" = "Mean_Wind_SpeedKm_h",
                                                            "Precipitation" = "Precipitationmm", "CloudCover" = "CloudCover"),
                                                )
                                    
                                ),
                                mainPanel(
                                    plotOutput("weatherPlot")
                                )
                            )      
                   ),
                   tabPanel("Raw Table",
                            dataTableOutput("weatherTable")
                            
                   ),
                   navbarMenu("More",
                              tabPanel("Visit",
                                       h2("Visit Xi'an"),
                                       HTML('<p><a href="https://commons.wikimedia.org/wiki/File:Xian_guerreros_terracota_general.JPG#mediaviewer/File:Xian_guerreros_terracota_general.JPG"><img alt="Xian guerreros terracota general.JPG" src="https://upload.wikimedia.org/wikipedia/commons/9/9d/Xian_guerreros_terracota_general.JPG" height="427" width="640"></a><br>"<a href="https://commons.wikimedia.org/wiki/File:Xian_guerreros_terracota_general.JPG#mediaviewer/File:Xian_guerreros_terracota_general.JPG">Xian guerreros terracota general</a>". Licensed under Public Domain via <a href="//commons.wikimedia.org/wiki/">Wikimedia Commons</a>.</p>'),
                                       h4(a("Wikipedia: Xi'an", herf="https://en.wikipedia.org/wiki/Xi%27an", target="_blank")),
                                       h4(a("Visit Shaanxi Twitter", herf="https://twitter.com/visitshaanxi", target="_blank")),
                                       h4(a("TripAdvisor: Xi'an", herf="http://www.tripadvisor.com/Tourism-g298557-Xi_an_Shaanxi-Vacations.html", target="_blank"))
                              ),
                              tabPanel("About",
                                       includeMarkdown("README.md")
                              )
                   )
    )    
)
