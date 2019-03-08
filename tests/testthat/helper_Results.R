
some_errors <- list( no_data.frame_err = "data should be a data frame",
                     fix_min_err = "Fix min should be bigger than 0",
                     missing_fpx_fpy_err =
                       paste0( "If rereading is TRUE, then fpx and fpy ",
                               "should both be provided" ),
                     missing_colname_err =
                       paste( "not all values provided to AOI are column names ",
                              "for data" )
)
some_results <- list( compile_missing = c( "AOI1", "AOI1", "AOI2", "AOI2", 0,
                                           "AOI4", "AOI7", "AOI7", "AOI7", "AOI7",
                                           0, 0, "AOI7", "AOI4", "AOI4", "AOI4",
                                           "AOI5", "AOI2", "AOI2", "AOI4", "AOI2",
                                           "AOI1", "AOI1", "AOI6", "AOI6", 0,
                                           "AOI5", "AOI6" ),
                      regular = c( "FP_1", "FP_1", "FP_2", "FP_2", "FP_3", "FP_4",
                                  "FP_7", "FP_7", "FP_7", "FP_7", "FP_3", "FP_3",
                                  "SP_7", "FP_4", "FP_4", "FP_4", "FP_5", "FP_2",
                                  "FP_2", "SP_4", "SP_2", "FP_1", "FP_1", "FP_6",
                                  "FP_6", "SP_3", "FP_5", "FP_6" ),
                     rereading = "EMPTY"
)