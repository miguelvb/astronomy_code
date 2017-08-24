## EXOPLANETS LIST ##
## https://exoplanetarchive.ipac.caltech.edu/cgi-bin/TblView/nph-tblView?app=ExoTbls&config=planets

root_ = "~/tangible_git/astronomy_code/exoplanets/"
file_ = "exoplanets.csv"
fname = paste0(root_,file_)
data <- read.csv(file=fname, header =T, stringsAsFactors = F, skip = 406)
str(data)
nrow(data) # 3506 stars
names(data)

hd <- data$hd_name; hd[1:10]
mag <- data$st_optmag; mag[1:10]

library(data.table)
exop <- as.data.table(data)
exop <- exop[order(st_optmag)]

## make the names be or HD or HIP or the pl_hostname:
st_name <- ifelse(exop$hd_name != "", exop$hd_name, ifelse(exop$hip_name != "", exop$hip_name, exop$pl_hostname))
st_name[1:1000]
exop$st_name <- st_name

# intersting data:
names_ <- c("pl_hostname","pl_letter","pl_pnum","pl_orbper","pl_orbsmax","pl_orbeccen","pl_bmassj","pl_radj",
           "pl_dens","st_dist","st_optmag","st_teff","st_mass","st_rad","pl_name","pl_eqt","pl_massj","pl_rade",
           "pl_disc","hd_name","hip_name","st_sp","st_age", "st_name")

exop_full <- exop
exop <- exop_full[, names_, with = F]; exop[1:2]

naked_eye <- exop[st_optmag <= 6.0]; nrow(naked_eye) # 119
binos <- exop[st_optmag <= 9]; nrow(binos) # 522
easy_naked_eye <- exop[st_optmag <= 4.0]; nrow(easy_naked_eye) # 21

save(exop_full, file=paste0(root_, "exop_full.Rdata"))
save(exop, file=paste0(root_, "exop.Rdata"))

## SKY SAFARI LIST


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

# skysafari exoplanets binoculars: 522, and 507 taken by sky safari:
sk_list = sapply(X = binos$st_name, FUN = function(x) write_object(x))
cat(sk_list[1:3])
sk_list <- c(head, sk_list)
writeLines(sk_list, paste0(root_, "exop_binos.skylist"), sep="")

# naked eye (mag <=4): 21, taken by sky safari: 21
sk_list = sapply(X = easy_naked_eye$st_name, FUN = function(x) write_object(x))
cat(sk_list[1:3])
sk_list <- c(head, sk_list)
writeLines(sk_list, paste0(root_, "exop_naked_eye.skylist"), sep="")
