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
#' @param fixTime The name or number of the column containing the time per fixation.
#' @param passes The name or number of the column containing the coded passes.
#' @param AOI The name or number of the column in \code{data} containing the name
#'   of the area of interest (AOI) that was fixated.
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
#'   You can provide the names of the AOI's to \code{AOI_label} and indicate if 
#'   rereading passes were coded in \code{rereading}. This enures that the output 
#'   contains all types of passes for each AOI, even if they did not occur. In 
#'   that case the value in the output will be 0.
#' 
#' @return A data frame with the following comumns  
#'  If the AOI column is provided to /code{passes}:  
#'   $AOI: containing the AOI names  
#'   $duration: containing the aggregated durations  
#'  
#'  If the passes column is provided to /code{passes} and there is no rereading:  
#'   $AOI: containing the AOI names  
#'   $FirstPass: containing the aggregated first pass durations  
#'   $SecondPass: containing the aggregated second pass durations  
#'   
#'  If the passes column is provided to /code{passes} and there is rereading:  
#'  $AOI: containing the AOI names  
#'   $FirstPassForward: containing the aggregated first pass forward durations  
#'   $FirstPassRereading: containing the aggregated first pass rereading durations  
#'   $SecondPass: containing the aggregated second pass durations  
#'   
#'   The result will be in the same unit as the duration input.
#'   
#'   If the data contains fixations that were outside the AOI, the first line of 
#'   the results will contain the total fixation duration outside the AOI's.
#' 
#' @examples # first generate some data
#'   some_Data_passes <- data.frame( fixationIndex = 1:28,
#'               AOI = c( "AOI1", "AOI1", "AOI2", "AOI2", "AOI3", "AOI4",
#'                        "AOI7", "AOI7", "AOI7", "AOI7", "AOI3", "AOI3",
#'                        "AOI7", "AOI4", "AOI4", "AOI4", "AOI5", "AOI2",
#'                        "AOI2", "AOI4", "AOI2", "AOI1", "AOI1", "AOI6",
#'                        "AOI6", "AOI3", "AOI5", "AOI6" ),
#'               fixTime = c( 373, 113, 123, 150, 120, 563, 320, 270, 147, 207,
#'                            320, 630, 320, 183, 207, 230, 210, 247, 447, 157,
#'                            323, 247, 223, 327, 200, 210, 163, 343 ),
#'               passes = c( "FP_AOI1", "FP_AOI1", "FP_AOI2", "FP_AOI2",
#'                           "FP_AOI3", "FP_AOI4", "FP_AOI7", "FP_AOI7",
#'                           "FP_AOI7", "FP_AOI7", "FP_AOI3", "FP_AOI3",
#'                           "SP_AOI7", "FP_AOI4", "FP_AOI4", "FP_AOI4",
#'                           "FP_AOI5", "FP_AOI2", "FP_AOI2", "SP_AOI4",
#'                           "SP_AOI2", "FP_AOI1", "FP_AOI1", "FP_AOI6",
#'                           "FP_AOI6", "SP_AOI3", "FP_AOI5", "FP_AOI6" ),
#'               stringsAsFactors = FALSE )
#'   some_Data_rereading <- data.frame( fixationIndex = 1:37,
#'                            AOI = c( "AOI1", "AOI1", "AOI1", "AOI1", "AOI1",
#'                                     "AOI1", "AOI1", "AOI1", "AOI1", "AOI1",
#'                                     "AOI1", "AOI1", "AOI1", "AOI1", "AOI1",
#'                                     "AOI1", "AOI2", "AOI2", "AOI1", "AOI2",
#'                                     "AOI2", "AOI2", "AOI2", "AOI2", "AOI2",
#'                                     "AOI2", "AOI2", "AOI2", "AOI2", "AOI2",
#'                                     "AOI2", "AOI2", "AOI2", "AOI2", "AOI3",
#'                                     "AOI3", "AOI3" ),
#'                            xcoord = c( 331, 380, 461, 537, 405, 581, 658,
#'                                        347, 391, 482, 563, 640, 363, 417,
#'                                        509, 347, 585, 675, 351, 328, 399,
#'                                        513, 590, 668, 337, 465, 629, 407,
#'                                        684, 470, 378, 526, 549, 370, 390,
#'                                        511, 434 ),
#'                            ycoord = c( 65, 66, 67, 64, 68, 65, 67, 93, 97,
#'                                        102, 98, 101, 94, 97, 99, 132, 221,
#'                                        222, 65, 258, 253, 256, 257, 256,
#'                                        301, 294, 294, 326, 330, 259, 299,
#'                                        297, 331, 367, 431, 432, 430 ),
#'                           fixTime = c( 373, 113, 123, 150, 120, 563, 320,
#'                                        270, 147, 207, 320, 630, 320, 183,
#'                                        207, 230, 210, 247, 447, 157, 323,
#'                                        247, 223, 327, 200, 210, 163, 343,
#'                                        233, 180, 173, 423, 267, 280, 397,
#'                                        167, 217 ),
#'                           passes = c( "FPF_AOI1", "FPF_AOI1", "FPF_AOI1",
#'                                       "FPF_AOI1", "FPR_AOI1", "FPF_AOI1",
#'                                       "FPF_AOI1", "FPF_AOI1", "FPF_AOI1",
#'                                       "FPF_AOI1", "FPF_AOI1", "FPF_AOI1",
#'                                       "FPR_AOI1", "FPR_AOI1", "FPR_AOI1",
#'                                       "FPF_AOI1", "FPF_AOI2", "FPF_AOI2",
#'                                       "SP_AOI1", "FPF_AOI2", "FPF_AOI2",
#'                                       "FPF_AOI2", "FPF_AOI2", "FPF_AOI2",
#'                                       "FPF_AOI2", "FPF_AOI2", "FPF_AOI2",
#'                                       "FPF_AOI2", "FPF_AOI2", "FPR_AOI2",
#'                                       "FPR_AOI2", "FPR_AOI2", "FPR_AOI2",
#'                                       "FPF_AOI2", "FPF_AOI3", "FPF_AOI3",
#'                                       "FPR_AOI3" ),
#'                          stringsAsFactors = FALSE )
#'                          
#'   ### This function compiles fixation durations
#'   ## for first and second passes
#'   # when the column name is given
#'   fixDur( data = some_Data_passes, fixTime = "fixTime", 
#'           passes = "passes" )
#'           
#'   # and when column number is given
#'   fixDur( data = some_Data_passes, fixTime = 3, passes = 4 )
#'   
#'   ## for forward and rereading passes
#'   fixDur( data = some_Data_rereading, fixTime = "fixTime",
#'           passes = "passes" )
#'           
#'   ## and for AOI's
#'   fixDur( data = some_Data_passes, fixTime = "fixTime", 
#'           passes = "AOI" )
#' 
#' @seealso \code{\link[stats]{aggregate}}, \code{\link[base]{by}}, 
#'   \code{\link[base]{tapply}}
#'
#' @importFrom stats aggregate
#' @importFrom tidyr spread
#' @importFrom tibble is_tibble
#' @export fixDur
#' 

fixDur <- function( data, fixTime, passes, AOI = NULL )
{
  if( is_tibble( data ) )
  {
    data <- as.data.frame( data )
  }
  
  fixDur.inputChecks( data = data, fixTime = fixTime, passes = passes, AOI = AOI )
  
  if( !is.null( AOI ) )
  {
    if( length( AOI ) == 1 ) AOI <- data[ , AOI ]
    
    if( is.factor( AOI ) )
    {
      AOI <- data.frame( AOI = levels( AOI ),
                       stringsAsFactors = F )
    } else AOI <- data.frame( AOI = unique( AOI ), stringsAsFactors = F )
  }
  
  if( any( data[ , passes] == 0 ) )
    data0 <- data[ data[ , passes] == 0, ]
  
  data <- data[ data[ , passes] != 0, ]
  
  if( !is.character( data[ , passes ] ) )
    data[ , passes ] <- as.character( data[ , passes ] ) #needed for odd behaviour of factors
  
  splitted_pass <- transpose( 
    as.data.frame( 
      strsplit( data[, passes], split = "_", fixed = T )
    )
  )
  
  if( ncol( splitted_pass ) < 2 )
  {
    result <- aggregate( list( duration = data[ , fixTime ] ),
                         by = list( AOI = splitted_pass[ , 1 ]),
                         FUN = sum )
    if( exists( "data0" ) )
    {
      result0 <- sum( data0[ , fixTime ] )
      result <- rbind( data.frame( AOI = 0, duration = result0 ),
                       result )
    }
  }else 
  {
    result <- aggregate( list( duration = data[ , fixTime ] ),
                       by = list( AOI = splitted_pass[ , 2 ],
                                  passes = splitted_pass[ , 1 ]),
                       FUN = sum )
    
    result <- spread( result, key = "passes", value = "duration", fill = 0, drop = F )
    
    if( exists( "data0" ) )
    {
      result0 <- sum( data0[ , fixTime ] )
      result <- rbind( data.frame( AOI = 0, FPF = result0, FPR = NA, SP = NA ),
                       result )
    }
    
    if( !is.null( AOI ) )
      result <- merge( result, AOI, by = "AOI", all = T )
    
    result[ is.na( result ) ] <- 0
    
    if( any( splitted_pass [ , 1 ] == "FPF" ) )
    {
      names( result )[ 2:4 ] <- c( "FirstPassForward", "FirstPassRereading", "SecondPass" )
    }else names( result )[ 2:3 ] <- c( "FirstPass", "SecondPass" )
  }
  
  return( as.data.frame( result ) )
  
}

fixDur.inputChecks <- function( data, fixTime, passes, AOI )
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
  
  if( !is.null( AOI ) & is.character( AOI ) & length( AOI ) == 1 )
  {
   if(  !( AOI %in% colnames( data ) ) )
        stop( "the value provide to AOI is not a column name of data" )
  }
  
}