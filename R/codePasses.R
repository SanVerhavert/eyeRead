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
#' @param fix_size The size or accuity of the saccade. (default = 42; see Details)
#' @param fix_min [optional] minimal number of fixations for first pass. See Details.
#'   Default is 3.
#' @param plot logical. If \code{FALSE} (default) returns a vector? If 
#'   \code{TRUE} plots the results. See Details.
#' @param ... Aditional parameters accepted by the \code{plot} function.
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
#'   It is important to set the minimal distande between fixations (or the visual 
#'   accuity) via \code{fix_size}. This value is used to determine if two 
#'   fixations are on the same hight or width.When this value is to small it is 
#'   possible that some first-pass fixations are falsly categorized as rereading 
#'   fixations. Specifically \code{fix_size} determines what the minimal distance 
#'   between fixations should be in order for fixations to be considered in a 
#'   different  location or on a different hight of width. The default value is 
#'   specified in pixels. The value is the number of pixels equivalent to 2 
#'   visual degrees, taken a screen of 102DPI. (see \code{\link{deg.px.cm}} for 
#'   conversions). The value of 2 visual degrees is the average visual angle of 
#'   the fovea (Llewellyn-Thomas, 1968; Haber & Hershenson, 1973). It is 
#'   recommended to play around with the \code{fix_size} value for every 
#'   participant and inspect the results by setting \code{plot} to \code{TRUE}.
#'   
#'   When \code{plot} is set to \code{TRUE}, the function draws a plot where 
#'   fixation points are numbered according to their order in \code{data}. Each 
#'   fixation point is joined by a label indicating how they are coded. The plot 
#'   can be customized by providing graphical parameters to the '...' argument.
#'   
#'   By default this function considers the first three (3) fixations in any AOI 
#'   as first pass fixations. And it does this regardless of whether the fixations
#'   are consecutive or interupted by fixations in a different AOI. The minimal 
#'   number of fixations considered as first pass can be changed through 
#'   \code{fix_min}.
#' 
#' @return If \code{plot} is \code{FALSE} (Default) the function returns a 
#'   character vector of the same length as the number of rows in data. 
#'   Depending on the respecitve settings it contains the following values with 
#'   their respective meanings.  
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
#'   If \code{plot} is \code{TRUE}, the function draws a plot.
#'   
#' @references HABER, R. N., & HERSHENSON, M. The psychology of visual perception. 
#'   New York: Holt, Rinehart, and Winston, 1973.  
#'   LLEWELLYN-THOMAS, E. Movements of the eye. Scientific American, 1968, 219, 
#'   88-95. 
#' 
#' @export codePasses
#' 

codePasses <- function( data, AOI, rereading = FALSE, fpx = NULL, fpy = NULL,
                        origin = c( "topLeft", "bottomLeft", "center", "topRight",
                                    "bottomRight" ), fix_size = 42, fix_min = 3,
                        plot = FALSE, ... )
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
    data[ , fpy ] <- abs( data[ , fpy ] - max( data[ , fpy ] ) )
  }else if( origin == "center" )
  {
    data[ , fpx ] <- data[ , fpx ] - min( data[ , fpx ] )
    data[ , fpy ] <- abs( data[ , fpy ] - max( data[ , fpy ] ) )
  }else if( origin == "topRight" )
  {
    data[ , fpx ] <- abs( data[ , fpx ] - max( data[ , fpx ] ) )
  }else if( origin == "bottomRight" )
  {
    data[ , fpx ] <- abs( data[ , fpx ] - max( data[ , fpx ] ) )
    data[ , fpy ] <- abs( data[ , fpy ] - max( data[ , fpy ] ) )
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
    
    if( rereading )
    {
      AOIrow <- which( row.names( prevCoords ) == data[ 1, AOI ] )
      
      if( firstPass )
      {
        if( abs( prevCoords$y[ AOIrow ] - data[ i, fpy ] ) <= fix_size  )
        {
          if( abs( prevCoords$x[ AOIrow ] - data[ i, fpx ] ) <= fix_size )
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
  
  if( plot )
  {
    Args <- list( ... )
    
    if( any( names( Args ) == "type" ) )
      warning( "setting 'type' for 'plot' is ignored by this function" )
    
    Args[[ "type" ]] <- "c"
    
    if( all( names( Args ) != "x" ) )
      Args[[ "x" ]] <- data[ , fpx ]
    
    if( all( names( Args ) != "y" ) )
      Args[[ "y"]] <- data[ , fpy ]
    
    if( all( names( Args ) != "xlab" ) )
      Args[[ "xlab" ]] <- "x"
    
    if( all( names( Args ) != "ylab" ) )
      Args[[ "ylab" ]] <- "y"
    
    if( all( names( Args ) != "xlim" ) )
    {
      xlim <- range( data[ , fpx ] )
      xlim[1] <- xlim[1] - ( 2 * fix_size )
      xlim[2] <- xlim[2] + ( 2 * fix_size )
      rm( xlim )
    }
    
    if( all( names( Args ) != "ylim" ) )
    {
      ylim <- range( data[ , fpy ] )
      ylim[1] <- ylim[1] - ( 2 * fix_size )
      ylim[2] <- ylim[2] + ( 2 * fix_size )
      Args[[ "ylim" ]] <- rev( ylim )
      rm( ylim )
    }
    
    
    do.call( "plot", Args )
    
    text( data[ , fpx ], data[ , fpy ], labels = 1:nrow( data ) )
    text( data[ , fpx ], data[ , fpy ] - fix_size,
          labels = substr( x = passes, start = 1, stop  = 3 ) )
    
  }else return( passes )
  
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