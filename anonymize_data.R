# This script anonymizes the data 


library(osfr)
osfr::osf_auth()

if(!dir.exists("data")){
  dir.create("data")
}
filelist <- osf_retrieve_file("86qvh") %>% osf_download(path = "data", conflicts = "overwrite")


fn <- filelist[1,]$local_path

raw <- haven::read_sav(fn, encoding = "UTF-8")

anonymized <- raw %>% select(-ip_address, -email_address, -first_name, -last_name, -custom_1) 

haven::write_sav(anonymized, "data/anonymized.sav")
