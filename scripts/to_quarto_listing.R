to_quarto_listing <- function(papers_df) {

  old_papers_df <- yaml::read_yaml("preprints.yaml") |>
    purrr::list_transpose() |>
    tibble::as_tibble()

  papers_df |>
    dplyr::filter(!rejected) |>
    dplyr::transmute(
      title = title,
      categories = purrr::pmap(list(category, type), c),
      license = license,
      author = strsplit(authors, ";\\s*"),
      path = glue::glue("https://doi.org/{doi}"),
      description = abstract,
      license = sub("_", " ", license),
      license = toupper(gsub("_", "-", license))
    ) |>
    dplyr::bind_rows(old_papers_df) |>
    as.list() |>
    purrr::list_transpose() |>
    yaml::write_yaml("preprints.yaml")

}