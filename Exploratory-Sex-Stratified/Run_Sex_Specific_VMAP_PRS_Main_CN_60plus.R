#By Jaclyn Eissman, April 7, 2023

#Packages
library(stringr)
library(nlme)
library(openxlsx)
library(dplyr)
library(MuMIn)
ctrl = lmeControl(msMaxIter=2000, opt="optim") 

#Directory
Main_directory="/Users/jackieeissman/VUMC/Research - Hohman - Jaclyn Eissman/Sex_Specific_Risk_Prediction/"

#####################################################1st visit#####################################################
#Read in data
Data = readRDS(paste0(Main_directory,"Data/VMAP/VMAP_Longitudinal_with_Pathology_and_PRS.RDS"))
Data_Bl = Data %>% filter(Age==Age_bl) %>% filter(Dx_bl=="Normal")

###PRS built in both Sexes 
#Applied to everyone
Output_All = lm(MEM ~ Age_bl + as.factor(Sex) + SexAgnostic_All, data=Data_Bl, na.action=na.omit)
summary(Output_All)

#Applied to men
Data_Bl_men = Data_Bl %>% filter(Sex==1)
Output_Men = lm(MEM ~ Age_bl + SexAgnostic_Men, data=Data_Bl_men, na.action=na.omit)
summary(Output_Men)

#Applied to women
Data_Bl_women = Data_Bl %>% filter(Sex==2)
Output_Women = lm(MEM ~ Age_bl + SexAgnostic_Women, data=Data_Bl_women, na.action=na.omit)
summary(Output_Women)

###PRS built in men
#Applied to everyone
Output_All = lm(MEM ~ Age_bl + as.factor(Sex) + SexSpecific_Male_All, data=Data_Bl, na.action=na.omit)
summary(Output_All)

#Applied to men
Data_Bl_men = Data_Bl %>% filter(Sex==1)
Output_Men = lm(MEM ~ Age_bl + SexSpecific_Male_Men, data=Data_Bl_men, na.action=na.omit)
summary(Output_Men)

#Applied to women
Data_Bl_women = Data_Bl %>% filter(Sex==2)
Output_Women = lm(MEM ~ Age_bl + SexSpecific_Male_Women, data=Data_Bl_women, na.action=na.omit)
summary(Output_Women)

###PRS built in women
#Applied to everyone
Output_All = lm(MEM ~ Age_bl + as.factor(Sex) + SexSpecific_Female_All, data=Data_Bl, na.action=na.omit)
summary(Output_All)

#Applied to men
Data_Bl_men = Data_Bl %>% filter(Sex==1)
Output_Men = lm(MEM ~ Age_bl + SexSpecific_Female_Men, data=Data_Bl_men, na.action=na.omit)
summary(Output_Men)

#Applied to women
Data_Bl_women = Data_Bl %>% filter(Sex==2)
Output_Women = lm(MEM ~ Age_bl + SexSpecific_Female_Women, data=Data_Bl_women, na.action=na.omit)
summary(Output_Women)

#####################################################Decline#####################################################
#Read in data
Data = readRDS(paste0(Main_directory,"Data/VMAP/VMAP_Longitudinal_with_Pathology_and_PRS.RDS"))
Data = Data %>% filter(Dx_bl=="Normal")

###PRS built in both Sexes 
#Applied to everyone
Output_All = lme(MEM ~ Age_bl + as.factor(Sex) + SexAgnostic_All*interval_MEM, random=~1+interval_MEM|FID, data=Data, na.action=na.omit, control=ctrl)
summary(Output_All)

#Applied to men
Data_men = Data %>% filter(Sex==1)
Output_Men = lme(MEM ~ Age_bl + SexAgnostic_Men*interval_MEM, random=~1+interval_MEM|FID, data=Data_men, na.action=na.omit, control=ctrl)
summary(Output_Men)

#Applied to women
Data_women = Data %>% filter(Sex==2)
Output_Women = lme(MEM ~ Age_bl + SexAgnostic_Women*interval_MEM, random=~1+interval_MEM|FID, data=Data_women, na.action=na.omit, control=ctrl)
summary(Output_Women)

###PRS built in men
#Applied to everyone
Output_All = lme(MEM ~ Age_bl + as.factor(Sex) + SexSpecific_Male_All*interval_MEM, random=~1+interval_MEM|FID, data=Data, na.action=na.omit, control=ctrl)
summary(Output_All)

#Applied to men
Data_men = Data %>% filter(Sex==1)
Output_Men = lme(MEM ~ Age_bl + SexSpecific_Male_Men*interval_MEM, random=~1+interval_MEM|FID, data=Data_men, na.action=na.omit, control=ctrl)
summary(Output_Men)

#Applied to women
Data_women = Data %>% filter(Sex==2)
Output_Women = lme(MEM ~ Age_bl + SexSpecific_Male_Women*interval_MEM, random=~1+interval_MEM|FID, data=Data_women, na.action=na.omit, control=ctrl)
summary(Output_Women)

###PRS built in women
#Applied to everyone
Output_All = lme(MEM ~ Age_bl + as.factor(Sex) + SexSpecific_Female_All*interval_MEM, random=~1+interval_MEM|FID, data=Data, na.action=na.omit, control=ctrl)
summary(Output_All)

#Applied to men
Data_men = Data %>% filter(Sex==1)
Output_Men = lme(MEM ~ Age_bl + SexSpecific_Female_Men*interval_MEM, random=~1+interval_MEM|FID, data=Data_men, na.action=na.omit, control=ctrl)
summary(Output_Men)

#Applied to women
Data_women = Data %>% filter(Sex==2)
Output_Women = lme(MEM ~ Age_bl + SexSpecific_Female_Women*interval_MEM, random=~1+interval_MEM|FID, data=Data_women, na.action=na.omit, control=ctrl)
summary(Output_Women)




