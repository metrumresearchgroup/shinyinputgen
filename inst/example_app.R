library(shiny)
ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  numericInput("vka", "first order", 1.74, min = 0, max = 10),
  verbatimTextOutput("value")
)
server <- function(input, output) {
  vka <- reactive({
    in_range <- if (input$vka <= 10 && input$vka >= 0) {
      TRUE
    } else {
      FALSE
    }
    shinyFeedback::feedbackDanger("vka", !in_range, sprintf("Numeric value between %s-%s required", 0, 10))
    req(in_range)
    input$vka
  })
  output$value <- renderText({ vka() })
}
shinyApp(ui, server)
