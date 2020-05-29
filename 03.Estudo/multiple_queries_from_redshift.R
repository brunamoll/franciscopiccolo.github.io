library(stringr)
library(rJava)
library(RJDBC)
library(tidyverse)
library(stringr)
library(gridExtra)

driver <- JDBC(driverClass = 'com.amazon.redshift.jdbc41.Driver', classPath = Sys.glob('C:/Users/francisco.piccolo/AppData/Local/Continuum/anaconda3/envs/rstudio/lib/R/library/RJDBC/java/RedshiftJDBC41-1.1.9.1009.jar'), identifier.quote="`")
db_end <- sprintf("jdbc:redshift://%s:%s/%s?tcpKeepAlive=true&ssl=true&sslfactory=com.amazon.redshift.ssl.NonValidatingFactory", 'gfg-dwh-prod.dafiti.io', '5439', 'dftdwh')  
jconn <- dbConnect(driver, db_end, 'franciscopiccolo', 'Abc12345')
sql_syntax <- readr::read_file('C:/Users/francisco.piccolo/Desktop/R/Queries/teste.sql')

# query 1
begin_query_1 <- min(stringr::str_locate(string=sql_syntax,'-- query_1_inicio'))
end_query_1 <- max(stringr::str_locate(string=sql_syntax,'-- query_1_fim'))
query_1 <- RJDBC::dbGetQuery(jconn,substr(sql_syntax,begin_query_1,end_query_1))
head(query_1)

# query 2
begin_query_2 <- min(stringr::str_locate(string=sql_syntax,'-- query_2_inicio'))
end_query_2 <- max(stringr::str_locate(string=sql_syntax,'-- query_2_fim'))
query_2 <- RJDBC::dbGetQuery(jconn,substr(sql_syntax,begin_query_2,end_query_2))
head(query_2)


