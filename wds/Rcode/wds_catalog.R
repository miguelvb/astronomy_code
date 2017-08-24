## WDS Catalog ##
## http://ad.usno.navy.mil/wds/Webtextfiles/wdsnewframe.html

file_ = "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_catalog_xlsx.csv"
data <- read.csv(file=file_, header =T,sep = ";")
str(data)
wds <- data
save(wds, file = "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_catalog.Rdata")
nrow(wds) # 141905

library(data.table)
wds <- as.data.table(wds)
Mag1Num <- as.numeric(as.character(wds$Mag1))
Mag2Num <- as.numeric(as.character(wds$Mag2))
wds$Mag1Num <- Mag1Num
wds$Mag2Num <- Mag2Num

save(wds, file = "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_catalog.Rdata")

binos <- wds[Sep.02 > 30][Mag1Num < 9][Mag2Num < 9]
binos[,.N] ## 1138

write.table(binos,file="~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_catalog_binos.csv", sep=";",row.names = F)

binos_wds <- as.character(binos$WDS)
length(binos_wds) # 1138 
writeLines(binos_wds, "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_binos_only_wds_name.txt")

head = "SkySafariObservingListVersion=3.0\n"
begin_obj = "SkyObject=BeginObject\n\tObjectID="
end_obj = "EndObject=SkyObject"
catalog = "CatalogNumber=WDS "
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

res = sapply(X = binos_wds, FUN = function(x) write_object(x))
res = c(head, res)
writeLines(res, "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_binos.skylist", sep="")

## EASY ONES : mag < 7
binos_easy_db <- wds[Sep.02 > 30][Mag1Num < 7][Mag2Num < 7]
binos_easy <- as.character(binos_easy_db$WDS)
length(binos_easy) # 145
res2 = sapply(X = binos_easy, FUN = function(x) write_object(x))
res2 = c(head, res2)
writeLines(res2, "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_binos_easy.skylist", sep="")

save(binos_easy_db, file = "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/wds_binos_easy.Rdata")

## BINOS BEAUTIFULS: 30 < sep < 70, mag < 8 
root <- "~/Documents/CREACIONES/Astronomia/Star_Gazing/sky_safary/wds_csv/"
file_name <- "wds_binos_beauty_challenge.skylist"
sep_min = 30
sep_max = 70
mag_max = 8
db_ <- wds[Sep.02 >= sep_min][Sep.02 <= sep_max][Mag1Num <= mag_max][Mag2Num <= mag_max]
db <- as.character(db_$WDS)
length(db) # 128
res_ = sapply(X = db, FUN = function(x) write_object(x))
res_ = c(head, res_)
writeLines(res_, paste0(root,file_name), sep="")
