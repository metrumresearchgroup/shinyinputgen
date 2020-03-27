library(shiny)
# .mt <- yaml::read_yaml("example_gen.yaml")
#  .multi <- yaml::read_yaml("multi-input.yml")
# # generate_module(.mt) %>% write_module("pkModule.R")
#  generate_module(.multi) %>% write_module("multiModule.R")
source("pkModule.R")
source("multiModule.R")
ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  pkUI("pk"),
  multiUI("multi"),
  verbatimTextOutput("value")
)

server <- function(input, output) {
  pkVals <- pkServer("pk")
  multiVals <- multiServer("multi")
  output$value <- renderText({ sprintf("vka: %s, vFa: %s, vCL_Ki: %s",
                                       pkVals$vka(), pkVals$vFa(), pkVals$vCL_Ki()) })
}
shinyApp(ui, server)
