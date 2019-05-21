#' Prepare data shifts
#' 
#' @param init.range vector of integers to generate 
#' all shifts combinations (default: \code{0:20})
#' @return list of named vectors with data shifts 
#' (carbs.shift, prot.shift, satu.shift, mono.shift, poly.shift)
#' @export
#' @author Konrad J. Debski
prepareShifts <- function(init.range = 0:20) {
  shifts <- list()
  n <- 1
  for (v in init.range) {
    for (w in init.range) {
      for (x in init.range) {
        for (y in init.range) {
          for (z in init.range) {
            shifts[[n]] <- c(carbs.shift = v, 
                             prot.shift  = w, 
                             satu.shift  = x, 
                             mono.shift  = y, 
                             poly.shift  = z)
            n <- n + 1
          }
        }
      }
    }
  }
  return(shifts)
}

