#'
#' @rdname codePasses
#' 
#' @name codePasses
#' 
#' @title Codes the Fixations as First Pass and Second Pass
#' 
#' @description The Fixations are coded as first pass and second pass.
#' 
#' @param data A data frame containing fixation information of an eye tracing 
#'   experiment. Each row indicates a fixation.
#' @param AOI The name or number of the column in \code{data} containing the name
#'   of the area of interest (AOI) that was fixated. If \code{data} contains one 
#'   column per AOI, also a vector is accepted (see Details).
#' @param rereading Logical. Indicating if the first pass fixations should be 
#'   split accoring to forward and rereading (\code{TRUE}) or not 
#'   (\code{FALSE} [Default])
#' @param fpx The name of the column containing the X coordinate of the fixation 
#'   point. Required if \code{Rereading} is \code{TRUE}.
#' @param fpy The name of the column containing the Y coordinate of the fixation 
#'   point. Required if \code{Rereading} is \code{TRUE}.
#' @param origin Character string specifying where the origin of the fixation 
#'   coordinates \code{fpx} and \code{fpy} is located. The following values are
#'   possible: "topLeft" (default), "bottomLeft", "center", "topLeft", "topRight".
#' @param fix_min [optional] minimal number of fixations for first pass. See Details.
#'   Default is 3.
#' 
#' @details This function takes a data frame containing information of an eye 
#'   tracking reading exersise Each row indicates a fixation and the columns at 
#'   least indicate the AOI that was fixated or if a specific AOI was fixated or not. 
#'   Optionally it can indicate the X and Y coordinates of the fixation point.  
#'   The fixations in this dataset are then coded according to their pass status: 
#'   first pass and second pass.
#'   
#'   If \code{AOI} is a single value it indicates the name or the number of the 
#'   column with the name of the respective area of interest (AOI) that was fixated. 
#'   In this case, the AOI column consists of names or numbers identifying the AOI's. 
#'   If \code{AOI} is a vector it indicates the name or number of the AOI columns. 
#'   In this case the AOI columns indicate if the respective fixation was in the 
#'   corresponding AOI (1) or not (0).  
#'   NOTE: if the names of the AOI columns passed to the function are just numbers, 
#'   make shure to pass these as character for the function to work properly. The 
#'   function does not check for this case.
#'   
#'   First pass fixations are further devided into forward and rereading 
#'   fixations if \code{rereading} is set to \code{TRUE}. In this case the names 
#'   of the columns containing the x and y coordinates of the fixation point 
#'   should be suplied by \code{fpx} and \code{fpy} respectively. The unit of 
#'   these coordinates does not matter.
#'   
#'   By default this function considers the first three (3) fixations in any AOI 
#'   as first pass fixations. And it does this regardless of whether the fixations
#'   are consecutive or interupted by fixations in a different AOI. The minimal 
#'   number of fixations considered as first pass can be changed through 
#'   \code{fix_min}.
#' 
#' @return The function returns a character vector of the same length as the 
#'   number of rows in data. Depending on the respecitve settings it contains the 
#'   following values with their respective meanings.  
#'   
#'   * \code{rereading} is \code{FALSE}:
#'      + \code{FP_\#} First Pass
#'      + \code{SP_\#} Second Pass
#'   * \code{rereading} is \code{TRUE}
#'      + \code{FPF_\#} First Pass Forward
#'      + \code{FPR_\#} First Pass Rereading
#'      + \code{SP_\#} Second Pass
#'   
#'   Where \# stands for the name of the respecitve AOI.
#' 
#' @export codePasses
#' 

codePasses <- function( data, AOI, rereading = FALSE, fpx = NULL, fpy = NULL,
                        origin = c( "topLeft", "bottomLeft", "center", "topLeft",
                                    "topRight" ), fix_min = 3 )
{
  inputCheck_codePasses( data = data, AOI = AOI, rereading = rereading,
                         fpx = fpx, fpy = fpy, fix_min = fix_min )
  
  origin <- match.arg( origin )
  
  passes <- character( nrow( data ) )
  
  lastPass <- rep( "FP", times = length( unique( data[ , AOI ] ) ) )
  names( lastPass ) <- unique( data[ , AOI ] )
  
  fixCount <- rep( 0, times = length( unique( data[ , AOI ] ) ) )
  names( fixCount ) <- unique( data[ , AOI ] )
  fixCount[ data[ 1, AOI ] ] <-  fixCount[ data[ 1, AOI ] ] + 1
  
  passes[1] <- paste0( "FP_", data[ 1, AOI ] )
  
  for( i in 2:length( passes ) )
  {
    if( lastPass[ data[ i, AOI ] ] == "SP" )
    {
      passes[i] <- paste0( "SP_", data[ i, AOI ] ) 
    } else if( data[ i, AOI ] == data[ i - 1, AOI ] )
    {
      passes[i] <- paste0( "FP_", data[ i, AOI ] )
    } else if( fixCount[ data[ i, AOI ] ] < fix_min )
    {
      passes[i] <- paste0( "FP_", data[ i, AOI ] )
    } else
    {
      passes[i] <- paste0( "SP_", data[ i, AOI ] )
      
      lastPass[ data[ i, AOI ] ] <- "SP"
    }
    
    fixCount[ data[ i, AOI ] ] <- fixCount[ data[ i, AOI ] ] + 1
  }
  rm(i)
  
  passes
}

inputCheck_codePasses <- function(data, AOI, rereading, fpx, fpy, fix_min)
{
  if( !is.data.frame( data ) ) stop( "data should be a data frame" )
  
  if( !is.numeric( AOI ) & !all( AOI %in% colnames( data ) ) )
    stop( "not all values provided to AOI are column names for data" )
  
  if( fix_min <= 0 ) stop( "Fix min should be bigger than 0" )
  
  if( rereading & ( is.null( fpx ) | is.null( fpy ) ) )
    stop( "If rereading is TRUE, then fpx and fpy should both be provided" )
  
  if( is.array( AOI ) ) stop( "Not implemented yet!" )
  
}