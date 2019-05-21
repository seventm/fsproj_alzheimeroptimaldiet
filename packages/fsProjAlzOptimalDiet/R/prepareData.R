#' Get data 
#' 
#' @param x data.frame with data
#' @param range vector length of 2 c(from, to)
#' @param shift vector length of 1
#' @param column integer column id
#' 
#' @return data.frame data subset
#' 
#' @author Konrad J. Debski
getData <- function(x, range, shift, column) {
  stopifnot(is.data.frame(x))
  stopifnot(is.vector(range) && length(range) == 2)
  stopifnot(is.vector(shift) && length(shift) == 1)
  stopifnot(is.integer(column) && column > 0 && column <= ncol(x))

  range <- range - shift
  rows <- seq(from = range[1], to = range[2])
  x[rows, column]
}

#' Get range for period
#' 
#' @param x data.frame
#' @param period vector length of one. Period id e.g. 1, 2, 3 or 4
#' 
#' @return range
#' @author Konrad J. Debski
getRange4Period <- function(x, period) {
  stopifnot(length(period) == 1)
  in.period <- which(x[, 'Period'] == period)
  range(in.period)
}

#' Prepare data for model
#' 
#' @param x data.frame with data "Carbohydrates", "Protein", "Saturated_Fat", 
#' "Monounsaturated_Fat", "Polyunsaturated_Fat"
#' @param r single column data.frame "R"
#' @param range two element vector
#' @param shifts vector with carbs.shift (shift for carbohydrates), 
#' prot.shift (shift for protein), satu.shift (shift for saturated fat), 
#' mono.shift (shift for monosaturated fat), poly.shift (shift for polyunsaturated fat)
#' 
#' @return data.frame with r, carbs, prot, satu, mono, poly
#' @author Konrad J. Debski
prepareData <- function(x, r, range, shifts) {
  stopifnot(all(c("Carbohydrates", "Protein", "Saturated_Fat", 
                  "Monounsaturated_Fat", "Polyunsaturated_Fat") %in% names(x)))
  stopifnot(is.data.frame(r) && ncol(r) == 1)
  stopifnot(is.data.frame(x))
  stopifnot(all(c('carbs.shift', 'prot.shift', 'satu.shift', 
                  'mono.shift', 'poly.shift') %in% names(shifts)))

  carbs.id <- which(names(x) == "Carbohydrates")
  prot.id  <- which(names(x) == "Protein")
  satu.id  <- which(names(x) == "Saturated_Fat")
  mono.id  <- which(names(x) == "Monounsaturated_Fat")
  poly.id  <- which(names(x) == "Polyunsaturated_Fat")

  carbs <- getData(x, range, shifts['carbs.shift'], carbs.id)
  prot  <- getData(x, range, shifts['prot.shift'],  prot.id)
  satu  <- getData(x, range, shifts['satu.shift'],  satu.id)
  mono  <- getData(x, range, shifts['mono.shift'],  mono.id)
  poly  <- getData(x, range, shifts['poly.shift'],  poly.id)
  
  data.frame(r,carbs, prot, satu, mono, poly)
}

