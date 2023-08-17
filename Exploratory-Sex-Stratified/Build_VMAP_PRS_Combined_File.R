###Packages
library(data.table)
library(dplyr)
library(Hmisc)
library(ggplot2)

###Directories
Main_directory="/Users/jackieeissman/VUMC/Research - Hohman - Jaclyn Eissman/Sex_Specific_Risk_Prediction/"

#Read in sex-agnostic PRS
SexAgnostic_All = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_imputed_final_SexAgnostic_flip_PRS.Pval_0.01.profile"))
SexAgnostic_All$SCORE = scale(SexAgnostic_All$SCORE,center=T,scale=T)
SexAgnostic_All = SexAgnostic_All[,c("FID","IID","SCORE")]
names(SexAgnostic_All)[3] = "SexAgnostic_All"

SexAgnostic_Men = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_Men_imputed_final_SexAgnostic_flip_PRS.Pval_0.01.profile"))
SexAgnostic_Men$SCORE = scale(SexAgnostic_Men$SCORE,center=T,scale=T)
SexAgnostic_Men = SexAgnostic_Men[,c("FID","IID","SCORE")]
names(SexAgnostic_Men)[3] = "SexAgnostic_Men"

SexAgnostic_Women = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_Women_imputed_final_SexAgnostic_flip_PRS.Pval_0.01.profile"))
SexAgnostic_Women$SCORE = scale(SexAgnostic_Women$SCORE,center=T,scale=T)
SexAgnostic_Women = SexAgnostic_Women[,c("FID","IID","SCORE")]
names(SexAgnostic_Women)[3] = "SexAgnostic_Women"

#Read in male PRS
SexSpecific_Male_All = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_imputed_final_SexSpecific_Men_flip_PRS.Pval_0.01.profile"))
SexSpecific_Male_All$SCORE = scale(SexSpecific_Male_All$SCORE,center=T,scale=T)
SexSpecific_Male_All = SexSpecific_Male_All[,c("FID","IID","SCORE")]
names(SexSpecific_Male_All)[3] = "SexSpecific_Male_All"

SexSpecific_Male_Men = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_Men_imputed_final_SexSpecific_Men_flip_PRS.Pval_0.01.profile"))
SexSpecific_Male_Men$SCORE = scale(SexSpecific_Male_Men$SCORE,center=T,scale=T)
SexSpecific_Male_Men = SexSpecific_Male_Men[,c("FID","IID","SCORE")]
names(SexSpecific_Male_Men)[3] = "SexSpecific_Male_Men"

SexSpecific_Male_Women = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_Women_imputed_final_SexSpecific_Men_flip_PRS.Pval_0.01.profile"))
SexSpecific_Male_Women$SCORE = scale(SexSpecific_Male_Women$SCORE,center=T,scale=T)
SexSpecific_Male_Women = SexSpecific_Male_Women[,c("FID","IID","SCORE")]
names(SexSpecific_Male_Women)[3] = "SexSpecific_Male_Women"

#Read in female PRS
SexSpecific_Female_All = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_imputed_final_SexSpecific_Women_flip_PRS.Pval_0.01.profile"))
SexSpecific_Female_All$SCORE = scale(SexSpecific_Female_All$SCORE,center=T,scale=T)
SexSpecific_Female_All = SexSpecific_Female_All[,c("FID","IID","SCORE")]
names(SexSpecific_Female_All)[3] = "SexSpecific_Female_All"

SexSpecific_Female_Men = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_Men_imputed_final_SexSpecific_Women_flip_PRS.Pval_0.01.profile"))
SexSpecific_Female_Men$SCORE = scale(SexSpecific_Female_Men$SCORE,center=T,scale=T)
SexSpecific_Female_Men = SexSpecific_Female_Men[,c("FID","IID","SCORE")]
names(SexSpecific_Female_Men)[3] = "SexSpecific_Female_Men"

SexSpecific_Female_Women = fread(paste0(Main_directory,"Data/VMAP/VMAP_NHW_Women_imputed_final_SexSpecific_Women_flip_PRS.Pval_0.01.profile"))
SexSpecific_Female_Women$SCORE = scale(SexSpecific_Female_Women$SCORE,center=T,scale=T)
SexSpecific_Female_Women = SexSpecific_Female_Women[,c("FID","IID","SCORE")]
names(SexSpecific_Female_Women)[3] = "SexSpecific_Female_Women"

#Combine
All_PRS = merge(SexAgnostic_All,SexAgnostic_Men,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexAgnostic_Women,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexSpecific_Male_All,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexSpecific_Male_Men,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexSpecific_Male_Women,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexSpecific_Female_All,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexSpecific_Female_Men,by=c("FID","IID"),all=T)
All_PRS = merge(All_PRS,SexSpecific_Female_Women,by=c("FID","IID"),all=T)

#Do some organizing
Data = readRDS(paste0(Main_directory,"Data/VMAP/VMAP_Longitudinal_Data_Master.rds"))
names(Data)[1] = "FID"
Data$IID = Data$FID
Data = merge(All_PRS,Data,by=c("FID","IID"))

#Get age group
Data = Data[order(Data$FID, desc(Data$Age)),]
Data$last = Lag(Data$FID) != Data$FID
Data$last[1] = T
Data_last = Data[Data$last==T,] 
Data_last$IID = Data_last$FID

Data_last$Age_Group[Data_last$Age<72] = "Young"
Data_last$Age_Group[Data_last$Age>=72] = "Old"
Data_last = Data_last[,c("FID","IID","Age","Age_Group")]
names(Data_last)[3] = "Age_last"
Data = merge(Data,Data_last,by=c("FID","IID"))

#Save
saveRDS(Data,paste0(Main_directory,"Data/VMAP/VMAP_Longitudinal_with_Pathology_and_PRS.RDS"))


