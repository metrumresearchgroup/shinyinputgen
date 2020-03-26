library(shiny)


pkUI <- function(id) {
  list(
    numericInput(NS(id, "vka"), "1st Order Oral Abs Rate", 1.74, min = 0, max = 10),
    numericInput(NS(id, "vFa"), "Fraction Absorbed", 1, min = 0, max = 1)
  )
}
# this will be official in shiny 1.5
moduleServer <- function(id, module) {
  callModule(module, id)
}
pkServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    vka <- reactive({
      in_range <- if (input$vka <= 10 && input$vka >= 0) {
        TRUE
      } else {
        FALSE
      }
      shinyFeedback::feedbackDanger(ns("vka"), !in_range, sprintf("Numeric value between %s-%s required", 0, 10))
      req(in_range)
      input$vka
    })
    vFa <- reactive({
      in_range <- if (input$vFa <= 1 && input$vFa >= 0) {
        TRUE
      } else {
        FALSE
      }
      shinyFeedback::feedbackDanger(ns("vFa"), !in_range, sprintf("Numeric value between %s-%s required", 0, 1))
      req(in_range)
      input$vFa
    })
    list(vka = vka, vFa = vFa)
  })
}

ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  pkUI("pk"),
  verbatimTextOutput("value")
)

server <- function(input, output) {
  pkVals <- pkServer("pk")
  output$value <- renderText({ sprintf("vka: %s, vFa: %s", pkVals$vka(), pkVals$vFa()) })
}
shinyApp(ui, server)
