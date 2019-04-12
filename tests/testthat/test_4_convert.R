context( "convert" )

test_that( "specFile is found", {
  expect_true( T )
} )

test_that( "size is correctly converted to degrees cm and in, different distances and single values", {
  expect_equal( size2deg( x = 2, dist = 30 ), 3.818304866 )
  expect_equal( size2deg( x = 2, dist = 60 ), 1.909682508 )
  expect_equal( size2deg( x = 2, dist = 15 ), 7.628149669 )
  expect_equal( size2deg( x = 0.5, dist = 30 ), 0.954907555 )
  expect_equal( size2deg( x = 0.5, dist = 60 ), 0.477462066 )
  expect_equal( size2deg( x = 0.5, dist = 15 ), 1.909682508 )
  expect_equal( size2deg( x = 7, dist = 30 ), 13.30885009 )
  expect_equal( size2deg( x = 7, dist = 60 ), 6.676941008 )
  expect_equal( size2deg( x = 7, dist = 15 ), 26.26804461 )
  expect_equal( size2deg( x = 20, dist = 30 ), 36.86989765 )
  expect_equal( size2deg( x = 20, dist = 60 ), 18.92464442 )
  expect_equal( size2deg( x = 20, dist = 15 ), 67.38013505 )
} )

test_that( "size is correctly converted to degrees cm and in, different distances and multiple values", {
  expect_equal( size2deg( x = c( 2, 0.5, 7, 2, 20, 0.5 ),
                          dist = c( 30, 30, 60, 15, 30, 15 ) ),
                c( 3.818304866, 0.954907555, 6.676941008, 7.628149669, 36.86989765, 1.909682508 ) )
} )

test_that( "size is correctly converted to degrees; cm and in, single distances and multiple values", {
  expect_equal( size2deg( x = c( 2, 0.5, 7, 10, 16.5, 100 ),
                          dist = 30 ),
                c( 3.818304866, 0.954907555, 13.30885009, 18.92464442, 30.7525025, 118.0724869 ) )
} )
#################"
test_that( "pixels is correctly converted to degrees; different distances, different resolutions, different screen widths and single values", {
  expect_equal( px2deg( x = 2, dist = 30, res = 1024, screenW = 32 ), 0.119366164 )
  expect_equal( px2deg( x = 2, dist = 60, res = 1024, screenW = 32 ), 0.059683098 )
  expect_equal( px2deg( x = 2, dist = 15, res = 1024, screenW = 32 ), 0.238732069 )
  expect_equal( px2deg( x = 2, dist = 30, res = 300, screenW = 32 ), 0.407434937 )
  expect_equal( px2deg( x = 2, dist = 30, res = 2050, screenW = 32 ), 0.059624871 )
  expect_equal( px2deg( x = 2, dist = 30, res = 65, screenW = 32 ), 1.880308091 )
  expect_equal( px2deg( x = 2, dist = 30, res = 1024, screenW = 15 ), 0,055952905 )
  expect_equal( px2deg( x = 2, dist = 30, res = 1024, screenW = 60 ), 0.223811354 )
  expect_equal( px2deg( x = 2, dist = 30, res = 1024, screenW = 88 ), 0.328256172 )
  expect_equal( px2deg( x = 8, dist = 30, res = 1024, screenW = 32 ), 0.477462066 )
  expect_equal( px2deg( x = 8, dist = 60, res = 1024, screenW = 32 ), 0.238732069 )
  expect_equal( px2deg( x = 8, dist = 15, res = 1024, screenW = 32 ), 0.954907555 )
  expect_equal( px2deg( x = 8, dist = 30, res = 300, screenW = 32 ), 1.629636747 )
} )
