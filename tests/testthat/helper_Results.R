
some_errors <- list( no_data.frame_err = "data should be a data frame",
                     fix_min_err = "Fix min should be bigger than 0",
                     missing_fpx_fpy_err =
                       paste0( "If rereading is TRUE, then fpx and fpy ",
                               "should both be provided" ),
                     missing_colname_err =
                       paste( "not all values provided to AOI are column names ",
                              "for data" )
)
some_results <- list( regular = c( "FP_1", "FP_1", "FP_2", "FP_2", "FP_3", "FP_4",
                                  "FP_7", "FP_7", "FP_7", "FP_7", "FP_3", "FP_3",
                                  "SP_7", "FP_4", "FP_4", "FP_4", "FP_5", "FP_2",
                                  "FP_2", "SP_4", "SP_2", "FP_1", "FP_1", "FP_6",
                                  "FP_6", "SP_3", "FP_5", "FP_6" ),
                     rereading = "EMPTY"
)