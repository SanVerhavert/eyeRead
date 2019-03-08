
some_errors <- list( no_data.frame_err = "data should be a data frame",
                     fix_min_err = "Fix min should be bigger than 0",
                     missing_fpx_fpy_err =
                       paste0( "If rereading is TRUE, then fpx and fpy ",
                               "should both be provided" ),
                     missing_colname_err =
                       list( single = paste0( "the value provide to AOI is not a ",
                                              "column name of data"),
                             multiple = paste( "not all values provided to AOI ",
                                               "are column names for data" ) )
                       
)
some_results <- list( compile_missing = c( "AOI1", "AOI1", "AOI2", "AOI2", 0,
                                           "AOI4", "AOI7", "AOI7", "AOI7", "AOI7",
                                           0, 0, "AOI7", "AOI4", "AOI4", "AOI4",
                                           "AOI5", "AOI2", "AOI2", "AOI4", "AOI2",
                                           "AOI1", "AOI1", "AOI6", "AOI6", 0,
                                           "AOI5", "AOI6" ),
                      regular = c( "FP_AOI1", "FP_AOI1", "FP_AOI2", "FP_AOI2",
                                   "FP_AOI3", "FP_AOI4", "FP_AOI7", "FP_AOI7",
                                   "FP_AOI7", "FP_AOI7", "FP_AOI3", "FP_AOI3",
                                   "SP_AOI7", "FP_AOI4", "FP_AOI4", "FP_AOI4",
                                   "FP_AOI5", "FP_AOI2", "FP_AOI2", "SP_AOI4",
                                   "SP_AOI2", "FP_AOI1", "FP_AOI1", "FP_AOI6",
                                  "FP_AOI6", "SP_AOI3", "FP_AOI5", "FP_AOI6" ),
                     rereading = "EMPTY"
)