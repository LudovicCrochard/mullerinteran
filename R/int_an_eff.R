#' @title Moyenne d'un vecteur numerique
#' @description Cette fonction calcule la moyenne d'un vecteur numerique en
#'   omettant les valeurs manquantes si l'utilisateur le souhaite.
#'
#' @param x Un vecteur numerique sur lequel sera calculer la moyenne
#' @param na_rm Si TRUE supprime les NA (Defaut : FALSE)
#'
#' @return La fonction renvoie la moyenne du vecteur x.
#'
#' @import magrittr
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' moyenne(c(2, 4))
#'


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







#Community matrix for 2015 and 2016
dfcompo1516=compo.new[-c(13:24),]
##Decomposition of the Muller index for each crop pair 2 to 2 and pollinator
nom<- "poll_id" #Creation of the object "column name"
a=0 #a allows to go fram one column to another
X=(nrow(dfcompo1516)*nrow(dfcompo1516)-nrow(dfcompo1516)) #Calculation the number of columns for the table of results
res<- as.data.frame(matrix(ncol=(X+1),nrow=ncol(dfcompo1516), NA)) #Creation of the results table
colnames(res) <- c(nom) #assigning the name object to the table column

for(i in 1:nrow(dfcompo1516)){
  for(j in (i+1): (nrow(dfcompo1516-1))){ #-1 avoids the calculation of the effect of the last plant on itself
    a=a+2 #go to the next column for a calculation direction
    for(k in 1:ncol(dfcompo1516)){
      res[k,1]=names(dfcompo1516)[k] #allows to give pollinator's name to the line
      res[k,a]=(dfcompo1516[i,k]/sum(dfcompo1516[1:6,k])*(dfcompo1516[j,k]/sum(dfcompo1516[j,])))
      res[k,a+1]=(dfcompo1516[j,k]/sum(dfcompo1516[1:6,k])*(dfcompo1516[i,k]/sum(dfcompo1516[i,]))) #calculation the effect for each pollinator
    }
  }
}
for(i in 1:nrow(dfcompo1516)){
  for(j in (i+1): (nrow(dfcompo1516-1))){ #-1 avoids the calculation of the effect of the last plant on itself
    nom=c(nom,paste(rownames(dfcompo1516)[i],rownames(dfcompo1516)[j], sep="_"))
    nom=c(nom,paste(rownames(dfcompo1516)[j],rownames(dfcompo1516)[i], sep="_")) #evolution of the name of the columns that will take the name of the association of each plant
    colnames(res) <- c(nom)}}
#removal of biologically impossible effects
res1516=res[,c(2,3,4,5,6,8,9,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,47,48,50,52,54,56,58,60,63,64,65,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102)]
res1516_1=res1516
res1516_1=as.matrix(res1516_1)
res1516_1[is.nan(res1516_1)]<-0
res1516_1=as.data.frame(res1516_1)
res1516_1[,2:ncol(res1516_1)] <- apply(res1516_1[,2:ncol(res1516_1)], 2, as.numeric)
res1516_1[is.na(res1516_1)]<-0
res1516_1[196,]=apply(res1516_1, 2, sum)
