#Packages
library(nlme)
library(data.table)
library(plyr)
library(Hmisc)
library(dplyr)

#Directory and source get_slopes()
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/Resilience_PRS/"
source(paste0(dir,"Scripts/get_slopes.R"))

###BUILD SLOPES
data <- readRDS(paste0(dir,"Data/MAP_bh_d20220301_m20220301.rds"))
data$map.id <- as.numeric(gsub("^0+", "", data$map.id))
data$np.memory.composite <- as.numeric(data$np.memory.composite)
data$age <- as.numeric(data$age)
data <- data %>% filter(!is.na(age)) %>% filter(!is.na(np.memory.composite)) #N=335
data <- data %>% filter(map.id!=12) #N=334 (removed person with dementia)

#get 1st
data <- data[order(data$map.id, data$age),]
data$first <- Lag(data$map.id) != data$map.id
data$first[1] <- T

#build 1st 
data_first <- data[data$first==T,]
data_first <- data_first[,c("map.id", "age", "diagnosis.factor")]
names(data_first) <- c("map.id", "age_bl", "dx_bl")
data <- merge(data, data_first, by="map.id")

#get last
data <- data[order(data$map.id, desc(data$age)),]
data$last <- Lag(data$map.id) != data$map.id
data$last[1] <- T

#determine number of visits
num_visits_MEM <- data.frame(table(data$map.id), stringsAsFactors=F)
names(num_visits_MEM) <- c("map.id", "num_visits_MEM")
data <- merge(data, num_visits_MEM, by="map.id")

#get slopes
data$interval <- data$age - data$age_bl
data_2 <- data %>% filter(num_visits_MEM>=2)
data <- merge(data,get_slopes(data_2,"np.memory.composite", "interval", "map.id", "memslopes"), by="map.id", all.x=T)

#Subset down
data$csf.ab1.42 <- as.numeric(data$csf.ab1.42)
data$education <- as.numeric(data$education)
data$sex <- as.factor(data$sex)
data$diagnosis.factor <- as.factor(data$diagnosis.factor)
data$amyloidPos.factor <- as.factor(data$amyloidPos.factor)
data$apoe4pos.factor <- as.factor(data$apoe4pos.factor)
data <- data[,c("map.id","age","age_bl","num_visits_MEM","sex","np.memory.composite","memslopes","interval","csf.ab1.42",
                "amyloidPos.factor","first","last","education","apoe4pos.factor","dx_bl")]
names(data) <- c("map.id","Age","Age_bl","num_visits_MEM","Sex","MEM","memslopes","interval_MEM","CSF.ab1.42",
                 "Amyloid.pos.factor","first","last","Education","Apoe4.pos.factor","Dx_bl")

#Make baseline and long. dfs
names(data)[1] <- "ID"
data_baseline <- data %>% filter(first==T)
data_baseline <- as.data.frame(data_baseline)
length(unique(data_baseline$ID))
data_long <- data 
data$CSF.ab1.42 <- NULL
data$Amyloid.pos.factor <- NULL
data_long <- merge(data,data_baseline[,c("ID","CSF.ab1.42")],by="ID",all.x=T) 
data_long <- merge(data_long,data_baseline[,c("ID","Amyloid.pos.factor")],by="ID",all.x=T) 
data_long <- as.data.frame(data_long)
length(unique(data_long$ID))

#Write out
saveRDS(data_baseline,paste0(dir,"Data/VMAP_Baseline_Data_Master.rds"))
saveRDS(data_long,paste0(dir,"Data/VMAP_Longitudinal_Data_Master.rds"))


