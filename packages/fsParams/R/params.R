#' Prepare params from ranges
#'
#' @param conf minimum two elements named list of named vectors with ranges specification i.e. 'step', 'min', 'max' 
#' 
#' @return named list with elements from ranges 
#' @author Konrad J. Debski
#' @export
prepareParamsFromRanges <- function(conf) {
	stopifnot(length(conf) > 1)
	is.valid <- vapply(conf, function(x) all(c('step', 'min', 'max') %in% names(x)), logical(1L))
	stopifnot(all(is.valid))
	
	col.names <- names(conf)
	has.duplicates <- min(anyDuplicated(col.names)) != 0
	has.missing.names <- is.null(names(conf)) || '' %in% names(conf)
	stopifnot(!has.missing.names)
	
	step <- vapply(conf, '[', numeric(1L), 'step')
	min.value <- vapply(conf, '[', numeric(1L), 'min')
	max.value <- vapply(conf, '[', numeric(1L), 'max')
	
	elements <- lapply(setNames(seq_along(col.names), col.names), 
						function(i) {
							seq(min.value[i], max.value[i], step[i])
						})
	return(elements)
}

#' Generate matrix with all combinations of params ranges
#'
#' @param conf minimum two elements named list of named vectors with ranges specification i.e. 'step', 'min', 'max' 
#' 
#' @return matrix with all combinations
#' @author Konrad J. Debski
#' @export
generateParams <- function(conf) {
	elements <- prepareParamsFromRanges(conf)
	res <- getMultiCombinations(elements)
	res <- do.call(cbind, res)
	return(res)
}

#' Get combination of two vectors a and b
#'
#' @param a vector.
#' @param b vector.
#'
#' @return list with replicated vector a and vector b
#' @author Konrad J. Debski
getCombinations <- function(a, b) {
	list(a = rep(a, length(b)), b = rep(b, each = length(a)))
}

#' Get combination for list of vectors
#'
#' @param x list of vectors
#'
#' @return list with replicated vectors
#' @author Konrad J. Debski
#' @export
getMultiCombinations <- function(x) {
	r <- list()
	nms <- names(x)
	
	for(i in seq_along(x)[-1]) {
		r[[i]] <- getCombinations(x[[i-1]], x[[i]])
		x[[i]] <- r[[i]][[2]]
	}
	
	y <- unlist(r, recursive = FALSE)
	# remove duplicated columns
	y[which(names(y) == 'a')[-1]] <- NULL
	
	max.len <- max(vapply(y, length, numeric(1L)))
	res <- lapply(y, function(z) rep_len(z, max.len))
	if(!is.null(nms))
		names(res) <- nms
		
	return(res)
}

