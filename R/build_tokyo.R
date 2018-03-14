#' build_tokyo
#'
#' Build the Tokyo csw entry from raw data
#'
#' @details Builds the cws entry for Tokyo
#' @return A row of
#' @importFrom tibble tibble
#' @import dplyr
#' @author SWDT March 2018
#' @export

build_tokyo <- function() {

  # suppress readr column parsing messages
  options(readr.num_columns = 0)

  # get shell tibble and name city
  make_gluwasp_tb() %>%
    mutate(city = "Tokyo",
           country = "Japan") -> cws_tky

  # read reservoir data
  read_gluwasp_data("tokyo_storage.csv", "Tokyo") ->
    res_tky

  # compute total storage
  res_tky %>%
    select(effective_capacity) %>%
    sum() ->
    cws_tky[["storage"]]

  # compute number of reservoirs
  res_tky %>%
    nrow() ->
    cws_tky[["num_res"]]

  # return Tokyo entry
  cws_tky

}

