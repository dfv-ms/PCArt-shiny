#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(PCArt)

images <- get_list_of_images()

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("PCA Demo"),

    # Sidebar with a slider input for number of components and images
    sidebarLayout(
        sidebarPanel(
            sliderInput("components",
                        "Number of components:",
                        min = 1,
                        max = 25,
                        step = 1,
                        value = 1),
            sliderInput("image_no",
                        "Number of image:",
                        min = 1,
                        max = length(images),
                        step = 1,
                        value = 1),
            checkboxInput("showDetails", "show details", FALSE)
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("pcaPlot"),
           verbatimTextOutput("details")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$pcaPlot <- renderPlot({
        pca_plot(images[[input$image_no]]$image, input$components)
    })
    
    output$details <- renderText({
        if(input$showDetails) {
            paste0(images[[input$image_no]]$title, " by ", images[[input$image_no]]$artist)
        }else{
            ""
        }
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
