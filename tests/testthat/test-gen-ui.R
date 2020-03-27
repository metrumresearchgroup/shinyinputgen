test_that("ui inputs can be generated", {
  simple_numeric <- list(
    type = "numeric",
    label = "simple 1",
    min = 1,
    max = 10,
    value = 2.4
  )
expected_server <- glue::glue("
    s1 <- reactive({
      in_range <- if (input$s1 <= 10 && input$s1 >= 1) TRUE else FALSE
      shinyFeedback::feedbackDanger(ns('s1'), !in_range,
      sprintf('Numeric value between %s-%s required', 1, 10))
      req(in_range)
      input$s1
    })
",
                              # set open/close to something random so doesn't replace {}
.open = "<<<", .close = ">>>")
  expect_equal(
    gen_ui_input(simple_numeric, "s1"),
    glue::glue('    numericInput(NS(id, "s1"), "simple 1", 2.4, min = 1, max = 10)')
  )
  expect_equal(
    gen_server_reactive(simple_numeric, "s1"),
    expected_server
  )
})
