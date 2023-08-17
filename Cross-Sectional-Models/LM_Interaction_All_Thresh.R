#Packages
library(stringr)
library(nlme)
library(openxlsx)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/Resilience_PRS/"

#Read in data and combine
Data_bl <- readRDS(paste0(dir,"Data/VMAP_Baseline_Data_Master.rds"))
PRS <- readRDS(paste0(dir,"Data/VMAP_PRS_Master.rds"))
Data_bl <- merge(Data_bl,PRS,by="ID")

#Define PRS vars
vars <- c("LOAD_1_wAPOE","LOAD_0.01_wAPOE","LOAD_0.00001_wAPOE","GLOBALRES_1_wAPOE","GLOBALRES_0.01_wAPOE","GLOBALRES_0.00001_wAPOE")

#Initialize vectors
B <- NULL
SE <- NULL
PVAL <- NULL
PREDICTOR <- NULL
MODEL <- NULL

#Main effects -- Cross Sectional
for(i in 1:length(vars)){
  column=which(grepl(vars[i],names(Data_bl)))
  Data_bl$PRS <- Data_bl[,column]
  output <- lm(MEM ~ Age_bl + as.factor(Sex) + PRS*CSF.ab1.42, data=Data_bl, na.action=na.omit)
  summary(output)
 
  estimate <- summary(output)$coefficients["PRS:CSF.ab1.42", "Estimate"]
  se <- summary(output)$coefficients["PRS:CSF.ab1.42", "Std. Error"]
  pval <- summary(output)$coefficients["PRS:CSF.ab1.42", "Pr(>|t|)"]
  predictor <- vars[i]
  model <- "Amyloid Interaction: Cross-Sectional Memory"
  
  B<-rbind(B,estimate)
  SE<-rbind(SE,se)
  PVAL<-rbind(PVAL,pval)
  PREDICTOR<-rbind(PREDICTOR,predictor)
  MODEL<-rbind(MODEL,model)
}

#Combine
Results <- data.frame(MODEL,PREDICTOR,B,SE,PVAL)
rownames(Results) <- c()
colnames(Results) <- c("Model","Predictor","BETA","SE","P")
Results$P.FDR <- p.adjust(Results$P,method="fdr")

#Write out
write.xlsx(Results,paste0(dir,"Tables/LM_Interaction_All_Thresh_with_APOE.xlsx"))


