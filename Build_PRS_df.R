#By Jaclyn Eissman, July 20, 2022
#LOAD = late-onset Alzheimer's disease 
#GLOBALRES = cognitive resilience

#Packages
library(data.table)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/Resilience_PRS/"

#Read in LOAD PRS and organize -- with APOE
LOAD_1 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_LOAD_flip_PRS.Pval_1.profile"))
LOAD_1 <- LOAD_1[,c("FID","SCORE")]
LOAD_1$SCORE <- scale(LOAD_1$SCORE,scale=T,center=T)
names(LOAD_1) <- c("ID","LOAD_1_wAPOE")
LOAD_2 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_LOAD_flip_PRS.Pval_0.01.profile"))
LOAD_2 <- LOAD_2[,c("FID","SCORE")]
LOAD_2$SCORE <- scale(LOAD_2$SCORE,scale=T,center=T)
names(LOAD_2) <- c("ID","LOAD_0.01_wAPOE")
LOAD_3 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_LOAD_flip_PRS.Pval_0.00001.profile"))
LOAD_3 <- LOAD_3[,c("FID","SCORE")]
LOAD_3$SCORE <- scale(LOAD_3$SCORE,scale=T,center=T)
names(LOAD_3) <- c("ID","LOAD_0.00001_wAPOE")
LOAD_temp <- merge(LOAD_1,LOAD_2,by="ID")
LOAD_Final <- merge(LOAD_temp,LOAD_3,by="ID")
rm(LOAD_1)
rm(LOAD_2)
rm(LOAD_3)
rm(LOAD_temp)

#Read in LOAD PRS and organize -- no APOE
LOAD_1 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_LOAD_flip_noAPOE_PRS.Pval_1.profile"))
LOAD_1 <- LOAD_1[,c("FID","SCORE")]
LOAD_1$SCORE <- scale(LOAD_1$SCORE,scale=T,center=T)
names(LOAD_1) <- c("ID","LOAD_1_noAPOE")
LOAD_2 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_LOAD_flip_noAPOE_PRS.Pval_0.01.profile"))
LOAD_2 <- LOAD_2[,c("FID","SCORE")]
LOAD_2$SCORE <- scale(LOAD_2$SCORE,scale=T,center=T)
names(LOAD_2) <- c("ID","LOAD_0.01_noAPOE")
LOAD_3 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_LOAD_flip_noAPOE_PRS.Pval_0.00001.profile"))
LOAD_3 <- LOAD_3[,c("FID","SCORE")]
LOAD_3$SCORE <- scale(LOAD_3$SCORE,scale=T,center=T)
names(LOAD_3) <- c("ID","LOAD_0.00001_noAPOE")
LOAD_temp <- merge(LOAD_1,LOAD_2,by="ID")
LOAD <- merge(LOAD_temp,LOAD_3,by="ID")
LOAD_Final <- merge(LOAD_Final,LOAD)
rm(LOAD_1)
rm(LOAD_2)
rm(LOAD_3)
rm(LOAD)
rm(LOAD_temp)

#Read in GLOBALRES PRS and organize -- with APOE
GLOBALRES_1 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_GLOBALRES_flip_PRS.Pval_1.profile"))
GLOBALRES_1 <- GLOBALRES_1[,c("FID","SCORE")]
GLOBALRES_1$SCORE <- scale(GLOBALRES_1$SCORE,scale=T,center=T)
names(GLOBALRES_1) <- c("ID","GLOBALRES_1_wAPOE")
GLOBALRES_2 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_GLOBALRES_flip_PRS.Pval_0.01.profile"))
GLOBALRES_2 <- GLOBALRES_2[,c("FID","SCORE")]
GLOBALRES_2$SCORE <- scale(GLOBALRES_2$SCORE,scale=T,center=T)
names(GLOBALRES_2) <- c("ID","GLOBALRES_0.01_wAPOE")
GLOBALRES_3 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_GLOBALRES_flip_PRS.Pval_0.00001.profile"))
GLOBALRES_3 <- GLOBALRES_3[,c("FID","SCORE")]
GLOBALRES_3$SCORE <- scale(GLOBALRES_3$SCORE,scale=T,center=T)
names(GLOBALRES_3) <- c("ID","GLOBALRES_0.00001_wAPOE")
GLOBALRES_temp <- merge(GLOBALRES_1,GLOBALRES_2,by="ID")
GLOBALRES_Final <- merge(GLOBALRES_temp,GLOBALRES_3,by="ID")
rm(GLOBALRES_1)
rm(GLOBALRES_2)
rm(GLOBALRES_3)
rm(GLOBALRES_temp)

#Read in GLOBALRES PRS and organize -- no APOE
GLOBALRES_1 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_GLOBALRES_flip_noAPOE_PRS.Pval_1.profile"))
GLOBALRES_1 <- GLOBALRES_1[,c("FID","SCORE")]
GLOBALRES_1$SCORE <- scale(GLOBALRES_1$SCORE,scale=T,center=T)
names(GLOBALRES_1) <- c("ID","GLOBALRES_1_noAPOE")
GLOBALRES_2 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_GLOBALRES_flip_noAPOE_PRS.Pval_0.01.profile"))
GLOBALRES_2 <- GLOBALRES_2[,c("FID","SCORE")]
GLOBALRES_2$SCORE <- scale(GLOBALRES_2$SCORE,scale=T,center=T)
names(GLOBALRES_2) <- c("ID","GLOBALRES_0.01_noAPOE")
GLOBALRES_3 <- fread(paste0(dir,"Data/VMAP_NHW_imputed_final_GLOBALRES_flip_noAPOE_PRS.Pval_0.00001.profile"))
GLOBALRES_3 <- GLOBALRES_3[,c("FID","SCORE")]
GLOBALRES_3$SCORE <- scale(GLOBALRES_3$SCORE,scale=T,center=T)
names(GLOBALRES_3) <- c("ID","GLOBALRES_0.00001_noAPOE")
GLOBALRES_temp <- merge(GLOBALRES_1,GLOBALRES_2,by="ID")
GLOBALRES <- merge(GLOBALRES_temp,GLOBALRES_3,by="ID")
GLOBALRES_Final <- merge(GLOBALRES_Final,GLOBALRES)
rm(GLOBALRES_1)
rm(GLOBALRES_2)
rm(GLOBALRES_3)
rm(GLOBALRES_temp)
rm(GLOBALRES)

#Combine LOAD and GLOBALRES
PRS <- merge(LOAD_Final,GLOBALRES_Final,by="ID")

#Write out PRS file
saveRDS(PRS,paste0(dir,"Data/VMAP_PRS_Master.rds"))
