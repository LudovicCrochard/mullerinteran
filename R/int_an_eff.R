moyenne <- function(x, na_rm = FALSE) {
  ## Checks                         ----------
  if (missing(x)) { stop("Missing x.") }
  if (!is.vector(x)) { stop("x must be a numeric vector.") }
  if (!is.numeric(x)) { stop("x must be a numeric vector.") }
  if (length(x) < 2) { stop("x must be length > 1.") }
  if (!is.logical(na_rm)) { stop("na_rm must be TRUE or FALSE.") }
  ## Remove NAs (if required)       ----------
  if (na_rm) {
    x <- x %>% na.omit()
    if (length(x) < 2) { stop("x has < 2 non-NA values.") }
  } else {
    if (sum(is.na(x)) > 0) { stop("x contains NA values. Use na_rm = TRUE.") }
  }
  ## Compute mean                   ----------
  sum(x) / length(x)
}
