#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", # name of variable
                  "Number of bins:", # title
                  min = 1, # minimum value
                  max = 50, # maximum value
                  value = 30) # default value
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("histogram") # generate a plot
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


shiny::runGitHub("st_petersburg_game","SMAC-Group")



# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel(h4("St-Petersburg paradox games")),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("n_games", "Number of games:", 10, 1, 1e4),
      numericInput("fee", "Fee for playing one game:", 10, 1, 1e7),
      numericInput("seed", "Simulation seed", 123, 1, 1e7),
      actionButton("play", "Let's play the games!", icon = icon("gamepad"))
    ),
    
    mainPanel(
      plotOutput("hist")
    )
  )
)

st_petersburg_game <- function( # function that returns gains with class "sp_game"
  n_games,
  fee,
  seed){
  # st Petersburg game
  gains <- vector(mode = "double", length = n_games)
  
  set.seed(seed)
  
  for(i in 1:n_games){
    head <- TRUE
    bet <- 1
    while (head) {
      # toss a coin
      x <- rbinom(n = 1, size = 1, prob = 0.5) 
      
      # verify the coin
      if(x == 0){
        head <- FALSE
      }
      
      # update the bet
      bet <- bet * 2
    }
    # save the result
    gains[i] <- bet - fee
  }
  
  
  class(gains) <- "sp_game"
  gains
} 

x <- st_petersburg_game(n_games = 10, fee = 10, seed = 123)
plot(x)
plot.default(x)

plot.sp_game <- function(obj){ # defines the plot to return for "sp_game"
  mu <- round(mean(obj),2)
  h <- hist(obj, ylab = "number of games", xlab = "gains", col = "gray70", border = "white", 
            cex.lab = 2, main = "Distribution of gains in St-Petersburg games", cex.main = 2, col.axis="gray30",
            nclass = max(10, min(length(obj)/10,50)), probability = F)
  text(x = (max(obj)+min(obj))/2, y = max(h$counts), labels = paste0("Average gain: ",mu), col = "red", cex = 2)
} 


server <- function(input, output) {
  
  # play the games
  play <- eventReactive(input$play, {
    # St-Petersburg function that creates an object of class "sp_game"
    st_petersburg_game(n_games = input$n_games, fee = input$fee, 
                       seed = input$seed)
  })
  
  # plot the output
  output$hist <- renderPlot({
    plot(play())
  }, height = 620)
}

runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer


