# Load Libraries
library(shiny)
library(tidyverse)
library(here)
library(lubridate)

# Load Data
data_raw <- read_csv(here("Week_10","data", "HatchBabyExport.csv")) # load from file
view(data_raw) # check data structure

# Format data
colnames(data_raw) = gsub(" ", "_",colnames(data_raw)) # remove spaces from column names to be able to call on them
#data <- mutate(data_raw, Start_Time = ymd_hm(Start_Time), End_Time = ymd_hm(End_Time))
data <- data_raw %>%
    select(Baby_Name, Start_Time, Activity, Amount) %>%
    pivot_wider(names_from = Activity,
                values_from = Amount
    ) %>%
    mutate(Start_Date = str_remove(Start_Time, "AM")) %>%
    mutate(Start_Date = str_remove(Start_Date, "PM")) %>%
    separate(Start_Date, into = c("Date", "Time"), ".") %>%
    mutate(Date = parse_date(Date, c("%m/%d/%Y"))) %>%
    
    view(data)





# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("darkly"),
                
                # Application title
                titlePanel("Baby activity and measurements data visualization"),
                
                # Sidebar with a slider input for number of bins 
                sidebarLayout(
                    sidebarPanel(
                        radioButtons(inputId = "which_var",
                                     label = "Activity or measurement type:",
                                     choiceValues = c("feeding","diaper","sleep","weight","length"), 
                                     choiceNames = c("Feeding","Diaper","Sleep","Weight","Length")
                        )
                    ),
                    
                    # Show a plot of the generated distribution
                    mainPanel(
                        plotOutput("distPlot")
                    )
                )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
