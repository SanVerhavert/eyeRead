#'
#' @rdname compileAIO
#' 
#' @name compileAIO
#' 
#' @title compile AIO columns in one column
#' 
#' @description Compiles the information on AIO's in separate variables to one variable
#' 
#' @param data A data frame containing fixation information of an eye tracing 
#'   experiment. Each row indicates a fixation.
#' @param AOI A vector containing the name or number of the columns in \code{data} 
#'   containing if the repsective AOI was fixated (1) or not (0).
#' @param labels [optional] A vector containing the names of the AOI in the same 
#'   order as the columnnames or -numbers provided to \code{AOI}
#' 
#' @details This function can be used to convert a wide format eye tracking data 
#'   frame to a long format eye tracking data frame. It takes a data frame with 
#'   multiple binary variables that indicate whether an AIO is fixated on (=1) or 
#'   not (=0) and returns a vector with the AOI's that were fixated on.  
#'   
#'   NOTE: if the names of the AOI columns passed to the function are just numbers, 
#'   make shure to pass these as character for the function to work properly. The 
#'   function does not check for this case.
#' 
#' @return Vector that contains the AIO fixated on for each row in the data frame 
#'   whereby absence of a fixation on AIO is coded as 0.
#' 
#' @examples # First we generate some data
#'   some_Data <- data.frame( fixationIndex = 1:28,
#'                           AOI1 = c( 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#'                                     0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
#'                                     0, 0 ),
#'                           AOI2 = c( 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#'                                     0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0,
#'                                     0, 0 ),
#'                           AOI3 = c( 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0,
#'                                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
#'                                     0, 0 ),
#'                           AOI4 = c( 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
#'                                     1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
#'                                     0, 0 ),
#'                           AOI5 = c( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#'                                     0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#'                                     1, 0 ),
#'                           AOI6 = c( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#'                                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0,
#'                                     0, 1 ),
#'                           AOI7 = c( 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1,
#'                                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#'                                     0, 0 ) )
#'   
#'   # compileAOI accepts AOI's as names
#'   compileAIO( data = some_Data, AOI = c( "AOI1", "AOI2", "AOI3", "AOI4",
#'                                          "AOI5", "AOI6", "AOI7" ) )
#'   
#'   # and as column numbers
#'   compileAIO( data = some_Data, AOI = 2:8 )
#'   
#'   # and it returns 0 if some fixations are oitside the provided AOI's
#'   compileAIO( data = some_Data, AOI = c( "AOI1", "AOI2", "AOI4", "AOI5",
#'                                          "AOI6", "AOI7" ) )
#'   
#'   # it is also possible to suply different lables for the AOI's
#'   compileAIO( data = some_Data, AOI = c( "AOI1", "AOI2", "AOI3", "AOI4",
#'                                          "AOI5", "AOI6", "AOI7" ),
#'               labels = c( "1", "2", "3", "4", "5", "6", "7" ) )
#'   
#' @author Tine van Daal [aut], \email{tine.vandaal@@uantwerpen.be}
#'   San Verhavert [ctb], \email{san.verhavert@@uantwerpen.be}
#' 
#' @export compileAIO
#' 

compileAIO <- function( data, AOI, labels = NULL )
{
  if( !is.data.frame( data ) ) stop( "data should be a data frame" )
  
  if( is.character( AOI ) )
  {
    if( !all( AOI %in% colnames( data ) ) )
      stop( "not all values provided to AOI are column names for data" )
    
    data <- data[ , match( AOI, colnames( data ) ) ]
    AOI <- match( AOI, colnames( data ) )
  }
  
  if( !is.null( labels ) )
  { 
    if( length( AOI ) != length( labels ) ) stop( "AOI and labels lengts differ" )
    colnames( data )[ AOI ] <- labels
  }
  
  data <- data[ , AOI ]
  
  out <- character( nrow( data ) )
  
  for(i in 1:nrow( data ) )
  {
    out[i] <- ifelse( ( rowSums( data[ i, ] ) ) == 0,
                      yes = 0,
                      no = colnames( data[ i, ] )[ which( data[ i, ] == 1 ) ] )
  }
  
  return( out )
}
