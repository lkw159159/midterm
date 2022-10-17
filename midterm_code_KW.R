library(data.table);library(magrittr);library(ggpubr);library(rvg);library(officer) 
a <- fread("https://raw.githubusercontent.com/jinseob2kim/R-skku-biohrs/main/data/example_g1e.csv")


library(dplyr)

Qs=colnames(a) %>% grep("Q_",.,value=T)

if(colnames(a))