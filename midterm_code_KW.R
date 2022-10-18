library(data.table);library(magrittr);library(ggpubr);library(rvg);library(officer) 
a <- fread("https://raw.githubusercontent.com/jinseob2kim/R-skku-biohrs/main/data/example_g1e.csv")

library(tidyverse)

#Q1. “Q_” 로 시작하는 변수는 범주형(factor)으로, 나머지 변수는 숫자형(integer)으로 만드세요

##변수 지정
colnames(a)
Qs = colnames(a) %>% grep("Q_",.,value=T)
non_Qs = setdiff(colnames(a),Qs)

##변수 변환
for(i in Qs){
 a[[i]] = as.factor(a[[i]])
}
for(i in non_Qs){
  a[[i]] = as.integer(a[[i]])
}

##결과 확인
summary(a)

#Q2. 연속 변수 “WSTC”와 “BMI”의 연도별 평균 및 표준편차를 구하세요
a %>% 
  group_by(EXMD_BZ_YYYY) %>% 
  summarize(meanWSTC=mean(WSTC),
            sdWSTC=sd(WSTC),
            meanBMI=mean(BMI),
            sdBMI=sd(BMI))

#Q3. 연도별 “FBS”를 나타내는 Boxplot을 그린 후 pptx로 저장하세요. (x축: “EXMD_BZ_YYYY”, y축: “FBS”)
library(ggpubr)

##
box=a %>% 
  ggboxplot(x="EXMD_BZ_YYYY", y="FBS", 
            color='EXMD_BZ_YYYY', legend= 'bottom', 
            title='box plot of FBS by year')

read_pptx() %>% 
  add_slide() %>% ph_with(dml(ggobj=box),location=ph_location_type(type="body")) %>% 
  print(target="boxplot.pptx")
