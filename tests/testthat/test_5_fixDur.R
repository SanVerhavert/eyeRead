context( "fixDur" )

test_that( "specFile is found", {
  expect_true( T )
} )

test_that( "Function returns the correct error when data is no data frame", {
  expect_error( fixDur( data = some_Data$single_AOI_col$AOI,
                        fixTime = "fixTime",
                        passes = "passes" ),
                regexp = some_results$no_data.frame_err )
} )

test_that( "Function returns the correct error when fixTime is not in data", {
  expect_error( fixDur( data = some_Data$single_AOI_col,
                        fixTime = "ABC",
                        passes = "passes" ),
                regexp = some_results$missing_colname_err$fixTime )
} )

test_that( "Function returns the correct error when passes in not in data", {
  expect_error( fixDur( data = some_Data$single_AOI_col,
                        fixTime = "fixTime",
                        passes = "ABC" ),
                regexp = some_results$missing_colname_err$passes )
} )

test_that( "Function returns the correct error when fixTime contains more than one element", {
  expect_error( fixDur( data = some_Data$single_AOI_col,
                        fixTime = c( "fixTime", "A", "B"),
                        passes = "passes" ),
                regexp = some_results$missing_colname_err$fixTimeVec )
} )

test_that( "Function returns the correct error when passes contains more than one element", {
  expect_error( fixDur( data = some_Data$single_AOI_col,
                        fixTime = "fixTime",
                        passes = c( "passes", "A", "B" ) ),
                regexp = some_results$missing_colname_err$passesVec )
} )

test_that( "Function correctly calculates fixation duration for first pass and second pass [column name]", {
  expect_equal( fixDur( data = some_Data$single_AOI_col,
                        fixTime = "fixTime",
                        passes = "passes" ),
                some_results$fixDur$firstSecondPass
  )
} )

test_that( "Function correctly calculates fixation duration for first pass and second pass [fixTime column number]", {
  expect_equal( fixDur( data = some_Data$single_AOI_col,
                        fixTime = 3,
                        passes = "passes" ),
                some_results$fixDur$firstSecondPass
                )
} )

test_that( "Function correctly calculates fixation duration for first pass and second pass [passes column number]", {
  expect_equal( fixDur( data = some_Data$single_AOI_col,
                        fixTime = "fixTime",
                        passes = 4 ),
                some_results$fixDur$firstSecondPass
                               )
} )

test_that( "Function correctly calculates fixation duration for first pass forward, rereading and second pass", {
  expect_equal( fixDur( data = some_Data$rereading$topLeft,
                        fixTime = "fixTime",
                        passes = "passes" ),
                some_results$fixDur$rereading
  )
} )

test_that( "Function correctly calculates fixation duration for AOI's", {
  expect_equal( fixDur( data = some_Data$single_AOI_col,
                        fixTime = "fixTime",
                        passes = "AOI"),
                some_results$fixDur$AOI
  )
} )

test_that( "testing the workaround for tibble anomalies", {
  theIn <- tibble::as_tibble( some_Data$single_AOI_col )
  expect_equal( fixDur( data = theIn,
                        fixTime = "fixTime",
                        passes = "passes" ),
                some_results$fixDur$firstSecondPass
  )
} )
