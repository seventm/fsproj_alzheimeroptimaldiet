#' Table of nutrients availability from USDA/Center for Nutrition Policy and Promotion
#'
#' @docType data
#'
#' @usage data(usda_nutrients)
#'
#' @format A data.frame object.
#'
#' @keywords datasets
#'
#' @references Food and Nutrion Service U.S. Department of Agriculture
#' (\href{https://www.fns.usda.gov/}{Food and Nutrion Service U.S. Department of Agriculture})
#'
#' @source \href{https://www.cnpp.usda.gov/tools/IFS/Query.htm}{Nutrient Content of the U.S. Food Supply}
#'
#' @examples
#' data(usda_nutrients)
"usda_nutrients"

#' Precalculated shifts for model
#'
#' @docType data
#' 
#' @usage data(shifts)
#'
#' @format A list of 4084101 data frames with columns carbs.shift, prot.shift, satu.shift, 
#' mono.shift, poly.shift
#' 
#' @source \code{shifts <- prepareShifts(0:20)}
#' @examples
#' data(shifts)
"shifts"

#' Params configuration used in paper
#' 
#' @docType data
#' 
#' @usage data(params_conf)
#' 
#' @format A list with ranges and steps for carbs, prot, satu, mono, poly
#' 
#' @examples
#' data(params_conf)
"params_conf"

#' Precalculated params
#' 
#' @docType data
#' 
#' @usage data(params)
#' 
#' @format matrix with carbs, prot, satu, mono, poly
#' 
#' @source \code{params <- generateParams(params_conf)}
#' 
#' @examples
#' data(params)
"params"

#' Model configuration for periods
#' 
#' @docType data
#' 
#' @usage data(model_configuration)
#' 
#' @format list of lists with model configurations for each period 
#' intercept, carbs, prot, satu, mono, poly
#' 
#' @examples
#' data(model_configuration)
"model_configuration"
