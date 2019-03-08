context( "codePasses" )

test_that( "specFile is found", {
  expect_true( T )
} )

test_that( "Function returns the correct error when data is no data frame", {
  expect_error(
    compileAIO( data = some_Data$multiple_AOI_col$AOI, AOI = "AOI"),
    regexp = some_errors$no_data.frame_err
  )
} )

test_that( "Function returns the correct error when AOI specifies a colname that is not in data", {
  expect_error(
    compileAIO( data = some_Data$multiple_AOI_col, AOI = "ABC"),
    regexp = some_results$no_colname_err
  )
} )

test_that( "Function returns the correct results, if AOI are names", {
  results <- compileAIO( data = some_Data$multiple_AOI_col,
                         AOI = c( "AOI1", "AOI2", "AOI3", "AOI4", "AOI5", "AOI6",
                                  "AOI7" ) )
  expect_true( is.vector( results ) )
  expect_length( object = results, n = nrow( some_Data$multiple_AOI_col ) )
  expect_equal( results, paste0( "AOI", some_Data$single_AOI_col$AOI ) )
} )

test_that( "Function returns the correct results, if AOI are numbers", {
  results <- compileAIO( data = some_Data$multiple_AOI_col,
                         AOI = 2:8 )
  expect_true( is.vector( results ) )
  expect_length( object = results, n = nrow( some_Data$multiple_AOI_col ) )
  expect_equal( results, paste0( "AOI", some_Data$single_AOI_col$AOI ) )
} )

test_that( "Function returns the correct results, if AOI are names and some fixations outside AOI", {
  results <- compileAIO( data = some_Data$multiple_AOI_col,
                         AOI = c( "AOI1", "AOI2", "AOI4", "AOI5", "AOI6",
                                  "AOI7" ) )
  expect_true( is.vector( results ) )
  expect_length( object = results, n = nrow( some_Data$multiple_AOI_col ) )
  expect_equal( results, some_results$compile_missing )
} )