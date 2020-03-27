library(shiny)
.mt <- yaml::read_yaml("example_gen.yaml")
.physio <- yaml::read_yaml("physio.yaml")
generate_module(.mt) %>% write_module("pkModule.R")
generate_module(.physio) %>% write_module("physioModule.R")
source("pkModule.R")
source("physioModule.R")
ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  pkUI("pk"),
  physioUI("physio"),
  verbatimTextOutput("value")
)

server <- function(input, output) {
  pkVals <- pkServer("pk")
  physioVals <- physioServer("physio")
  output$value <- renderText({ sprintf("vka: %s, vFa: %s, vCL_Ki: %s",
                                       pkVals$vka(), pkVals$vFa(), pkVals$vCL_Ki()) })
}
shinyApp(ui, server)
