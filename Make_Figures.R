#By Jaclyn Eissman, October 3, 2022

#Packages
library(ggplot2)
library(dplyr)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/Resilience_PRS/"

#Read in data
Data_bl <- readRDS(paste0(dir,"Data/VMAP_Baseline_Data_Master.rds"))
PRS_df <- readRDS(paste0(dir,"Data/VMAP_PRS_Master.rds"))
Data <- merge(Data_bl,PRS_df,by="ID")

#Plot LOAD PRS Main Effects -- Baseline
png(paste0(dir,"Figures/LOAD_PRS_Main_Effects_Baseline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data, aes(x=LOAD_0.01_wAPOE, y=MEM)) + 
  geom_point() + geom_smooth(method="lm",color="grey10") + 
  theme_bw() + xlab("Alzheimer's Disease PRS") + ylab("Baseline Memory") + 
  theme(legend.position="top", axis.text=element_text(size=12), axis.title=element_text(size=16)) +
  theme(axis.title.x=element_text(colour="black",size=20,face="bold")) +
  theme(axis.title.y=element_text(colour="black",size=20,face="bold"))
dev.off()

#Plot Resilience PRS Main Effects -- Baseline
png(paste0(dir,"Figures/GLOBALRES_PRS_Main_Effects_Baseline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data, aes(x=GLOBALRES_0.01_wAPOE, y=MEM)) + 
  geom_point() + geom_smooth(method="lm",color="grey10") + 
  theme_bw() + xlab("Cognitive Resilience PRS") + ylab("Baseline Memory") + 
  theme(legend.position="top", axis.text=element_text(size=12), axis.title=element_text(size=16)) +
  theme(axis.title.x=element_text(colour="black",size=20,face="bold")) +
  theme(axis.title.y=element_text(colour="black",size=20,face="bold"))
dev.off()

#Plot LOAD PRS Main Effects -- Decline
png(paste0(dir,"Figures/LOAD_PRS_Main_Effects_Decline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data, aes(x=LOAD_0.01_wAPOE, y=memslopes)) + 
  geom_point() + geom_smooth(method="lm",color="grey10") + 
  theme_bw() + xlab("Alzheimer's Disease PRS") + ylab("Annual Memory Decline") + 
  theme(legend.position="top", axis.text=element_text(size=12), axis.title=element_text(size=16)) +
  theme(axis.title.x=element_text(colour="black",size=20,face="bold")) +
  theme(axis.title.y=element_text(colour="black",size=20,face="bold"))
dev.off()

#Plot Resilience PRS Main Effects -- Decline
png(paste0(dir,"Figures/GLOBALRES_PRS_Main_Effects_Decline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data, aes(x=GLOBALRES_0.01_wAPOE, y=memslopes)) + 
  geom_point() + geom_smooth(method="lm",color="grey10") + 
  theme_bw() + xlab("Cognitive Resilience PRS") + ylab("Annual Memory Decline") + 
  theme(legend.position="top", axis.text=element_text(size=12), axis.title=element_text(size=16)) +
  theme(axis.title.x=element_text(colour="black",size=20,face="bold")) +
  theme(axis.title.y=element_text(colour="black",size=20,face="bold"))
dev.off()

#Plot LOAD PRS Stratified -- Baseline
png(paste0(dir,"Figures/LOAD_PRS_Amyloid_Stratified_Baseline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data[!is.na(Data$Amyloid.pos.factor),], aes(x=LOAD_0.01_wAPOE, y=MEM, 
                                                        color=Amyloid.pos.factor, linetype=Amyloid.pos.factor)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + xlab("Alzheimer's Disease PRS") + ylab("Baseline Memory") + 
  scale_color_manual(values = c("grey58","grey8"), labels=c("Negative","Positive")) + 
  scale_linetype_manual(values = c("solid","dotted"), labels=c("Negative","Positive")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()

#Plot Resilience PRS Stratified -- Baseline
png(paste0(dir,"Figures/Resilience_PRS_Amyloid_Stratified_Baseline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data[!is.na(Data$Amyloid.pos.factor),], aes(x=GLOBALRES_0.01_wAPOE, y=MEM, 
                                                        color=Amyloid.pos.factor, linetype=Amyloid.pos.factor)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + xlab("Cognitive Resilience PRS") + ylab("Baseline Memory") + 
  scale_color_manual(values = c("grey58","grey8"), labels=c("Negative","Positive")) + 
  scale_linetype_manual(values = c("solid","dotted"), labels=c("Negative","Positive")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()

#Plot LOAD PRS Stratified -- Decline
png(paste0(dir,"Figures/LOAD_PRS_Amyloid_Stratified_Decline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data[!is.na(Data$Amyloid.pos.factor),], aes(x=LOAD_0.01_wAPOE, y=memslopes, 
                                                        color=Amyloid.pos.factor, linetype=Amyloid.pos.factor)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + xlab("Alzheimer's Disease PRS") + ylab("Annual Memory Decline") + 
  scale_color_manual(values = c("grey58","grey8"), labels=c("Negative","Positive")) + 
  scale_linetype_manual(values = c("solid","dotted"), labels=c("Negative","Positive")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()

#Plot Resilience PRS Stratified -- Decline
png(paste0(dir,"Figures/Resilience_PRS_Amyloid_Stratified_Decline.png"),width=8.5,height=6,res=300,units="in")
ggplot(data=Data[!is.na(Data$Amyloid.pos.factor),], aes(x=GLOBALRES_0.01_wAPOE, y=memslopes, 
                                                        color=Amyloid.pos.factor, linetype=Amyloid.pos.factor)) + 
  geom_point() + geom_smooth(method="lm") + theme_bw() + xlab("Cognitive Resilience PRS") + ylab("Annual Memory Decline") + 
  scale_color_manual(values = c("grey58","grey8"), labels=c("Negative","Positive")) + 
  scale_linetype_manual(values = c("solid","dotted"), labels=c("Negative","Positive")) + 
  theme(legend.position=c(.85,.15),legend.title=element_text(size=24),legend.text=element_text(size=20), 
        axis.text=element_text(size=18), axis.title=element_text(size=18)) + 
  theme(axis.title.x=element_text(colour="black",size=24,face="bold")) + theme(legend.title=element_blank()) +
  theme(axis.title.y=element_text(colour="black",size=24,face="bold"))
dev.off()
