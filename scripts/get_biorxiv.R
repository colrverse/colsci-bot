get_biorxiv <- function() {

  today <- Sys.Date()

  req_today <- glue::glue("https://api.biorxiv.org/details/biorxiv/{today-1}/{today}")

  next_req <- function(resp, req) {
    msg <- httr2::resp_body_json(resp)$messages[[1]]
    new_cursor <- as.numeric(msg$cursor) + msg$count
    total_papers <- as.numeric(msg$total)
    httr2::signal_total_pages(total_papers)

    if (total_papers <= new_cursor + 1) {
      return(NULL)
    }

    httr2::request(req_today) |>
      httr2::req_url_path_append(new_cursor)
  }

  today_res <- httr2::request(req_today) |>
    httr2::req_url_path_append("0") |>
    httr2::req_throttle(15 / 60) |>
    httr2::req_perform_iterative(next_req = next_req)

  preprints <- today_res |>
    httr2::resps_data(function(resp) {
      httr2::resp_body_json(resp)$collection
    }) |>
    dplyr::bind_rows()

  preprints_v1 <- preprints[preprints$version == 1, ]

  yes_words <- readLines(here::here("yes.txt"))
  no_words  <- readLines(here::here("no.txt"))

  relevant_preprints <- preprints_v1 |>
    dplyr::filter(grepl(paste0("\\b", yes_words, "\\b", collapse = "|"), title, ignore.case = TRUE))

  if (length(no_words) > 0) {
    relevant_preprints <- relevant_preprints |>
      dplyr::mutate(rejected = grepl(paste0("\\b", no_words, "\\b", collapse = "|"), title, ignore.case = TRUE))
  }

  return(relevant_preprints)
}
