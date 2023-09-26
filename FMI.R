rm(list = ls())

#install.packages("googlesheets4")
library(googlesheets4)
#install.packages("dplyr")
library(dplyr)
#install.packages("tidyverse")
library(tidyverse)

# DATOS BANCO MUNDIAL

# GDP-----

url_gdp <- "https://docs.google.com/spreadsheets/d/1yE1HoUW-3MMU0u6e4WJjX6d4AXwS5F3jBN-G8RZL3lU/edit?usp=sharing"
gdp <-  read_sheet(url_gdp, range = "A4:BO270")

gdp <- gdp[,-c(1,3,4)]
gdp <- gdp %>% gather("YEAR","GDP",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004 )
# PIB PERCAPITA----

url_gdppp <- "https://docs.google.com/spreadsheets/d/15MB0xq72B_zlo4Ei7EBmzXokLrthKLCcXkB5cjsl8Ns/edit?usp=sharing"
gdppp <-  read_sheet(url_gdppp, range = "A4:BO270")

gdppp <- gdppp[,-c(1,3,4)]
gdppp <- gdppp %>% gather("YEAR","GDPPP",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004 )

# GROWTH-----
url_growth <- "https://docs.google.com/spreadsheets/d/1N5L8JCY4Aw0AFfQF4Va1J58T0lPvEKciofL-KrVNZ3w/edit#gid=912838590"

growth <-  read_sheet(url_growth, range = "A4:BO270")

growth <- growth[,-c(1,3,4)]
growth <- growth %>% gather("YEAR","GROWTH",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004 )

# CPI INFLATION ----
url_CPI <-"https://docs.google.com/spreadsheets/d/1-2_bXq-rxJ2HGJKsVQc_BBLWEOfWpq53SeVtl2lte40/edit#gid=153900464"

CPI <-  read_sheet(url_CPI, range = "A4:BO270")

CPI <- CPI[,-c(1,3,4)]
CPI <- CPI %>% gather("YEAR","CPI",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004 )

# POBLATION -----
url_POB <- "https://docs.google.com/spreadsheets/d/1oN3heGS1BxCaRteFUWgAffalAzUjq07Qwf4UxZSd8uY/edit#gid=144354364"

POB <-  read_sheet(url_POB, range = "A4:BO270")

POB <- POB[,-c(1,3,4)]
POB <- POB %>% gather("YEAR","POB",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004)

# TRADE-----
url_TRADE <- "https://docs.google.com/spreadsheets/d/1QrAm1dgyIk5WzBiSljhse9LG6KLTNR4UCeuwt6m7MXw/edit#gid=2021508676"

TRADE <-  read_sheet(url_TRADE, range = "A4:BO270")

TRADE <- TRADE[,-c(1,3,4)]
TRADE <- TRADE %>% gather("YEAR","TRADE",2:64) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004)

# GOV TO GDP-----
url_GOV <- "https://docs.google.com/spreadsheets/d/15mM61Ak7p5dLYt0odZZXuAviK2T9rw9ZKy-00Dk_AZo/edit#gid=1348795157"

GOV <-  read_sheet(url_GOV, range = "A4:BO270")

GOV <- GOV[,-c(1,3,4)]
GOV <- GOV %>% gather("YEAR","GOV_GDP",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004)

# GFC TO GDP-----
url_GCF <- "https://docs.google.com/spreadsheets/d/1Nmgrdm6hPBaJadcrxXDxjPFfl-ny7E_YBZJjyz9oNTg/edit#gid=2066328261"

GCF <-  read_sheet(url_GCF, range = "A4:BO270")

GCF <- GCF[,-c(1,3,4)]
GCF <- GCF %>% gather("YEAR","GCF",2:64 ) %>% 
  rename("COUNTRY" ="Country Code") %>% 
  filter(COUNTRY %in% c("NIC","HND","GTM","CRI","PAN","SLV","MEX", "COL", "DOM"), YEAR>2004)

# FINAL TABLE----
df <- inner_join(gdp,GCF)
df <- inner_join(df,GOV)
df <- inner_join(df,POB)
df <- inner_join(df,TRADE)
df <- inner_join(df,CPI)
df <- inner_join(df,growth)
df <- inner_join(df,gdppp)

#Order
df<-df[order(df$YEAR),]
df<-df[order(df$COUNTRY),]

# WRITE IN GOOGLE

ss= "1ETONCGMmuDmUbq_q4Q-oSJR8dA7QDTr878yOiONxe5I"

range_write(
  ss, 
  df
)


# INTERNATIONAL INVESTMENT POSITION 
url_iip_es <- "https://docs.google.com/spreadsheets/d/17v3WBiZbqx8VjpJ2Ho4NVkWhudNYdSvLdZh9_n8cm4U/edit?usp=sharing"
url_iip_nic <- "https://docs.google.com/spreadsheets/d/1OTqEw4UXet4uc74qpeE_kOtxTjCZ8KhGsXTxi76q7DU/edit?usp=sharing"
url_iip_cr <- "https://docs.google.com/spreadsheets/d/1A5oK1U_1m_O6Pju0M_KJXGT4c0lOKLZ-m4TpUz4bVEM/edit?usp=sharing"
url_iip_hnd <- "https://docs.google.com/spreadsheets/d/1AKUTruXZAOVlFibG5YeZik98aLvbk5QJylgfNN4kPNc/edit?usp=sharing"
url_iip_gtm <- "https://docs.google.com/spreadsheets/d/1dxnu1D9hn0DeUrIKbZL-P6erR3M7ACRjVJHhHKhcr84/edit?usp=sharing"   
url_iip_pan <- "https://docs.google.com/spreadsheets/d/1l3Mdo30uDNNE7BBr1uGxlk60DSznVyh1MfrC5StwIZY/edit?usp=sharing"
url_iip_col <- "https://docs.google.com/spreadsheets/d/1MBD_edNYLcRNn3RrI5La6lBaICLAGfY8TPckxhyj4O0/edit#gid=1299053176"
url_iip_mex <- "https://docs.google.com/spreadsheets/d/1Y9edjOivEfGb7-ZmRJh7yq7ZUOZn-5-F2Oa5v677ZBM/edit#gid=1168840384"
url_iip_dom<-"https://docs.google.com/spreadsheets/d/15V2XDUETbPhpf6P_FTMNgssAhJTwC-OmH1_5pTbVODY/edit#gid=298963192"

iip_es <- read_sheet(url_iip_es,
                       sheet = "Annual",
                       col_names = FALSE,
                       range = "a5:ae76"
)

iip_nic <- read_sheet(url_iip_nic,
                     sheet = "Annual",
                     col_names = FALSE,
                     range = "a5:w76"
)

iip_cr <- read_sheet(url_iip_cr,
                     sheet = "Annual",
                     col_names = FALSE,
                     range = "a5:t76"
)

iip_hnd <- read_sheet(url_iip_hnd,
                     sheet = "Annual",
                     col_names = FALSE,
                     range = "a5:t76"
)

iip_gtm <- read_sheet(url_iip_gtm,
                     sheet = "Annual",
                     col_names = FALSE,
                     range = "a5:s76"
)

iip_pan <- read_sheet(url_iip_pan,
                     sheet = "Annual",
                     col_names = FALSE,
                     range = "a5:ab76"
)
iip_col <- read_sheet(url_iip_col,
                      sheet = "Annual",
                      col_names = FALSE,
                      range = "a5:s76"
)
iip_mex <- read_sheet(url_iip_mex,
                      sheet = "Annual",
                      col_names = FALSE,
                      range = "a5:s76"
)
iip_dom <- read_sheet(url_iip_dom,
                      sheet = "Annual",
                      col_names = FALSE,
                      range = "a5:s76"
)

#Extraccion de variables a utilizar
iip_cr_1<-as.data.frame(rbind(iip_cr[1,], iip_cr[2,], iip_cr[39,]))
iip_cr_1<-data.frame(t(iip_cr_1))
iip_cr_1<-iip_cr_1[3:nrow(iip_cr_1),]
  
iip_es_1<-as.data.frame(rbind(iip_es[1,], iip_es[2,], iip_es[39,]))
iip_es_1<-data.frame(t(iip_es_1))
iip_es_1<-iip_es_1[14:nrow(iip_es_1),]


iip_gtm_1<-as.data.frame(rbind(iip_gtm[1,], iip_gtm[2,], iip_gtm[39,]))
iip_gtm_1<-data.frame(t(iip_gtm_1))
iip_gtm_1<-iip_gtm_1[2:nrow(iip_gtm_1),]


iip_hnd_1<-as.data.frame(rbind(iip_hnd[1,], iip_hnd[2,], iip_hnd[39,]))
iip_hnd_1<-data.frame(t(iip_hnd_1))
iip_hnd_1<-iip_hnd_1[3:nrow(iip_hnd_1),]

iip_nic_1<-as.data.frame(rbind(iip_nic[1,], iip_nic[2,], iip_nic[39,]))
iip_nic_1<-data.frame(t(iip_nic_1))
iip_nic_1<-iip_nic_1[6:nrow(iip_nic_1),]

iip_pan_1<-as.data.frame(rbind(iip_pan[1,], iip_pan[2,], iip_pan[39,]))
iip_pan_1<-data.frame(t(iip_pan_1))
iip_pan_1<-iip_pan_1[11:nrow(iip_pan_1),]

iip_col_1<-as.data.frame(rbind(iip_col[1,], iip_col[2,], iip_col[39,]))
iip_col_1<-data.frame(t(iip_col_1))
iip_col_1<-iip_col_1[2:nrow(iip_col_1),]


iip_mex_1<-as.data.frame(rbind(iip_mex[1,], iip_mex[2,], iip_mex[39,]))
iip_mex_1<-data.frame(t(iip_mex_1))
iip_mex_1<-iip_mex_1[2:nrow(iip_mex_1),]



iip_dom_1<-as.data.frame(rbind(iip_dom[1,], iip_dom[2,], iip_dom[39,]))
iip_dom_1<-data.frame(t(iip_dom_1))
iip_dom_1<-iip_dom_1[2:nrow(iip_dom_1),]

#Nombre variable
colnames(iip_cr_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_es_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_gtm_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_hnd_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_nic_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_pan_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_col_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_mex_1) <-c("YEAR", "ASSETS", "LIABILITIES")
colnames(iip_dom_1) <-c("YEAR", "ASSETS", "LIABILITIES")

#Codigo Pais

iip_cr_1 <- iip_cr_1 %>%
  mutate(
   country=rep("CRI",18) 
  )
  
iip_es_1 <- iip_es_1 %>%
  mutate(
    country=rep("SLV",18) 
  )
iip_gtm_1 <- iip_gtm_1 %>%
  mutate(
    country=rep("GTM",18) 
  )
iip_hnd_1 <- iip_hnd_1 %>%
  mutate(
    country=rep("HND",18) 
  )
iip_nic_1 <- iip_nic_1 %>%
  mutate(
    country=rep("NIC",18) 
  )
iip_pan_1 <- iip_pan_1 %>%
  mutate(
    country=rep("PAN",18) 
  )
iip_col_1 <- iip_col_1 %>%
  mutate(
    country=rep("COL",18) 
  )
iip_mex_1 <- iip_mex_1 %>%
  mutate(
    country=rep("MEX",18) 
  )
iip_dom_1 <- iip_dom_1 %>%
  mutate(
    country=rep("DOM",18) 
  )

#Formato
iip_cr_1$ASSETS <- as.numeric(iip_cr_1$ASSETS)
iip_cr_1$LIABILITIES <- as.numeric(iip_cr_1$LIABILITIES)

iip_es_1$ASSETS <- as.numeric(iip_es_1$ASSETS)
iip_es_1$LIABILITIES <- as.numeric(iip_es_1$LIABILITIES)

iip_gtm_1$ASSETS <- as.numeric(iip_gtm_1$ASSETS)
iip_gtm_1$LIABILITIES <- as.numeric(iip_gtm_1$LIABILITIES)

iip_hnd_1$ASSETS <- as.numeric(iip_hnd_1$ASSETS)
iip_hnd_1$LIABILITIES <- as.numeric(iip_hnd_1$LIABILITIES)

iip_nic_1$ASSETS <- as.numeric(iip_nic_1$ASSETS)
iip_nic_1$LIABILITIES <- as.numeric(iip_nic_1$LIABILITIES)

iip_pan_1$ASSETS <- as.numeric(iip_pan_1$ASSETS)
iip_pan_1$LIABILITIES <- as.numeric(iip_pan_1$LIABILITIES)

iip_col_1$ASSETS <- as.numeric(iip_col_1$ASSETS)
iip_col_1$LIABILITIES <- as.numeric(iip_col_1$LIABILITIES)

iip_mex_1$ASSETS <- as.numeric(iip_mex_1$ASSETS)
iip_mex_1$LIABILITIES <- as.numeric(iip_mex_1$LIABILITIES)

iip_dom_1$ASSETS <- as.numeric(iip_dom_1$ASSETS)
iip_dom_1$LIABILITIES <- as.numeric(iip_dom_1$LIABILITIES)

#Union de las tablas
iip<-rbind.data.frame(iip_cr_1, iip_es_1,iip_gtm_1,iip_hnd_1,iip_nic_1,iip_pan_1,iip_col_1,iip_mex_1,iip_dom_1)
colnames(iip)<-c("YEAR", "ASSETS", "LIABILITIES", "COUNTRY")
iip$YEAR<-as.numeric(iip$YEAR)
iip<-iip[order(iip$YEAR),]
iip<-iip[order(iip$COUNTRY),]


#READING GDP
GDP <- read_sheet("https://docs.google.com/spreadsheets/d/1ETONCGMmuDmUbq_q4Q-oSJR8dA7QDTr878yOiONxe5I/edit#gid=0",
                          sheet = "base",
                          col_names = TRUE,
                          range = "C1:C163"
)
iip$GDP<-as.numeric(GDP$GDP)
iip <- as.data.frame(iip)
iip <- iip %>%
  mutate(
    FI = (ASSETS+LIABILITIES)*1000000/GDP
  )
#Escribir en Drive
ss <-"1ETONCGMmuDmUbq_q4Q-oSJR8dA7QDTr878yOiONxe5I"
range <-"J1"
data<-data.frame(cbind(iip[,2:3],iip[,6]))
colnames(data)<-c("ASSETS", "LIABILITIES", "FI")
range_write(ss,data,range=range)

#FIXED EFFECTS MODEL
install.packages("plm")
library(plm)

MODEL<-read_sheet("https://docs.google.com/spreadsheets/d/1ETONCGMmuDmUbq_q4Q-oSJR8dA7QDTr878yOiONxe5I/edit#gid=0",
                          sheet = "base",
                          col_names = TRUE,
                          range = "A1:L103"
)

fixed <- plm(GROWTH ~ FI+GCF+GOV_GDP+POB+TRADE+CPI, data=MODEL, index=c("COUNTRY", "YEAR"), model="within")
summary(fixed)

random <- plm(GROWTH ~ FI+GCF+GOV_GDP+POB+TRADE+CPI, data=MODEL, index=c("COUNTRY", "YEAR"), model="random")
summary(random)