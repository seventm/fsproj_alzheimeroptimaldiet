#' Do model calculations
#' 
#' @param r single column data.frame "R"
#' @param range  two element vector 
#' @param shifts vector with carbs.shift (shift for carbohydrates), 
#' prot.shift (shift for protein), satu.shift (shift for saturated fat), 
#' mono.shift (shift for monosaturated fat), poly.shift (shift for polyunsaturated fat)
#' @param x data.frame. Whole data i.e. usda_nutrients
#' 
#' @return vector with rsq and shifts
#' @author Konrad J. Debski
doCalculations <- function(r, range, shifts, x) {
  data <- prepareData(x = x, 
                      r = r, 
                      range = range, 
                      shifts = shifts)
  
  model <- generateModel(data)
  rsq <- getModelRSq(model)
  
  c(rsq = rsq, shifts)
}

#' Make model calculations in paraller
#' 
#' @param x data.frame. Whole data i.e. usda_nutrients
#' @param period period id e.g. 1, 2, 3, 4
#' @param shifts list with 
#' @param cores number of cores to use for calculation
#' 
#' @return matrix with results
#' 
#' @author Konrad J. Debski
#' @importFrom snow makeCluster clusterExport clusterExport parLapply stopCluster
#' @export
makeCalculations <- function(x, period, shifts, cores = 6) {
  r <- subset(x, Period == period, select = R)
  range <- getRange4Period(x, period)

  # prepare cluster
  cl <- snow::makeCluster(cores)
  on.exit(snow::stopCluster(cl))

  # export variables
  for(obj.name in c("x", "r", "range"))
    snow::clusterExport(cl, obj.name, env = environment())

  # do calculations
  res <- snow::parLapply(cl, shifts, function(s) doCalculations(r, range, s, x))

  # create result matrix
  do.call(rbind, res)
}

#' Prepare model configuration matrix
#' 
#' @param model.conf list model configuration
#' @param params.matrix matrix with params
#' 
#' @return matrix with model configuration 
#' @author Konrad J. Debski
prepareModelConfMatrix <- function(model.conf, params.matrix) {
  model.conf <- unlist(model.conf)
  param.names <- colnames(params.matrix)
  stopifnot(all(param.names %in% names(model.conf)))
  m <- model.conf[param.names]
  
  matrix(nrow = nrow(params.matrix), ncol = ncol(params.matrix), data = m, byrow = TRUE)
}

#' Calculate params
#' 
#' @param params.matrix matrix with params to test (output from \code{fsParams::generateParams()}
#' @param model.conf list with model configuration (params)
#' @param range two element vector (default: \code{c(-0.1, 0)}
#' @param only.in.range logical. If \code{TRUE} returns only results in range
#' @param add.kcal logical. If \code{TRUE} kcal column is added.
#' @param kcal.params vector with kcal values for carbs (kcal for carbohydrates), 
#' prot (kcal for protein), satu (kcal for saturated fat),
#' mono (kcal for monosaturated fat), poly (kcal for polyunsaturated fat).
#' Ignored if \code{add.kcal = FALSE}.
#' (default: \code{c(carbs = 4, prot  = 4, satu  = 9, mono  = 9, poly  = 9)})
#' 
#' @return matrix with model, carbs, prot, satu, mono, poly, is_in_range and kcal 
#' (if \code{add.kcal = TRUE})
#' @export
calculateParams <- function(params.matrix, 
                            model.conf, 
                            range = c(-0.1, 0), 
                            only.in.range = FALSE,
                            add.kcal = TRUE,
                            kcal.params = c(carbs = 4,
                                            prot  = 4,
                                            satu  = 9,
                                            mono  = 9,
                                            poly  = 9)) {
  intercept <- model.conf[['intercept']]
  mcm <- prepareModelConfMatrix(model.conf, params.matrix)
  m <- params.matrix * mcm
  rs <- rowSums(m)
  model.result <- rs + intercept
  is.in.range <- model.result >= range[1] & model.result <= range[2]
  res <- cbind(model = model.result, params.matrix, is_in_range = is.in.range)
  
  if(only.in.range)
    res <- res[as.logical(res[, 'is_in_range']), ]
    
  if(add.kcal)
    res <- calculateKcalPerModel(res, kcal.params = kcal.params)
  return(res)
}

