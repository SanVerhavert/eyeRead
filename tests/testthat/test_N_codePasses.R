context( "codePasses" )

test_that( "specFile is found", {
  expect_true( T )
} )

test_that( "Function returns the correct error when data is no data frame", {
  expect_error(
    codePasses( data = codePasses_Data$regular$single_AOI_col$AOI, AOI = "AOI"),
    regexp = codePasses_results$no_data.frame_err
  )
} )

test_that( "Function returns the correct error when data is no data frame", {
  expect_error(
    codePasses( data = codePasses_Data$regular$single_AOI_col, AOI = "ABC"),
    regexp = codePasses_results$no_colname_err
  )
} )

test_that( "Function returns the correct errors when fix_min is to small", {
  expect_error(
    codePasses( data = codePasses_Data$regular$single_AOI_col, AOI = "AOI",
                fix_min = 0 ),
    regexp = codePasses_results$fix_min_err
  )
  expect_error(
    codePasses( data = codePasses_Data$regular$single_AOI_col, AOI = "AOI",
                fix_min = -1 ),
    regexp = codePasses_results$fix_min_err
  )
} )

test_that( "Function returns correct error if rereading is TRUE but fpx and/or fpy are not supplied", {
  expect_error(
    codePasses( data = codePasses_Data$regular$single_AOI_col,
                AOI = "AOI", rereading = T ),
    regexp = codePasses_results$missing_fpx_fpy_err
  )
} )

test_that( "Function correctly codes fixations as first pass and second pass with a single AOI column [column name]", {
  expect_equal(
    codePasses( data = codePasses_Data$regular$single_AOI_col, AOI = "AOI" ),
    codePasses_results$regular
  )
} )

test_that( "Function correctly codes fixations as first pass and second pass with a single AOI column [column number]", {
  expect_equal(
    codePasses( data = codePasses_Data$regular$single_AOI_col, AOI = 2 ),
    codePasses_results$regular
  )
} )
