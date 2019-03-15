context( "codePasses" )

test_that( "specFile is found", {
  expect_true( T )
} )

test_that( "Function returns the correct error when data is no data frame", {
  expect_error(
    codePasses( data = some_Data$single_AOI_col$AOI, AOI = "AOI"),
    regexp = some_errors$no_data.frame_err
  )
} )

test_that( "Function returns the correct error when AOI specifies a colname that is not in data [single AOI]", {
  expect_error(
    codePasses( data = some_Data$single_AOI_col, AOI = "ABC"),
    regexp = some_results$missing_colname_err$AOI$single
  )
} )

test_that( "Function returns the correct error when AOI specifies a colname that is not in data [multiple AOI]", {
  expect_error(
    codePasses( data = some_Data$single_AOI_col,
                AOI = c( "AOI1", "AOI2", "AOI3", "ABC", "AOI5", "AOI6", "AOI7" ) ),
    regexp = some_results$missing_colname_err$AOI$multiple
  )
} )

test_that( "Function returns the correct error when fpx specifies a colname that is not in data", {
  expect_error(
    codePasses( data = some_Data$rereading$topLeft,
                AOI = "AOI",
                rereading = T,
                fpx = "ABC",
                fpy = "ycoord" ),
    regexp = some_results$missing_colname_err$fpx
  )
} )

test_that( "Function returns the correct error when fpy specifies a colname that is not in data", {
  expect_error(
    codePasses( data = some_Data$rereading$topLeft,
                AOI = "AOI",
                rereading = T,
                fpx = "xcoord",
                fpy = "ABC" ),
    regexp = some_results$missing_colname_err$fpy
  )
} )

test_that( "Function returns the correct errors when fix_min is to small", {
  expect_error(
    codePasses( data = some_Data$single_AOI_col, AOI = "AOI",
                fix_min = 0 ),
    regexp = some_results$fix_min_err
  )
  expect_error(
    codePasses( data = some_Data$single_AOI_col, AOI = "AOI",
                fix_min = -1 ),
    regexp = some_results$fix_min_err
  )
} )

test_that( "Function returns correct error if rereading is TRUE but fpx is not supplied", {
  expect_error(
    codePasses( data = some_Data$single_AOI_col,
                AOI = "AOI", rereading = T ),
    regexp = some_results$missing_fpx_err
  )
} )

test_that( "Function returns correct error if rereading is TRUE but fpy is not supplied", {
  expect_error(
    codePasses( data = some_Data$rereading$topLeft,
                AOI = "AOI", rereading = T, fpx = "xcoord" ),
    regexp = some_results$missing_fpy_err
  )
} )

test_that( "Function correctly codes fixations as first pass and second pass with a single AOI column [column name]", {
  # browser()
  expect_equal(
    codePasses( data = some_Data$single_AOI_col, AOI = "AOI" ),
    some_results$regular
  )
} )

test_that( "Function correctly codes fixations as first pass and second pass with a single AOI column [column number]", {
  expect_equal(
    codePasses( data = some_Data$single_AOI_col, AOI = 2 ),
    some_results$regular
  )
} )

test_that( "Function correctly codes fixations as first pass and second pass with multiple AOI columns [column name]", {
  expect_equal(
    codePasses( data = some_Data$multiple_AOI_col,
                AOI = c( "AOI1", "AOI2", "AOI3", "AOI4", "AOI5", "AOI6", "AOI7" ) ),
    some_results$regular
  )
} )

test_that( "Function correctly codes fixations as first pass and second pass with multiple AOI column [column number]", {
  expect_equal(
    codePasses( data = some_Data$multiple_AOI_col, AOI = 2:8 ),
    some_results$regular
  )
} )

test_that( "Function correctly codes fixations as forward and rereading first pass; origin topLeft [by default; column name]", {
  expect_equal(
    codePasses( data = some_Data$rereading$topLeft,
                AOI = "AOI",
                rereading = T,
                fpx = "xcoord",
                fpy = "ycoord" ),
    some_results$rereading
  )
} )

test_that( "Function correctly codes fixations as forward and rereading first pass; origin topLeft [column name]", {
  expect_equal(
    codePasses( data = some_Data$rereading$topLeft,
                AOI = "AOI",
                rereading = T,
                fpx = "xcoord",
                fpy = "ycoord",
                origin = "topLeft" ),
    some_results$rereading
  )
} )

test_that( "Function correctly codes fixations as forward and rereading first pass; origin topLeft [column number]", {
  expect_equal(
    codePasses( data = some_Data$rereading$topLeft,
                AOI = "AOI",
                rereading = T,
                fpx = 3,
                fpy = 4,
                origin = "topLeft" ),
    some_results$rereading
  )
} )