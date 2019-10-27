---
title: "Executando queries no Redshift através do R"
date: 2019-10-25
header:
excerpt: "Neste post irei mostrar uma forma fácil e rápida de acessar o banco de dados Redshift através do R"
categories: [articles]
---

##### Introdução

Neste tutorial, irei apresentar um passo a passo sobre como acesar o
banco de dados Redshift através da ferramenta R. Esta tarefa será muito
útil para quem prefere utilizar o R, ao invés do convencional Excel para
realizar projetos de análise de dados. O objetivo é consultar o banco de
dados, criar um data.frame e trazê-lo ao R, para então realizar as
análises.

##### 1º Passo

Baixe o driver JDBC da Amazon. Ele é necessário para permitir a conexão
de uma ferramenta (i.e. R) ao cluster da Amazon que você tem acesso.
Neste
[link](https://docs.aws.amazon.com/pt_br/redshift/latest/mgmt/configure-jdbc-connection.html#obtain-jdbc-url)
há os arquivos para cada versão do JDBC.

Obs: Caso ao final do processo a consulta ao banco falhe, veja se o
arquivo não veio corrompido. Isso pode acontecer caso o dowload seja
feito diretamente pelo R.

##### 2º Passo

Após baixar o driver, acesse o R ou Rstudio, instale e chame os
seguintes pacotes: rJava e RJDBC.

{% highlight r %} install.packages(“rJava”) install.packages(“RJDBC”)

library(rJava) library(RJDBC) {% endhighlight %}

##### 3º Passo

Crie uma variável (e.g. driver) contendo o arquivo JDBC que foi baixado
no passo 1. Use o código abaixo para este passo:

{% highlight r %} driver &lt;- JDBC(driverClass =
“com.amazon.redshift.jdbc41.Driver”, classPath = Sys.glob(“caminho do
arquivo/RedshiftJDBC41-1.1.9.1009.jar”), identifier.quote=“\`”) {%
endhighlight %}

##### 4º Passo

Crie uma variável (e.g. db.connection) que irá indicar as informações
do banco de dados a ser acessado pelo R. Use o código abaixo para este
passo:

{% highlight r %} db.connection &lt;-
sprintf(“jdbc:redshift://%s:%s/%s?tcpKeepAlive=true&ssl=true&sslfactory=com.amazon.redshift.ssl.NonValidatingFactory”,
“host do banco”, “porta”, “nome do banco”) {% endhighlight %}

##### 5º Passo

Crie uma variável (e.g. access) que irá conter as informações do banco a
ser acessado e também do usuário que irá acessá-lo. Use o código abaixo
para este passo, colocando suas respectivas informações de usuário e
senha.

{% highlight r %} access &lt;- dbConnect(driver, db.end, “user”,
“password”) {% endhighlight %}

Veja que a função “dbConnect” usa o arquivo driver de acesso ao banco,
as informações de qual banco será acessado e as informações do usuário
que irá acessá-lo.

##### 6º Passo

Tendo as 3 variáveis criadas, para acessar o banco de dados será
necessário apenas a última (criada no item 5). Para acessar o banco de
dados, será usado o pacote RJDBC (baixado no passo 2). Abaixo há alguns
exemplos de códigos consultando o Redshift:

Obs: Queries executadas diretamente no console do R devem estar entre
aspas.

{% highlight r %} RJDBC::dbGetQuery(jconn,“select
order,client,sale.date from orders.tb limit 10”)

RJDBC::dbGetQuery(jconn,“select supplier,invoice,delivery.date from
supplier.tb where 1=1 and delivery.date = 2019-01-30 limit 10”) {%
endhighlight %}

##### 7º Passo

Para explorar de maneira completa esta funcionalidade, é interessante
que, ao invés de escrever a query no console do R, a query seja salva em
um arquivo (.sql) e o R acesse este arquivo e salve-o em uma variável.
Para isso, é necessário instalar e chamar o pacote readr. Após isso, o
código do passo 6 será:

{% highlight r %} – salvando o arquivo .sql em uma variável sql\_file
&lt;- readr::read\_file(“Caminho.do.arquivo/script.sql”)

– consultando o redshift através do arquivo query\_redshift &lt;-
RJDBC::dbGetQuery(jconn,sql\_file) {% endhighlight %}

##### Bônus

Se houver a necessidade de criar várias consultas no Redshift para um
mesmo projeto de análise de dados, é possível salvar várias queries no
mesmo arquivo. Para acessar estas queries separadamente é necessário o
uso de funções regexp (a.k.a expressões regulares), para que o arquivo
seja delimitado, indicando o início e fim de cada query dentro dele.

Para realizar esta etapa, primeiro separe cada query dentro do arquivo
.sql através de comentários (e.g. “– query.x.begin” e
“query.x.end”). Na sequência, instale e chame o pacote stringr, que
possui funções de manipulação de strings.

{% highlight r %} – salvando o arquivo .sql em uma variável sql.syntax
&lt;-
readr::read.file(‘C:/Users/francisco.piccolo/Desktop/R/Queries/cmv.validation.sql’)

– criando variável com query 1. Uso de regexp para separar as queries
dentro do arquivo

query.1 ->
RJDBC::dbGetQuery(jconn,substr(sql.syntax,min(stringr::str\_locate(string=sql\_syntax,‘–
query.1.begin’)),max(stringr::str.locate(string=sql\_syntax,‘–
query.1.end’))))

query_2 ->
RJDBC::dbGetQuery(jconn,substr(sql.syntax,min(stringr::str.locate(string=sql.syntax,‘–
query.2.begin’)),max(stringr::str.locate(string=sql.syntax,‘–
query.2.end’))))

query_3 ->
RJDBC::dbGetQuery(jconn,substr(sql_syntax,min(stringr::str_locate(string=sql_syntax,‘–
query.3.begin’)),max(stringr::str_locate(string=sql_syntax,‘–
query.3.end’)))) {% endhighlight %}

##### Conclusão

Este passo a passo buscou mostrar como é simples o acesso ao redshift
através do R. Uma excelente alternativa caso voê deseje fazer análises
de dados mais robustas, onde o Excel não consegue ser tão eficiente. Com
o arquivo .sql é possível criar qualquer data.frame no redshift e salvar
em uma variável dentro do R.

Os passos 3, 4 e 5 podem ser automatizados através de uma função, onde
as informações de acesso ao banco podem ser salvas em um arquivo (.txt)
e a função pode consultá-lo para então trazer os parâmetros necessários
de maneira mais fácil. Irei fazer esta melhoria em breve e atualizo este
post.

##### Leituras adicionais

[Connecting to Amazon Redshift from
R](https://www.progress.com/tutorials/jdbc/connecting-to-amazon-redshift-from-r-via-jdbc-driver)

[A comprehensive guide to connect R to Amazon
Redshift](https://www.r-bloggers.com/a-comprehensive-guide-to-connect-r-to-amazon-redshift/)
