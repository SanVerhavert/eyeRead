#'
#' @rdname convert
#' 
#' @name convert
#' 
#' @aliases size2deg
#' 
#' @title convert between units in eye-tracking
#' 
#' @description The functions convert  between visual degrees and centimeters, inches or pixels. 
#' 
#' @param x The value to convert. This can be a single number or a numerical 
#'   vector.
#' 
#' @param dist The distance to the screen. See Details for the measurement unit.
#' 
#' @details When converting from size to degrees (\code{size2deg}), the measurement 
#'   unit of the distance to the screen (\code{dist}) should be consistent with 
#'   the measurement unit of the size you are converting rf--from (\code{x}. 
#'   Namely if the size is in centimeters, then the distance should be to, and if 
#'   the size is in inches, then the distance should be in inches.
#' 
#' @return Returns a value or vector of values indicating the corresponding visual 
#'   degrees.
#' 
#' @export size2deg
#' 

size2deg <- function( x, dist )
{
  rad <- 2 * atan( x / (2 * dist ) )
  rad * 180 / pi
}

#' @describeIn convert
#' 
#' @aliases px2deg
#' 
#' @param res A vector indicating the screen resolution in the horizontal 
#'   direction (in pixels).
#' 
#' @param screenW The width of the screen in the horizontal direction. See 
#'   Details for the measurement unit.
#'   
#' @details When converting from pixels to degrees (\code{px2deg}), the measurement 
#'   unit of the distance to the screen (\code{dist}) should be consistent with 
#'   the measurement unit of the screen width (\code{screen width}). Namely if 
#'   the size is in centimeters, then the screen width should be to, and if the 
#'   size is in inches, then the screen width should be in inches.
#' 
#' @export px2deg
#' 

px2deg <- function( x, dist, res, screenW )
{
  x <- x / ( res / screenW )
  size2deg( x, dist )
}

#' @describeIn convert
#' 
#' @aliases deg2size
#' 
#' @export deg2size
#' 

deg2size <- function( x, dist )
{
  rad <- x * pi / 180
  tan( rad/2 ) * 2 * dist
}

#' @describeIn convert
#' 
#' @aliases deg2px
#' 
#' @export deg2px
#' 

deg2px <- function( x, dist, res, screenW )
{
  x <- deg2size( x, dist )
  x * ( res / screenW )
}