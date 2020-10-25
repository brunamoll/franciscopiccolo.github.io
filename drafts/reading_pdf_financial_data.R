library(tidyverse)
library(tabulizer)
library(googlesheets)
library(pdftools)

path <- "C:/Users/francisco.piccolo/Desktop/R"
file <- "cielo"
year <- "2017"
quarter <- "02.pdf"
page <- 29
file_2 <- paste(file, year, quarter, sep = "")

pdf <- tabulizer::extract_tables(file = paste(path, file_2, sep = "/"),
                          pages = page,
                          method = "stream",
                          encoding = "UTF-8",
                          copy = F)


pdftools::pdf_text(pdf = paste(path, file_2, sep = "/")) %>% View()

data.frame(pdf[1]) %>%
  mutate(teste = trimws(str_replace_all(X1, pattern = "[^0-9?!\\ !\\(!\\)]", ""))) %>% 
  separate(col = teste, into = c("col1","col2"), sep = " ") %>%
  readr::write_csv(path = "C:/Users/francisco.piccolo/Desktop/R/franciscopiccolo.github.io/fundamental_analysis/cielo_teste.csv")

googlesheets::gs_upload(file = "C:/Users/francisco.piccolo/Desktop/R/franciscopiccolo.github.io/fundamental_analysis/cielo_teste.csv", sheet_title = "teste_upload",
                        overwrite = T)




