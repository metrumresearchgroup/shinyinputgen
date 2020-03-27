test_that("ui inputs can be generated", {
  simple_numeric <- list(
    type = "numeric",
    label = "simple 1",
    min = 1,
    max = 10,
    value = 2.4
  )
  expect_equal(
    gen_ui_input(simple_numeric, "s1"),
    glue::glue('    numericInput(NS(id, "s1"), "simple 1", 2.4, min = 1, max = 10)')
  )
})
