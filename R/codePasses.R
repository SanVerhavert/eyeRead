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
#' experiment. Each row indicates a fixation.
#' @param AOI The name or number of the column in \code{data} containing the name
#'   of the area of interest (AOI) that was fixated. If \code{data} contains one 
#'   column per AOI, also a vector is accepted (see Details).
#' @param rereading Logical. Indicating if the first pass fixations should be 
#'   split accoring to forward and rereading (\code{TRUE}) or not 
#'   (\code{FALSE} [Default])
#' @param fpx The name of the column containing the X coordinate of the fixation 
#'   point. Required if \code{Rereading}
#'   is \code{TRUE}.
#' @param fpy The name of the column containing the Y coordinate of the fixation 
#'   point. Required if \code{Rereading} 
#'   is \code{TRUE}.
#' 
#' @details This function takes a data frame containing information of an eye 
#'   tracking experiment. Each row indicated a fixation and the columns at least 
#'   indicate and AOI that was fixated or if a specific AOI was fixated or not. 
#'   Optionally it can indicate the X and Y coordinates of the fixation point.  
#'   The fixations in this dataset are then coded according to their pass status: 
#'   first pass and second pass.
#'   
#'   If \code{AOI} is a single value it indicates the name or the number of the 
#'   column with the name of the respective area of interest (AOI) that was fixated. 
#'   In this case, the AOI column consists of names or numbers identifying the AOI's. 
#'   If \code{AOI} is a vector it indicated the name or number of the AOI columns. 
#'   In this case the AOI columns indicate if the respective fixation was in the 
#'   corresponding AOI (1) or not (0).
#'   
#'   First pass fixations are further devided into forward and rereading 
#'   fixations if \code{rereading} is set to \code{TRUE}. In this case the names 
#'   of the columns containing the x and y coordinates of the fixation point 
#'   should be suplied by \code{fpx} and \code{fpy} respectively. The unit of 
#'   these coordinates does not matter.
#' 
#' @return The function returns a character vector of the same length as the 
#'   number of rows in data. Depending on the respecitve settings it contains the 
#'   following values with their respective meanings.  
#'   
#'   * \code{rereading} is \code{FALSE}:
#'      + \code{SP_\#} Fist Pass
#'      + \code{2P_\#} Second Pass
#'   * \code{repreding} is \code{TRUE}
#'      + \code{FPF_\#} First Pass Forward
#'      + \code{FPR_\#} First Pass Rereading
#'      + \code{SP_\#} Second Pass
#'   
#'   Where \# stands for the name of the respecitve AOI.
#' 
#' @export codePasses
#' 
