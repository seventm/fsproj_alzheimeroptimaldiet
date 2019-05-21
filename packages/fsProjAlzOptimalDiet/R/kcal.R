#' Calculate kcal per model
#' 
#' @param model.res model results i.e. \code{calculateParams()} function output
#' @param kcal.params vector with kcal values for carbs (kcal for carbohydrates), 
#' prot (kcal for protein), satu (kcal for saturated fat),
#' mono (kcal for monosaturated fat), poly (kcal for polyunsaturated fat)
#' (default: \code{c(carbs = 4, prot  = 4, satu  = 9, mono  = 9, poly  = 9)})
#' 
#' @return matrix with model results and additional column kcal
#' @export
#' @author Konrad J. Debski
calculateKcalPerModel <- function(model.res, 
                                  kcal.params = c(carbs = 4,
                                                  prot  = 4,
                                                  satu  = 9,
                                                  mono  = 9,
                                                  poly  = 9)) {
  kcal.names <- c("carbs", "prot", "satu", "mono", "poly")
  stopifnot(all(kcal.names %in% colnames(model.res)))
  stopifnot(all(kcal.names %in% names(kcal.params)))
  
  kcal.params <- kcal.params[kcal.names]
  
  m <- model.res[, names(kcal.params)]
  k <- matrix(nrow = nrow(m), ncol = ncol(m), data = kcal.params, byrow = TRUE)
  mk <- m*k
  kcal.res <- rowSums(mk)
  cbind(model.res, kcal = kcal.res)
}
