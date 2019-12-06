usethis::use_mit_license(name="Ludovic Crochard")
usethis::use_git()
usethis::use_roxygen_md()
usethis::use_package_doc()
devtools::document()
usethis::use_r("int_an_eff")
devtools::document()
usethis::use_package(package = "magrittr")
usethis::use_package(package = "stats")
compo_new<-read.csv("compo_new.csv")
usethis::use_data(compo_new, internal=FALSE)
usethis::use_r("compo_new")
devtools::document()
devtools::check()
usethis::use_readme_rmd()
rmarkdown::render("README.Rmd")
usethis::use_git_ignore("README.html")
devtools::document()
devtools::check()


# Create the reproductible example
set.seed(1053)
nrow    <- 4
ncol    <- 4
# random years
set.seed(1053)
Year1   <- round(runif(1, min = 2000, max = 2019))
Year2   <- Year1 +1
Year    <- c(Year1, Year2, Year1, Year2 )
# random text in latin
txt     <- stringi::stri_rand_lipsum(1, start_lipsum = TRUE)
# select the two first words for crop names
Culture <- c(stringr::word(txt, 2), stringr::word(txt, 3))
Culture <- c(Culture, Culture)

# hidden function from baseR to turn only the first layer of a word to uppercase
.simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}

# select 4 words in text for genus
Genus <- c(stringr::word(txt, 4:7))
# upper case first letter
Genus <- unlist(lapply(Genus, .simpleCap))
# remove eventual ponctuation
Genus <- gsub(pattern = ",", replacement = "", x = Genus)
# select 4 words in text for species
species <- c(stringr::word(txt, 8:11))
# remove eventual ponctuation
species <- gsub(pattern = ",", replacement = "", x = species)
# combine Genus and species
sp_names <- paste(Genus, species, sep = "_")

# Generate the matrix
set.seed(1053)
X <- matrix(data = runif(16, min = 0, max = 1), nrow = nrow, ncol = ncol)
X <- cbind(Year, Culture, X)

colnames(X) <- c("Year", "Culture", sp_names)

X <- as.data.frame(X)
X <- dplyr::mutate(X, 
                   Year           = as.numeric(as.character(Year)),
                   Sit_praesent   = as.numeric(as.character(Sit_praesent)),
                   Amet_phasellus = as.numeric(as.character(Amet_phasellus)),
                   Habitasse_ante = as.numeric(as.character(Habitasse_ante)),
                   Est_malesuada  = as.numeric(as.character(Est_malesuada))
                   )




usethis::use_data(X, internal = FALSE)

usethis::use_r("X")

# Treat compo_new as raw data
usethis::use_data_raw("compo_new")




