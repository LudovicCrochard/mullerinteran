#' Effet indirect pour des interactions inter annuelles
#' Cette fonction calcule d'interactions entre especes d'un meme niveau trophique via un une espece d'un
#' niveau trophique different.Les especes en interactions sont independantes. Exemple:calcule l'indice de Muller pour
#' des interactions inter annuelles entre cultures via le partage de pollinisateurs.
#'
#' @param ab_tab a dataframe
#' @param start_year numeric
#' @param start_crop a character
#' @param end_crop a character
#' @param pol a character
#'
#' @return La fonction renvoie la valeur de l'indice de Muller pour une especes de pollinisateur pour un couple de
#' culture et une annee.
#'
#' @export
#'
#' @examples
#' data(X)
#'
#' muller(
#'   ab_tab = X, start_year = 2015, start_crop = "Cereale",
#'   end_crop = "Colza", pol = "Abia_sericea"
#' )
#'


muller <- function(ab_tab, start_year = 2015, start_crop = "Cereale", end_crop = "Colza", pol = "Abia_sericea"){

  #ab_tab = compo_new; start_year = 2015; start_crop = "Cereale"; end_crop = "Colza"; pol = "Abia_sericea"

  ## Checks
  if (missing(ab_tab)) { stop("Missing ab_tab.") }
  if (missing(start_year)) { stop("Missing start_year") }
  if (missing(start_crop)) { stop("Missing start_crop") }
  if (missing(end_crop)) { stop("Missing end_crop") }
  if (missing(pol)) { stop("Missing pol") }
  if (!is.data.frame(ab_tab)) { stop("ab_tab must be a dataframe.") }

  ## Compute end year
  end_year <- start_year + 1

  ## Left nominator
  # Relab of pol in start_crop at start_year
  alpha_ij <- subset(ab_tab, Year == start_year)
  alpha_ij <- subset(alpha_ij, Culture == start_crop)
  alpha_ij <- alpha_ij[, colnames(alpha_ij) == pol]

  ## Right_nominator
  # Relab of pol in end_crop at end_year
  alpha_ip <- subset(ab_tab, Year == end_year)
  alpha_ip <- subset(alpha_ip, Culture == end_crop)
  alpha_ip <- alpha_ip[, colnames(alpha_ip) == pol]

  ## Compute the left denominator
  # Sum of the relab of one species on all the crops for one year
  pol_an       <- subset(ab_tab, Year == start_year )
  pol_an       <- pol_an[, colnames(pol_an) == pol]
  sum_alpha_il <- sum(pol_an)

  ## Compute the right denominator
  # Sum of all the relab of all the species in one crop
  cult_an      <- subset(ab_tab, Year == end_year)
  cult_an      <- subset(cult_an, Culture == end_crop)
  sp_cult_an   <- cult_an[grep(pattern = "_", x = colnames(cult_an))] # select the column with species relab only
  sum_alpha_pi <- sum(sp_cult_an)

  ## effect of the relab of pol on start_crop in start_year on relab of pol on end_crop in end_year
  d_ijp <- (alpha_ij/sum_alpha_il) * (alpha_ip/sum_alpha_pi)
  d_ijp
} #eo muller
