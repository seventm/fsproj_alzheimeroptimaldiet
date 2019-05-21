#' Generate model for data
#' 
#' Model formula: \code{R~carbs+prot+satu+mono+poly}
#' 
#' @param data data frame for model with 'R', 'carbs', 'prot', 
#' 'satu', 'mono', 'poly' columns
#' 
#' @return gam model
#' @author Konrad J. Debski
#' @importFrom mgcv gam
generateModel <- function(data) {
  stopifnot(is.data.frame(data))
  stopifnot(all(c('R', 'carbs', 'prot', 'satu', 'mono', 'poly') %in% names(data)))
  
  mgcv::gam(R~carbs+prot+satu+mono+poly, data = data)
}

#' Get model R SQ
#' 
#' @param model gam model (output from gam function from mgcv package)
#' 
#' @return model R SQ
#' @author Konrad J. Debski
getModelRSq <- function(model) {
  summary(model)$r.sq
}


