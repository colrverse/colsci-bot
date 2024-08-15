library(rtoot)

for (i in 1:nrow(relevant_preprints)) {
  article_metadata <- relevant_preprints[i, ]
  post_toot(
    glue::glue(
      "New #ColSci #preprint: {article_metadata$title}\n🔗 https://doi.org/{article_metadata$doi}"
    )
  )
}
