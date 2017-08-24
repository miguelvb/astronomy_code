## AAVSO BINOCULAR VARIABLE STARS LIST ##
## https://www.aavso.org/aavso-binocular-program
## csv: https://www.aavso.org/vsx/index.php?view=results.get&campaign=2 

root_ = "~/tangible_git/astronomy_code/aavso/"
file_ = "variable_stars_aavso_binoculars.csv"
fname = paste0(root_,file_)
data <- read.csv(file=fname, header =T, stringsAsFactors = F)
str(data)
nrow(data) # 154 stars

# try to get min mag and max mag:
mag <- data$Mag
mag_minmax <- strsplit(x = mag, split = " - ")
mag_minmax[1:2]
mag_min <- sapply(mag_minmax, function(x){return(as.numeric(x[[1]]))})
mag_min[1:10]
split_and_number <- function(x){ 
    x <- strsplit(x, "V")[1]
    return(as.numeric(x))
  }
mag_max <- sapply(mag_minmax, function(x){return(split_and_number(x[[2]]))})
mag_max[1:10]
data$MagMin <- mag_min
data$MagMax <- mag_max
table(data$Period)
period <- as.numeric(data$Period)
data$PeriodNum <- period
str(data)
## 
library(data.table)
aavso_bino <- as.data.table(data)
save(aavso_bino, file = paste0(root_, "aavso_bino.Rdata"))

# once the db is structured we can try to make a list:

## SKYSAFARI LIST

head = "SkySafariObservingListVersion=3.0\n"
begin_obj = "SkyObject=BeginObject\n\tObjectID="
end_obj = "EndObject=SkyObject"
catalog = "CatalogNumber="
line = "\n"
tab = "\t"
star = "2,-1,-1"

write_object = function(obj) {
  type_ = star
  txt = paste(begin_obj, type_, line, sep="")
  txt = paste(txt, tab, catalog, obj, line, sep="")
  txt = paste(txt, end_obj, line, sep="")
  #print(txt)
  return(txt)
}

sk_list = sapply(X = aavso_bino$Name, FUN = function(x) write_object(x))
cat(sk_list[1:3])
sk_list <- c(head, sk_list)
writeLines(sk_list, paste0(root_, "aavso_variable_binoculars.skylist"), sep="")

# once parsed by sky_safary the list contains 135 stars (so 154 - 135 = 19 stars are missing...)
