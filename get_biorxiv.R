library(httr)
library(glue)

today <- Sys.Date()

req_today <- glue("https://api.biorxiv.org/details/biorxiv/{today-1}/{today}")

today_res <- content(GET(glue("{req_today}/0")))

today_preprints <- today_res$collection

# Manual pagination since httr doesn't support it yet
total_nb <- today_res$messages[[1]]$total

if (total_nb > 100) {
  for (cursor in seq(100, total_nb, by = 100)) {
    today_res <- content(GET(glue("{req_today}/{cursor}")))
    
    today_preprints <- c(today_preprints, today_res$collection)
  }
}

preprints <- do.call(rbind.data.frame, today_preprints)
preprints_v1 <- preprints[preprints$version == 1, ]

yes_words <- readLines("yes.txt")
no_words  <- readLines("no.txt")

library(dplyr)
relevant_preprints <- preprints_v1 %>%
  filter(grepl(paste0("\\b", yes_words, "\\b", collapse = "|"), title, ignore.case = TRUE))

if (length(no_words) > 0) {
  relevant_preprints <- relevant_preprints %>%
    filter(!grepl(paste0("\\b", no_words, "\\b", collapse = "|"), title, ignore.case = TRUE))
}
