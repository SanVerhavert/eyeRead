#'
#' @rdname fixDur
#' 
#' @name fixDur
#' 
#' @title Fixation Duration
#' 
#' @description Calculates the fixation durations for the first and second passes
#' 
#' @param data A data frame containing fixation information of an eye tracing 
#'   experiment and the coded passes. Each row indicates a fixation.
#'   
#' @param fixTime The name or number of the column containing the time per fixation.
#' 
#' @param passes The name or number of the column containing the coded passes.
#' 
#' @details This function is a wrapper for  \code{\link[stats]{aggregate}} 
#'   
#'   The function will only return the fixation duration of the values in the 
#'   \code{passes} column. The passes column is the vector returned by the 
#'   \code{link{codePasses}} function. It is also possible to provide the column 
#'   name of the column containing the AOI's if you require the fixation durations 
#'   for the AOI's only.
#'   The column of which the name or number is passed to \code{passes},will be 
#'   converted to a factor if it is not yet the case.
#' 
#' @return A vector containing the agregated fixation duration for the passes or 
#'   AOI's, dependent upon what is provided to \code{passes}. The result will be 
#'   in the same unit as the duration input.
#' 
#' @seealso \code{\link[stats]{aggregate}}, \code{\link[base]{by}}, 
#'   \code{\link[base]{tapply}}
#'
#' @importFrom stats aggregate
#' @export fixDur
#' 

fixDur <- function( data, fixTime, passes )
{
  fixDur.inputChecks( data = data, fixTime, passes = passes )
  
  aggregate( list( duration = data[ , fixTime ] ),
             by = list( passes = data[ , passes ] ),
             FUN = sum )
}

fixDur.inputChecks <- function( data, fixTime, passes )
{
  if( !is.data.frame( data ) ) stop( "data should be a data frame" )
  
  if( length( fixTime ) > 1 ) stop( paste0("fixTime should be a single number or ",
                                          "character, indicating the fixation time ",
                                          "column" ) )
  
  if( is.character( fixTime ) & !( fixTime %in% colnames( data ) ) )
    stop( "fixTime is not a column of data" )
  
  if( length( passes ) > 1 ) stop( paste0("passes should be a single number or ",
                                          "character, indicating the coded passes ",
                                          "column" ) )
  
  if( is.character( passes ) & !( passes %in% colnames( data ) ) )
    stop( "passes is not a column of data" )
}