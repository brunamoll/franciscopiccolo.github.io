library(tidyverse)

dados <- tibble(
  tipo = rep(c('normal','reduzido'),each=300),
  materia = rep(c('matematica','ler','escrever'),200),
  nota = c(rnorm(300,90,5),rnorm(300,60,2)))

head(dados)

ggplot(data = dados, aes(x=materia, y=nota, col=materia)) +
  geom_jitter(alpha=0.2) +
  geom_boxplot(fill='transparent', notch = T) +
  facet_wrap(~tipo) +
  theme_minimal()




library(ggplot2)

par(mfrow = c(3,2))
hist(x=rnorm(1000,10,2),main = 'Receita Líquida', xlab = 'teste')
hist(x=rnorm(1000,10,2),main = 'Percentual do Lajir', xlab = 'teste')
hist(x=rnorm(1000,10,2),main = 'DONP', xlab = 'teste')
hist(x=rnorm(1000,10,2),main = 'Capital de Giro', xlab = 'teste')
hist(x=rnorm(1000,10,2),main = 'WACC', xlab = 'teste')


plot(x=seq(40,120,by=2),y=dnorm(seq(40,120,by=2)))

ggplot(data = data.frame(x=seq(40,120,by=2),y=dnorm(seq(40,120,by=2),mean=80,sd=6)), aes(x=x,y=y)) +
  geom_histogram(binwidth = 5, stat = 'identity', color='1',alpha=.4,position='identity') +
  theme_bw() +
  labs(x='receita_liquida', y='probabilidade')
ggplot(data = data.frame(x=seq(40,120,by=2),y=dnorm(seq(40,120,by=2),mean=80,sd=6)), aes(x=x,y=y)) +
  geom_histogram(binwidth = 5, stat = 'identity', color='1',alpha=.4,position='identity') +
  theme_bw() +
  labs(x='receita_liquida', y='probabilidade')


percentual_lajir
donp
capital_giro
wacc

receita_liquida <- data.frame(
  x=seq(40,120,by=2),
  y=dnorm(seq(40,120,by=2),mean=80,sd=7))
ggplot(data = dados_2,aes(x=x,y=y)) +
  geom_histogram(binwidth = 5, stat = 'identity', color='1',alpha=.4,position='identity') +
  theme_bw() +
  labs(x='Valor da empresa', y='Probabilidade')

lajir <- data.frame(
  x=seq(40,120,by=2),
  y=dnorm(seq(40,120,by=2),mean=80,sd=7))
ggplot(data = dados_2,aes(x=x,y=y)) +
  geom_histogram(binwidth = 5, stat = 'identity', color='1',alpha=.4,position='identity') +
  theme_bw() +
  labs(x='Valor da empresa', y='Probabilidade')







