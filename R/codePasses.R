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
#' @param fpx The name or number of the column containing the X coordinate of the 
#'   fixation point. Required if \code{Rereading} is \code{TRUE}.
#' @param fpy The name or number of the column containing the Y coordinate of the 
#'   fixation point. Required if \code{Rereading} is \code{TRUE}.
#' @param origin Character string specifying where the origin of the fixation 
#'   coordinates \code{fpx} and \code{fpy} is located. The following values are
#'   possible: "topLeft" (default), "bottomLeft", "center", "topRight", "bottomRight".
#' @param fix_diff The resolution of the saccade. (default = 20; see Details)
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
#'   It is important to set the minimal distande between fixations via 
#'   \code{fix_diff}. When this value is to small it is possible that some 
#'   first-pass fixations are falsly categorized as rereading fixations. 
#'   Specifically \code{fix_diff} determines what the minimal difference between 
#'   fixations should be in order for fixations to be considered in a different 
#'   location. It is recommended to play around with this value for every 
#'   participant and inspect a subset of the results to see if categorization is 
#'   logical.
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
                        origin = c( "topLeft", "bottomLeft", "center", "topright",
                                    "bottomRight" ), fix_res = 20, fix_min = 3 )
{
  inputCheck_codePasses( data = data, AOI = AOI, rereading = rereading,
                         fpx = fpx, fpy = fpy, fix_min = fix_min )
  
  if( length( AOI ) > 1 )
  {
    data <- data.frame( data, AOI = compileAIO( data = data, AOI = AOI ) )
    AOI <- "AOI"
  }
  
  origin <- match.arg( origin )
  
  if( origin == "bottomLeft" )
  {
    fpy <- abs( fpy - max( fpy ) )
  }else if( origin == "center" )
  {
    fpx <- fpx - max( fpx )
    fpy <- fpy + min( abs( fpy ) )
  }else if( origin == "topRight" )
  {
    fpx <- abs( fpx - max( fpx ) )
  }else if( origin == "bottomRight" )
  {
    fpx <- fpx - max( fpx )
    fpy <- fpy - max( fpy )
  }
  
  passes <- character( nrow( data ) )
  
  lastPass <- rep( "FP", times = length( unique( data[ , AOI ] ) ) )
  names( lastPass ) <- unique( data[ , AOI ] )
  
  fixCount <- rep( 0, times = length( unique( data[ , AOI ] ) ) )
  names( fixCount ) <- unique( data[ , AOI ] )
  fixCount[ data[ 1, AOI ] ] <-  fixCount[ data[ 1, AOI ] ] + 1
  
  if( rereading )
  {
    passes[1] <-  paste0( "FPF_", data[ 1, AOI ] )
    
    firstPass <- F
    
    prevCoords <- data.frame( x = numeric( length( unique( data[ , AOI ] ) ) ),
                              y = numeric( length( unique( data[ , AOI ] ) ) ),
                              row.names = unique( data[ , AOI ] ) )
    
    AOIrow <- which( row.names( prevCoords ) == data[ 1, AOI ] )
    
    prevCoords$x[ AOIrow ] <- data[ 1, fpx ]
    prevCoords$y[ AOIrow ] <- data[ 1, fpy ]
    
    rm( AOIrow )
  } else  passes[1] <- paste0( "FP_", data[ 1, AOI ] )
  
  for( i in 2:length( passes ) )
  {
    if( lastPass[ data[ i, AOI ] ] == "SP" )
    {
      passes[i] <- paste0( "SP_", data[ i, AOI ] ) 
    } else if( data[ i, AOI ] == data[ i - 1, AOI ] )
    {
      passes[i] <- paste0( "FP_", data[ i, AOI ] )
      
      firstPass <- T
    } else if( fixCount[ data[ i, AOI ] ] < fix_min )
    {
      passes[i] <- paste0( "FP_", data[ i, AOI ] )
      
      firstPass <- T
    } else
    {
      passes[i] <- paste0( "SP_", data[ i, AOI ] )
      
      lastPass[ data[ i, AOI ] ] <- "SP"
    }
    
    if( rereading )#fix_res
    {
      AOIrow <- which( row.names( prevCoords ) == data[ 1, AOI ] )
      
      if( firstPass )
      {
        if( abs( prevCoords$y[ AOIrow ] - data[ i, fpy ] ) <= fix_res  )
        {
          if( abs( prevCoords$x[ AOIrow ] - data[ i, fpx ] ) <= fix_res )
          {
            passes[i] <- paste0( "FPF_", data[ i, AOI ] )
          }else if( prevCoords$x[ AOIrow] < data[ i, fpx ] )
          {
            passes[i] <- paste0( "FPF_", data[ i, AOI ] )
            prevCoords$x[ AOIrow ] <- data[ i, fpx ]
            
          } else if( prevCoords$x[ AOIrow ] > data[ i, fpx ] )
          {
            passes[i] <- paste0( "FPR_", data[ i, AOI ] )
          }
        }else if( prevCoords$y[ AOIrow ] < data[ i, fpy ] )
        {
          passes[i] <- paste0( "FPF_", data[ i, AOI ] )
          prevCoords$y[ AOIrow ] <- data[ i, fpy ]
          
          if( prevCoords$x[ AOIrow ] > data[ i, fpx ] )
          {
            prevCoords$x[ AOIrow ] <- data[ i, fpx ]
          }
        } else if( prevCoords$y[ AOIrow ] > data[ i, fpy ] )
        {
          passes[i] <- paste0( "FPR_", data[ i, AOI ] )
          
        }
        
        if( prevCoords$x[ AOIrow ] < data[ i, fpx ] )
        {
          prevCoords$x[ AOIrow ] <- data[ i, fpx ]
        }
        
        firstPass <- F
        rm( AOIrow )
      }
    }
    
    fixCount[ data[ i, AOI ] ] <- fixCount[ data[ i, AOI ] ] + 1
  }
  rm(i)
  
  passes
}

inputCheck_codePasses <- function(data, AOI, rereading, fpx, fpy, fix_min)
{
  if( !is.data.frame( data ) ) stop( "data should be a data frame" )
  
  if( length( AOI ) > 1 )
  {
    if( !is.numeric( AOI ) & !all( AOI %in% colnames( data ) ) )
    stop( "not all values provided to AOI are column names for data" )
  } else if( !is.numeric( AOI ) & !( AOI %in% colnames( data ) ) )
    stop( "the value provide to AOI is not a column name of data" )
  
  if( fix_min <= 0 ) stop( "Fix min should be bigger than 0" )
  # browser()
  if( rereading )
  {
    if( is.null( fpx ) )
    {
      stop( "If rereading is TRUE, then fpx should be provided" )
    } else if( is.null( fpy ) )
    {
      stop( "If rereading is TRUE, then fpy should be provided" )
    } else if ( is.character (fpx ) & !( fpx %in% colnames( data ) ) )
    {
       stop( "The value provided to fpx is not a column name of data" )
    } else if ( is.character (fpy ) & !( fpy %in% colnames( data ) ) )
    {
      stop( "The value provided to fpy is not a column name of data" )
    }
  }
}