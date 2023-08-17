#Packages
library(stringr)
library(nlme)
library(openxlsx)
library(dplyr)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/Resilience_PRS/"

#Read in data and combine
Data_long <- readRDS(paste0(dir,"Data/VMAP_Longitudinal_Data_Master.rds"))
PRS <- readRDS(paste0(dir,"Data/VMAP_PRS_Master.rds"))
Data_long <- merge(Data_long,PRS,by="ID")
Data_long <- Data_long %>% filter(num_visits_MEM>=2)

#Define PRS vars
vars <- c("LOAD_1_wAPOE","LOAD_0.01_wAPOE","LOAD_0.00001_wAPOE","GLOBALRES_1_wAPOE","GLOBALRES_0.01_wAPOE","GLOBALRES_0.00001_wAPOE")

#Initialize vectors
B <- NULL
SE <- NULL
PVAL <- NULL
PREDICTOR <- NULL
MODEL <- NULL
ctrl <- lmeControl(msMaxIter=2000, opt="optim") 

#Main effects -- Longitudinal
for(i in 1:length(vars)){
  column=which(grepl(vars[i],names(Data_long)))
  Data_long$PRS <- Data_long[,column]
  output <- lme(MEM ~ Age_bl + as.factor(Sex) + PRS*interval_MEM*CSF.ab1.42, 
                random=~1+interval_MEM|ID, data=Data_long, na.action=na.omit, control=ctrl)
  summary(output)
 
  estimate <- summary(output)$tTable["PRS:interval_MEM:CSF.ab1.42", "Value"]
  se <- summary(output)$tTable["PRS:interval_MEM:CSF.ab1.42", "Std.Error"]
  pval <- summary(output)$tTable["PRS:interval_MEM:CSF.ab1.42", "p-value"]
  predictor <- vars[i]
  model <- "Amyloid Interaction: Longitudinal Memory"
  
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
write.xlsx(Results,paste0(dir,"Tables/LME_Interaction_All_Thresh_with_APOE.xlsx"))

