
codePasses_Data <- list(
  regular =
    list( single_AOI_col = 
            data.frame( fixationIndex = 1:28,
                        AOI = c( 1, 1, 2, 2, 3, 4, 7, 7, 7, 7, 3,
                                 3, 7, 4, 4, 4, 5, 2, 2, 4, 2, 1,
                                 1, 6, 6, 3, 5, 6 )
            ),
          multiple_AOI_col = 
            data.frame( fixationIndex = 1:28,
                        AOI = data.frame( 
                          AOI1 = c( 1, 1, 0, 0, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 1, 1, 0,
                                    0, 0, 0, 0 ),
                          AOI2 = c( 0, 0, 1, 1, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 1, 1, 0, 1, 0, 0, 0,
                                    0, 0, 0, 0 ),
                          AOI3 = c( 0, 0, 0, 0, 1, 0, 0, 0,
                                    0, 0, 1, 1, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 1, 0, 0 ),
                          AOI4 = c( 0, 0, 0, 0, 0, 1, 0, 0,
                                    0, 0, 0, 0, 0, 1, 1, 1,
                                    0, 0, 0, 1, 0, 0, 0, 0,
                                    0, 0, 0, 0 ),
                          AOI5 = c( 0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 0,
                                    1, 0, 0, 0, 0, 0, 0, 0,
                                    0, 0, 1, 0 ),
                          AOI6 = c( 0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 1,
                                    1, 0,  0, 1 ),
                          AOI7 = c( 0, 0, 0, 0, 0, 0, 1, 1,
                                    1, 1, 0, 0, 1, 0, 0, 0,
                                    0, 0, 0, 0, 0, 0, 0, 0,
                                    0, 0, 0, 0 )
                        )
            )
    ),
  rereading = "EMPTY"
)

codePasses_results <- list( fix_min_err = "Fix min should be bigger than 0",
                            missing_fpx_fpy_err =
                              paste0( "If rereading is TRUE, then fpx and fpy ",
                                      "should both be provided" ),
                            regular = c( "FP_1", "FP_1", "FP_2", "FP_2", "FP_3", "FP_4",
                                         "FP_7", "FP_7", "FP_7", "FP_7", "FP_3", "FP_3",
                                         "SP_7", "FP_4", "FP_4", "FP_4", "FP_5", "FP_2",
                                         "FP_2", "SP_4", "SP_2", "FP_1", "FP_1", "FP_6",
                                         "FP_6", "SP_3", "FP_5", "FP_6" ),
                            rereading = "EMPTY"
)