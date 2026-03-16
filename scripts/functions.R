#FUNCTIONS ------------------------------------
#' Title
#'
#' @param ANNEE 
#'
#' @returns
#' @export
#'
#' @examples
decennie_a_partir_annee <- function(ANNEE) {
  return(ANNEE - ANNEE %%
           10)
}
## fonction de stat agregee ------------
#' Title
#'
#' @param a 
#' @param b 
#' @param ... 
#'
#' @returns
#' @export
#'
#' @examples
fonction_de_stat_agregee <- function(a, b = "moyenne", ...) {
  if (b == "moyenne") {
    x <- mean(a, na.rm = T, ...)
  } else if (b == "ecart-type" | b == "sd") {
    x <- sd(a, na.rm = T, ...)
  } else if (b == "variance") {
    x <- var(a, na.rm = T, ...)
  }
  return(x)
}

fonction_de_stat_agregee(rnorm(10))
fonction_de_stat_agregee(rnorm(10), "ecart-type")
fonction_de_stat_agregee(rnorm(10), "variance")

fonction_de_stat_agregee(df |> filter(SEXE == "Homme") |> pull(AGED))
fonction_de_stat_agregee(df |> filter(SEXE == "Femme") |> pull(AGED))

api_token <- "trotskitueleski$1917"