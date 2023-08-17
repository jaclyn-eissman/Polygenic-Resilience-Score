#Packages
library(stringr)
library(nlme)
library(openxlsx)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/Resilience_PRS/"

#Read in data and combine
Data_long <- readRDS(paste0(dir,"Data/VMAP_Longitudinal_Data_Master.rds"))
PRS <- readRDS(paste0(dir,"Data/VMAP_PRS_Master.rds"))
Data_long <- merge(Data_long,PRS,by="ID")
Data_long <- Data_long %>% filter(num_visits_MEM>=2)

#Define PRS vars
vars <- c("LOAD_1_noAPOE","LOAD_0.01_noAPOE","LOAD_0.00001_noAPOE","GLOBALRES_1_noAPOE","GLOBALRES_0.01_noAPOE","GLOBALRES_0.00001_noAPOE")

#Initialize vectors
B <- NULL
SE <- NULL
PVAL <- NULL
PREDICTOR <- NULL
MODEL <- NULL
ctrl <- lmeControl(msMaxIter=2000, opt="optim") 

#Main effects -- Longitudinal -- Amyloid Positive
for(i in 1:length(vars)){
  column=which(grepl(vars[i],names(Data_long)))
  Data_long$PRS <- Data_long[,column]
  output <- lme(MEM ~ Age_bl + as.factor(Sex) + PRS*interval_MEM, 
                random=~1+interval_MEM|ID, data=Data_long[Data_long$Amyloid.pos.factor=="Yes",], 
                na.action=na.omit, control=ctrl)
  summary(output)
  
  estimate <- summary(output)$tTable["PRS:interval_MEM", "Value"]
  se <- summary(output)$tTable["PRS:interval_MEM", "Std.Error"]
  pval <- summary(output)$tTable["PRS:interval_MEM", "p-value"]
  predictor <- vars[i]
  model <- "Main Effects: Longitudinal Memory (Amyloid Positives)"
  
  B<-rbind(B,estimate)
  SE<-rbind(SE,se)
  PVAL<-rbind(PVAL,pval)
  PREDICTOR<-rbind(PREDICTOR,predictor)
  MODEL<-rbind(MODEL,model)
}

#Main effects -- Longitudinal -- Amyloid Negative
for(i in 1:length(vars)){
  column=which(grepl(vars[i],names(Data_long)))
  Data_long$PRS <- Data_long[,column]
  output <- lme(MEM ~ Age_bl + as.factor(Sex) + PRS*interval_MEM, 
                random=~1+interval_MEM|ID, data=Data_long[Data_long$Amyloid.pos.factor=="No",], 
                na.action=na.omit, control=ctrl)
  summary(output)
  
  estimate <- summary(output)$tTable["PRS:interval_MEM", "Value"]
  se <- summary(output)$tTable["PRS:interval_MEM", "Std.Error"]
  pval <- summary(output)$tTable["PRS:interval_MEM", "p-value"]
  predictor <- vars[i]
  model <- "Main Effects: Longitudinal Memory (Amyloid Negatives)"
  
  B<-rbind(B,estimate)
  SE<-rbind(SE,se)
  PVAL<-rbind(PVAL,pval)
  PREDICTOR<-rbind(PREDICTOR,predictor)
  MODEL<-rbind(MODEL,model)
}

#Combine and FDR correct
Results <- data.frame(MODEL,PREDICTOR,B,SE,PVAL)
rownames(Results) <- c()
colnames(Results) <- c("Model","Predictor","BETA","SE","P")
Results$P.FDR <- p.adjust(Results$P,method="fdr")

#Write out
write.xlsx(Results,paste0(dir,"Tables/LME_Main_Amyloid_Strat_All_Thresh_without_APOE.xlsx"))

