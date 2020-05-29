library(googlesheets)
library(tidyverse)

# Libere o app tidyverse para acessar a sua conta google
gs_ls() %>% # lista as planilhas da sua conta, porém pede permissão antes
View()


# Registre a planilha que quer ler dados, use gs_title ou gs_key. Um objeto gsheet (gerado com o registro) será argumento das funções de leitura
gsheet_taxes <- gs_title('01.Lista de Acompanhamento')

# Visite a gsheet no browser
gsheet_taxes %>% gs_browse(ws=2)  # WS é o index da aba

# Lendo dados da planilha e aba especificada pelo nome
taxes_df <- gsheet_taxes %>% 
  gs_read(ws='Página80')
  
View(taxes_df)

data.frame(
  montth=taxes_df[3:6,1],
  icms_dif=taxes_df[3:6,5],
  pis_dif=taxes_df[3:6,9],
  cofins_dif=taxes_df[3:6,13]
  ) %>% 
  gather('teste','teste_2',2:4) %>% 
  ggplot(aes(x=teste,y=teste_2,group=2))+
  geom_line(color=teste)



  





