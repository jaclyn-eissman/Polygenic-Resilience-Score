#By Jaclyn Eissman, April 7, 2023

#Packages
library(ggplot2)
library(dplyr)

#Directory
dir = "/Users/jackieeissman/VUMC/Research - Hohman - Jaclyn Eissman/Dissertation/Defense/Figures/"

#Read in data
Data_bl = readRDS(paste0(dir,"Data/VMAP_Baseline_Data_Master.rds"))
PRS_df =  readRDS(paste0(dir,"Data/VMAP_PRS_Master.rds"))
Data = merge(Data_bl,PRS_df,by="ID")

#Plots with Amyloid Stratification
png(paste0(dir,"Eissman_etal_2023_LOAD_PRS.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data[!is.na(Data$Amyloid.pos.factor),],
       aes(x=LOAD_0.01_wAPOE, y=MEM, color=Amyloid.pos.factor)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + 
  xlab("Late-Onset AD PRS") + ylab("Baseline Memory Performance") + 
  scale_color_manual(values = c("purple","orange"), labels=c("Aβ-","Aβ+")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),
        legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + 
  theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()

png(paste0(dir,"Eissman_etal_2023_Resilience_PRS.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data[!is.na(Data$Amyloid.pos.factor),],
       aes(x=GLOBALRES_0.01_wAPOE, y=MEM, color=Amyloid.pos.factor)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + 
  xlab("Cognitive Resilience PRS") + ylab("Baseline Memory Performance") + 
  scale_color_manual(values = c("purple","orange"), labels=c("Aβ-","Aβ+")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),
        legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + 
  theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()

###Plots with Sex Stratification
Data2 = readRDS(paste0(dir,"Data/VMAP_Longitudinal_with_Pathology_and_PRS.RDS"))
Data2 = Data2 %>% filter(Age==Age_bl)
Data2$Sex_Amyl = NA
Data2$Sex_Amyl = ifelse(Data2$Sex==1 & Data2$Amyloid.pos.factor=="Yes","Male & Aβ+",
       ifelse(Data2$Sex==1 & Data2$Amyloid.pos.factor=="No","Male & Aβ-",
              ifelse(Data2$Sex==2 & Data2$Amyloid.pos.factor=="Yes","Female & Aβ+","Female & Aβ-")))

png(paste0(dir,"Eissman_etal_2023_Resilience_PRS_Sex_Amyl_Strata.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data2[!is.na(Data2$Sex_Amyl),], aes(x=SexAgnostic_All, y=MEM, color=Sex_Amyl, linetype=Sex_Amyl)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + 
  xlab("Cognitive Resilience PRS") + ylab("Baseline Memory Performance") + 
  scale_color_manual(values=c("deeppink1","deeppink4","deepskyblue2","deepskyblue4"),
                     labels=c("Female & Aβ-","Female & Aβ+","Male & Aβ-","Male & Aβ+")) + 
  scale_linetype_manual(values = c("dotted","solid","dotted","solid"),
                        labels=c("Female & Aβ-","Female & Aβ+","Male & Aβ-","Male & Aβ+")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),
        legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + 
  theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()



