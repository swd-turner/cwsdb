#' The global urban water supply database.
#'
#' Details...
#'
#' @source Multiple sources (see `extdata` directory)
#' @format A data frame with columns:
#' \describe{
#' \item{city}{Name of the city}
#' \item{country}{Name of the country}
#' \item{pop}{Population served by the supply system (millions)}
#' \item{access}{Share of popultion with access to piped water (percent)}
#' \item{demand_total}{Total average annual demand (million cubic meters)}
#' \item{demand_dmstc}{Total average annual demand of households only (million cubic meters)}
#' \item{storage}{Total effective reservoir storage (million cubic meters)}
#' \item{catch_type}{Catchment type: protected, unprotected, mixed}
#' \item{surface, ground, desal, recyc}{Percentage of average annual supply delivered by surface, groundwater, and unconventional resources respectively}
#' \item{treat_cap}{Capacity of treatment facilities (million cubic meteres per day)}
#' \item{treat_main, treat_sec}{Main and secondary modes of purification by plant capacity}
#' \item{adv_treatment}{Logical: is there significant advanced treatment (e.g., activated carbon)}
#' \item{disinf_main}{Primary means of disinfection}
#' \item{fluorid}{Logical: is there fluoridation of supply?}
#' \item{unit_cost}{Unit cost of water for rate payers (USD per m3 supplied)}
#' \item{leakage}{Catchment area upsteam of reservoirs (square kilometeres)}
#' \item{meter_pen}{Catchment area upsteam of reservoirs (square kilometeres)}
#' \item{business_model}{Business model of water supply}
#' \item{revenue_source}{Primary source of revenue}
#' \item{cost_rec}{Logical: do user payments cover costs of supply?}
#' \item{finance}{Primary mode of infrastructure finance}
#' }
#' @examples
#' gluwasp
#'
"gluwasp"

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1") utils::globalVariables(c("."))
