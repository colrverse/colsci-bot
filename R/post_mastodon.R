#' @export
post_mastodon <- function(papers_df) {

  for (i in seq_len(nrow(papers_df))) {
    article_metadata <- papers_df[i, ]
    rtoot::post_toot(
      glue::glue(
        "New #ColSci #preprint: {article_metadata$title}\n🔗 https://doi.org/{article_metadata$doi}"
      )
    )
  }

}