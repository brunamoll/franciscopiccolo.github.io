---
title: "Análise dos resíduos no modelo de regressão linear"
date: 2019-11-20
header:
excerpt: "Neste post, irei analisar os resíduos gerados no modelo de regressão linear para validar uma das premissas necessárias do modelo"
---

O modelo de regressão linear é bastante utilizado na predição de
variáveis contínuas, onde há uma ou mais variáveis independentes e uma
variável dependente (em que se busca comprova uma hipótese sobre seu
comportamento). Este é um modelo bastante simples de ser aplicado e um
dos primeiros a ser ensinado nas aulas de Econometria. Porém, apesar de
sua simplicidade, para que o modelo gere resultados confiáveis algumas
premissas precisam ser satisfeitas, sendo elas:

1.  Não existência de multicolinearidade entre as variáveis dependentes.

2.  Não existência de autocorrelação na variável dependente.

3.  Homocedasticidade nos resíduos gerados pelo modelo, ou seja, não
    existência de padrão no comportamento dos resíduos.

4.  Distribuição normal dos resíduos.

5.  Média aritmética dos residuos deve ser igual a zero.

Satisfazendo estas premissas, o modelo pode ser execuato e as conclusões
geradas serão confiáveis para permitir a tomada de decisão. Neste post,
irei analisar a premissa nº 3 e 4, que trata dos resíduos gerados pelo
modelo de regressão linear. Para isso, vou usar uma base de dados que
apresenta o preço da cana de açucar como variável independente e a área
plantada (em hectares) de cana de açucar, que será a variável
dependente.

A ideia deste exemplo é analisar, através de um modelo de regressão
linear simples, a elasticidade da oferta da cana de açucar em função do
preço de venda. A hipótese é que existe elasticidade na oferta, onde a
área plantada aumenta conforme o preço também aumenta. Porém para
validar esta elasticidade, é necessário comprovar, através da regressão,
que as variáveis possuem correlação e isso dependerá da validade da
premissa 3 e 4 do modelo.

Para este exemplo, serão utilizados os pacotes abaixo:

    library(tidyverse)
    library(lmtest)
    library(corrplot)
    library(readxl)
    library(gridExtra)
    library(ggthemes)

    # Definindo tema padrão dos gráficos
    theme_set(theme_economist())

Abaixo consta uma amostra da base de dados com os valores do preço da
cana de açucar e área plantada.

<table>
<caption>Tabela 1: Amostra dos dados</caption>
<thead>
<tr class="header">
<th style="text-align: center;">periodo</th>
<th style="text-align: center;">area</th>
<th style="text-align: center;">valor</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: center;">1</td>
<td style="text-align: center;">29</td>
<td style="text-align: center;">0.075258</td>
</tr>
<tr class="even">
<td style="text-align: center;">2</td>
<td style="text-align: center;">71</td>
<td style="text-align: center;">0.114894</td>
</tr>
<tr class="odd">
<td style="text-align: center;">3</td>
<td style="text-align: center;">42</td>
<td style="text-align: center;">0.101075</td>
</tr>
<tr class="even">
<td style="text-align: center;">4</td>
<td style="text-align: center;">90</td>
<td style="text-align: center;">0.110309</td>
</tr>
<tr class="odd">
<td style="text-align: center;">5</td>
<td style="text-align: center;">72</td>
<td style="text-align: center;">0.109562</td>
</tr>
<tr class="even">
<td style="text-align: center;">6</td>
<td style="text-align: center;">57</td>
<td style="text-align: center;">0.132486</td>
</tr>
<tr class="odd">
<td style="text-align: center;">7</td>
<td style="text-align: center;">44</td>
<td style="text-align: center;">0.141783</td>
</tr>
<tr class="even">
<td style="text-align: center;">8</td>
<td style="text-align: center;">61</td>
<td style="text-align: center;">0.209559</td>
</tr>
<tr class="odd">
<td style="text-align: center;">9</td>
<td style="text-align: center;">60</td>
<td style="text-align: center;">0.188259</td>
</tr>
<tr class="even">
<td style="text-align: center;">10</td>
<td style="text-align: center;">70</td>
<td style="text-align: center;">0.195946</td>
</tr>
</tbody>
</table>

O modelo de regressão proposto para este exemplo é definido pela equação
abaixo.

*l**n**Y*<sub>*t*</sub> = *β*<sub>1</sub> + *β*<sub>2</sub>(*l**n**X*<sub>*t*</sub>) + *U*<sub>*t*</sub>

Onde:

*Y*<sub>*t*</sub> = área plantada no ano t (em hectares), em log natural

*X*<sub>*t*</sub> = preço no ano t em, log natural

Ao se utilizar a transformação em log natural (base **e**), por conta de
suas propriedades específicas, a variação de um período para o outro é
interpretada como variação percentual.

O exemplo abaixo mostra como isto ocorre:

<table>
<caption>Tabela 2: Valores com log na base e</caption>
<thead>
<tr class="header">
<th style="text-align: right;">Valor</th>
<th style="text-align: left;">Crescimento</th>
<th style="text-align: right;">Log.natural</th>
<th style="text-align: left;">Delta</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">100</td>
<td style="text-align: left;">-</td>
<td style="text-align: right;">4.605170</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: right;">105</td>
<td style="text-align: left;">5%</td>
<td style="text-align: right;">4.653960</td>
<td style="text-align: left;">0.0488</td>
</tr>
<tr class="odd">
<td style="text-align: right;">112</td>
<td style="text-align: left;">6.67%</td>
<td style="text-align: right;">4.718499</td>
<td style="text-align: left;">0.0645</td>
</tr>
<tr class="even">
<td style="text-align: right;">120</td>
<td style="text-align: left;">7.14%</td>
<td style="text-align: right;">4.787492</td>
<td style="text-align: left;">0.069</td>
</tr>
</tbody>
</table>

Veja como o crescimento percentual dos valores (5.00%, 6.67% e 7.14%)
ficam bem próximos dos deltas, que é a diferença entre o log natural do
número com relação ao log natural do número anterior (4.88%,6.45% e
6.90%). Desta forma, se a equação estiver em logarítmo natural em ambos
os lados, pode-se interpretar que a variação percentual na variável
explicativa irá gerar uma variação percentual de *β*<sub>1</sub> na
variável dependente. Olhando na tabela acima, é como se o cálculo
estivesse partindo da coluna delta em direção à coluna Valor.

Ao tentar criar esta mesma tabela com outros logarítmos (e.g. base 2 ou
base 10), não se alcança os mesmos resultados.

<table>
<caption>Tabela 3: Valores com log na base 2</caption>
<thead>
<tr class="header">
<th style="text-align: right;">Valor</th>
<th style="text-align: left;">Crescimento</th>
<th style="text-align: right;">Log.natural</th>
<th style="text-align: left;">Delta</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">100</td>
<td style="text-align: left;">-</td>
<td style="text-align: right;">6.643856</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: right;">105</td>
<td style="text-align: left;">5%</td>
<td style="text-align: right;">6.714245</td>
<td style="text-align: left;">0.0704</td>
</tr>
<tr class="odd">
<td style="text-align: right;">112</td>
<td style="text-align: left;">6.67%</td>
<td style="text-align: right;">6.807355</td>
<td style="text-align: left;">0.0931</td>
</tr>
<tr class="even">
<td style="text-align: right;">120</td>
<td style="text-align: left;">7.14%</td>
<td style="text-align: right;">6.906891</td>
<td style="text-align: left;">0.0995</td>
</tr>
</tbody>
</table>

<table>
<caption>Tabela 4: Valores com log na base 10</caption>
<thead>
<tr class="header">
<th style="text-align: right;">Valor</th>
<th style="text-align: left;">Crescimento</th>
<th style="text-align: right;">Log.natural</th>
<th style="text-align: left;">Delta</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">100</td>
<td style="text-align: left;">-</td>
<td style="text-align: right;">2.000000</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: right;">105</td>
<td style="text-align: left;">5%</td>
<td style="text-align: right;">2.021189</td>
<td style="text-align: left;">0.0212</td>
</tr>
<tr class="odd">
<td style="text-align: right;">112</td>
<td style="text-align: left;">6.67%</td>
<td style="text-align: right;">2.049218</td>
<td style="text-align: left;">0.028</td>
</tr>
<tr class="even">
<td style="text-align: right;">120</td>
<td style="text-align: left;">7.14%</td>
<td style="text-align: right;">2.079181</td>
<td style="text-align: left;">0.03</td>
</tr>
</tbody>
</table>

Abaixo, o gráfico de dispersão mostra a correlação entre as duas
variáveis estudadas e a reta de regressão gerada.

<img src="\assets\images\Post_images_and_graphs\2019-11-20-econometria_analise_dos_residuos_files\figure-markdown_strict\unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

1.  Verifique se há autocorrelação serial dos erros. Comente o diagrama
    de dispersão e o correlograma.

R: Primeiro, deve-se criar o modelo de regressão para depois gerar os
erros. O modelo é resumido abaixo:

*l**n**Y*<sub>*t*</sub> = *β*<sub>1</sub> + *β*<sub>2</sub>(*l**n**X*<sub>*t*</sub>) + *U*<sub>*t*</sub>

R² = 64.4% Adjusted R² = 63.3%

Equação:
*l**n**Y*<sub>*t*</sub> = 2.54 + 479.18(*l**n**X*<sub>*t*</sub>) + *U*<sub>*t*</sub>

Abaixo há uma amostra dos resíduos gerados pelo modelo:

    ##   periodo area    valor  residual
    ## 1       1   29 0.075258 -9.602554
    ## 2       2   71 0.114894 13.404698
    ## 3       3   42 0.101075 -8.973524
    ## 4       4   90 0.110309 34.601735
    ## 5       5   72 0.109562 16.959682
    ## 6       6   57 0.132486 -9.025023

Após gerar os resíduos, pode-se analisar se há autocorrelação. Os
gráficos abaixo mostram se há este comportamento.

<img src="\assets\images\Post_images_and_graphs\2019-11-20-econometria_analise_dos_residuos_files\figure-markdown_strict\unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

<img src="\assets\images\Post_images_and_graphs\2019-11-20-econometria_analise_dos_residuos_files\figure-markdown_strict\unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

Aparentemente não há autocorrelação entre os resíduos. Porém, para
garantir, é interessante usar testes estatísticos formais, como o Durbin
Watson ou Godfrey.

1.  Aplique o teste de Durbin Watson, escrevendo as hipóteses e testando
    a autocorrelação. Use um nível de significância de 5%.

R: Abaixo há a aplicação do teste DW.

    ## 
    ##  Durbin-Watson test
    ## 
    ## data:  lr
    ## DW = 1.4745, p-value = 0.04089
    ## alternative hypothesis: true autocorrelation is greater than 0

De maneira resumida, o valor-p foi de 0.04089 e o valor d, 1.91822.
Neste teste, usa-se o valor d para gerar a conclusão do teste. Antes, é
preciso trazer os intervalos para comparação deste valor d. Para
encontrar o intervalor, use a
[tablea](http://www.portalaction.com.br/analise-de-regressao/33-diagnostico-de-independencia)
específica do teste.

De acordo com a tabela, sabendo a quantidade de registros (n = 33), a
significância (0.05) e o nível de liberdade (degrees of freedom = 1) que
é o número de variáveis independentes, pode-se achar os valores **dl** e
**du**. Para este exercício tem-se:

**dl** = 1.35

**du** = 1.49

Sabendo que dw = 1.47 e os critérios do teste, chega-se a uma
inconclusão. O teste não consegue concluir se há autocorrelação serial
dos resíduos com defasagem de um período (t). Na zona de indecisão não
se pode nem aceitar ou rejeitar H0.

1.  Aplique o teste Breusch Godfrey (a.k.a teste LM) escrevendo as
    hipóteses. Teste a autocorrelação com nível de significância de 5% e
    escreva a conclusão.

2.  Aplique o teste Q e comente os resultados.
