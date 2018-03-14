#' The global urban water supply database.
#'
#' Details...
#'
#' @source Multiple sources (see `extdata` directory)
#' @format A data frame with columns:
#' \describe{
#' \item{city}{Name of the city}
#' \item{pop}{Population served (millions)}
#' \item{demand}{Average annual demand (million cubic meters)}
#' \item{storage}{Total effective reservoir storage (million cubic meters)}
#' \item{num_res}{Number of storage reservoirs (million cubic meters)}
#' \item{catch_area}{Catchment area upsteam of reservoirs (square kilometeres)}
#' \item{catch_type}{Catchment type: protected, unprotected, mixed}
#' \item{surf, ground, unconv}{Percentage of average annual supply delivered by surface, groundwater, and unconventional resources respectively}
#' \item{desal_max, treatment_max}{Maximum capacity (cubic meteres per day) for desalination and treatment facilities respectively}
#' \item{purif_main, purif_sec}{Main and secondary modes of purification by plant capacity}
#' \item{adv_treatment}{Logical: is there significant advanced treatment (e.g., activated carbon)}
#' \item{disinf_main}{Primary means of disinfection}
#' \item{fluoride}{Logical: is fluoride added to supply}
#' \item{leak_rate}{Catchment area upsteam of reservoirs (square kilometeres)}
#' \item{operator}{Name of the main operating company}
#' \item{ownership}{Public or private asset ownership}
#' \item{finance_model}{Primary mode of infrastructure finance}
#' }
#' @examples
#' gluwasp
#'
"gluwasp"
