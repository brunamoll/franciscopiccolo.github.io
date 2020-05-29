# check if package have updates
tidyverse_update()

# loading de packages
library(tidyverse)
library(Lahman)
library(nycflights13)
library(dplyr)
library(hexbin)
library(stringr)
library(forcats)

# use the mpg data.frame contained in ggplot to test visualizations
ggplot(data=mpg)+
  geom_point(aes(x=displ,y=hwy,color=class),size=3.5) +
  xlab(label = 'engine_size') +
  ylab(label = 'fuel_efficiency')

# number of rows and columns of the data.frame
nrow(mpg)
ncol(mpg)

# graph with facet_wrap to split the graph using discrete variables
ggplot(data=mpg) +
  geom_point(aes(x=displ,y=hwy,color=drv))+
  facet_wrap(~class,nrow=3)+
  xlab(label = 'engine_size') +
  ylab(label = 'fuel_efficiency')

# graph with fact_grid to split 
ggplot(data=mpg) +
  geom_point(aes(x=displ,y=hwy,color=class)) +
  facet_grid(drv~cyl) +
  xlab(label = 'engine_size') +
  ylab(label = 'fuel_efficiency')


head(mpg)

?mpg

ggplot(data=mpg)+
  geom_point(aes(x=displ,y=hwy))+
  facet_wrap(~class,nrow=2)

ggplot(data=mpg)+
  geom_point(aes(x=displ,y=hwy,color=class))


ggplot(data=mpg)+
  geom_point(aes(x=displ,y=hwy))

ggplot(data=mpg)+
  geom_smooth(aes(x=displ,y=hwy,linetype=drv))+
  geom_point(aes(x=displ,y=hwy,color=drv))


ggplot(data=mpg)+
  geom_smooth(aes(x=displ,y=hwy,color=drv))+
  theme(legend.text=element_blank(),legend.title = element_blank(),legend.position = 'none')


# two graph with different sytanx but the same result
ggplot(data=mpg)+  ## graph 1, bad idea, because it has duplication of data
  geom_point(aes(x=displ,y=hwy))+
  geom_smooth(aes(x=displ,y=hwy))
ggplot(data=mpg,aes(x=displ,y=hwy))+ ## graph 2
  geom_point()+
  geom_smooth()



# graph with filters
ggplot(data=mpg,aes(x=displ,y=hwy))+
  geom_point(aes(color=class))+
  geom_smooth(data=filter(mpg,class=='subcompact'),se=F)


ggplot(data=mpg,aes(x=displ,y=hwy,color=drv))+
  geom_point()+
  geom_smooth(se=T,level=0.98)


ggplot(data=mpg,aes(x=displ,y=hwy))+
  geom_point(size=3)+
  geom_smooth(aes(displ,y=hwy,group=drv),se=F)

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data=mpg,aes(x=displ,y=hwy))+
  geom_point(aes(color=drv),size=3)+
  geom_smooth()

########## diamonds data_set
head(diamonds)
nrow(diamonds)
ncol(diamonds)  
str(diamonds)
?diamonds

# two ways to create a bar plot
ggplot(data=diamonds)+
  geom_bar(aes(x=cut))
ggplot(data=diamonds)+
  stat_count(aes(x=cut))

## new table for graph testing
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
ggplot(data=demo)+
  geom_bar(aes(x=cut,y=freq),stat='identity')

help(rmarkdown)

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,y=..prop..,group=1))

ggplot(data=diamonds)+
  geom_col(aes(x=cut,y=depth))

?geom_col

# stats summary of the depth col split by cut variable
ggplot(data=diamonds)+
  stat_summary(aes(x=cut,y=depth),
  fun.ymin=min,
  fun.ymax=max,
  fun.y=median)

?stat_summ

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,y=..prop..,group=1))

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,fill=cut))

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,fill=clarity),position='stack')

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,fill=clarity),position='fill')

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,fill=clarity),position='dodge')

ggplot(data=diamonds)+
  geom_bar(aes(x=cut,fill=clarity),position='jitter')


# improve this graph
ggplot(data=mpg,aes(x=cty,y=hwy))+
  geom_point()


ggplot(data=mpg,aes(x=class,y=hwy,col=drv))+
  geom_boxplot(fill='transparent')+
  geom_jitter(alpha=.1)+
  coord_flip() #changes the coordinate of the plot


nz <- map_data('nz')

ggplot(data=nz,aes(x=long,y=lat,group=group))+
  geom_polygon(fill='white',color='black')

###############################################################

## data transformation
head(nycflights13::flights)
View(flights)
ncol(flights)
nrow(flights)

# filtering the data with dplyr
filter(flights,month==1,day==1)
filter(flights,month==1|month==2) ## | means 'or'
filter(flights,!(arr_delay>120|dep_delay>120)) # ! mean not in

# Filter fLights with arrival delay equal or greater than two hours
filter(flights,flights$arr_delay>=120)

# Filter flights that flew to Houston
filter(flights,flights$dest=='HOU'|flights$dest=='IAH')

# Filter flights operated by United, American or Delta
filter(flights,flights$carrier=='US'|flights$carrier=='DL'|flights$carrier=='UA')

# Select distinct rows of a given column
dplyr::distinct(flights,carrier)

# Filter flights that were departed on summer (july, august and september)
filter(flights,flights$month==7|flights$month==8|flights$month==9)

# Filter flights that arrived more thant two hours late but didn't leave late
filter(flights,flights$arr_delay>120&flights$dep_delay<=0)

# Filter flights that were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights,flights$arr_delay>=59&flights$air_time>30)

# Filter flights with missing dep_time and show how many rows it has
nrow(filter(flights,is.na(flights$dep_time)))

## Arrange rows with arrange(), missing values stays at the end

# example, with day variable in descending order
arrange(flights,flights$year,flights$month,desc(flights$day))

# Sort the flights by the air_time
arrange(flights,desc(flights$air_time)) %>% 
  select(year)

# With composed dplyr expression, just inser the data once at the begining
select(flights,air_time) %>% 
  arrange(desc(flights$month))

## Select the data with select(data,variable)

# example ou can't use data$field
select(flights,year,month,day)

select(flights,year:carrier)

# indicating which columns to not select with '-column'
select(flights,-(year:day))

# renaming columns with rename()
select(flights,tailnum)
dplyr::rename(flights,tail_num = tailnum)

# moving a column position with everything()
select(flights,time_hour,everything()) # puts the time_hour column first

# selecting columns base on string value, ignoring case sensitiveness
select(flights,contains('TIME',ignore.case=T))

## Adding new variables with mutate(), it always add columns at the end of the data set

df_flights_sml <- select(flights,
                         year:day,
                         ends_with('delay'),
                         distance,
                         air_time
                         )

# adding calculated columns with mutate
mutate(df_flights_sml,
       gain=dep_delay-arr_delay,
       speed=distance/air_time*60
       )

# adding new columns and bring them into the data.frame, refering to created columns
mutate(df_flights_sml,
       gain=dep_delay-arr_delay,
       hours=air_time/60,
       gain_per_hour=gain/hours  # column created with preceding created columns
       )

# mutate brings the new columns with the old columns, in other words, all the data set.
# in order to brind just the new columns, use transmute()

transmute(flights,
          gain=dep_delay-arr_delay,
          hours=air_time/60,
          gain_per_hour=gain/60
          )

transmute(flights,
       a=air_time-lag(air_time,1),
       b=air_time,
       c=lag(air_time,1)
       )

flights$dep_time

head(flights$dep_time%/%100)
head(flights$dep_time%%100)


# Comparison between air_time and (arr_time-dep_time)
transmute(flights,
          air_time_minutes=air_time%%100,
          arr_time_hour=arr_time%/%100,
          arr_time_minute=arr_time%%100,
          dep_time_hour=dep_time%/%100,
          dep_time_minute=dep_time%%100,
          comparison=(arr_time_hour-dep_time_hour)*60+(arr_time_minute-dep_time_minute),
          month=month,
          day=day,
          flight=flight
          )

transmute(flights,
          dep_time,
          sched_dep_time,
          dep_delay
          )


## Summarizing the data with group_by() and summaris()
summarise(flights
          ,delay = mean(dep_delay,na.rm=T)
          )


# summarise by groups of dates, two ways of doing this
summarise(group_by(flights,year,month,day),
    delay=mean(dep_delay,na.rm=T))

group_by(flights,year,month,day) %>% 
  summarise(delay=mean(dep_delay,na.rm))

# without pipe it's necessary to name each data.frame of the steps (group, summari, filter)
by_dest <- group_by(flights,dest)
delay <- summarise(by_dest,
                   count=n(),
                   dist=mean(distance,na.rm=T),
                   delay=mean(arr_delay,na.rm=T)
                  )
delay <- filter(delay,count>20,dest!='HNL')
ggplot(data=delay,aes(x=dist,y=delay))+
  geom_point(aes(size=count),alpha=0.3)+
  geom_smooth(se=T)

# with pipe there's no need to create data.frame for each step, the code is lean
delay <- group_by(flights,dest) %>% 
  summarise(count=n(),
            dist=mean(distance,na.rm=T),
            delay=mean(arr_delay,na.rm=T)) %>% 
    filter(count>20, dest!='HNL')
ggplot(data=delay,aes(x=dist,y=delay))+
  geom_point(aes(size=count),alpha=.3)+
  geom_smooth(se=T)

# filtering cancelled flights
not_cancelled <- filter(flights,!is.na(dep_delay),!is.na(arr_delay))

not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(mean=mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay=mean(arr_delay))

#average delay
ggplot(data=delays,aes(x=delay))+
  geom_freqpoly(binwidth=10)

# average delay considering number of flights, using pipe with ggplot (don't indicate the data)
not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay=mean(arr_delay,na.rm=T),
            n=n()) %>% 
  filter(n>10) %>% 
  ggplot(aes(x=n,y=delay))+
    geom_point(alpha=.1)

## Using Lahman package to bring baseball data
View(Lahman::Batting)
?Lahman
batting <- as_tibble(Lahman::Batting)

# correlation between skill_batter and opportunities
batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    skill_batter=sum(H,na.rm=T)/sum(AB,na.rm=T),
    opportunities=sum(AB,na.rm=T)
  ) %>% 
  filter(opportunities>100) %>% 
  ggplot(aes(x=opportunities,y=skill_batter))+
  geom_point()+
  geom_smooth(se=T)


# Line histograms (geom_freqpoly())

diamonds %>% 
  filter(carat<3) %>% 
ggplot(aes(x=carat))+
  geom_histogram(binwidth=.01)

# Explore the distribution of each of the x,y and z variables in diamonds
## x = length; y = width; z = depth
head(diamonds)
str(diamonds)

ggplot(data=diamonds)+
  geom_histogram(aes(x=x),binwidth=.01)

ggplot(data=diamonds)+
  geom_boxplot(aes(y=x))

mean(diamonds$x)
sd(diamonds$x)
summary(diamonds$x)

# Gathering x,y and z on the same variable
tidyr::gather(diamonds,'dimension','measure',8:10) %>% 
  ggplot()+
  geom_boxplot(aes(x=dimension,y=measure,fill=dimension))


# Explore the distribution of the price column
ggplot(data=diamonds)+
  geom_histogram(aes(x=price),binwidth = 1)

vol <- diamonds$x*diamonds$y*diamonds$z

df <- data.frame(x=diamonds$price,y=vol)


# Removing outliers from a data.frame
df <- data.frame(x=diamonds$price,y=vol,a=diamonds$carat,cut=diamonds$cut)
outliers_y <- boxplot(df$y)$out #outliers
df_new <- df[-which(df$y %in% outliers_y),]

df_teste <- df[-which(df$y %in% max(df$y)),]
head(df_teste)

ggplot(data=df_teste)+
  geom_point(aes(x=x,y=y,color=a))+
  facet_wrap(~cut)+
  labs(x='price',
       y='volume'
       )

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60)




# box plot for diamond prices

ggplot(data=diamonds)+
  geom_boxplot(aes(x=cut,y=price))+
  coord_flip()

diamonds %>% 
mutate(cut_2=fct_relevel(cut,c('Ideal','Fair','Good','Very Good','Premium'))) %>% 
ggplot()+
  geom_boxplot(aes(x=cut_2,y=price))+
  coord_flip()


# geom_hex to show concentration of points overlaping on the graph
ggplot(data=diamonds)+
  geom_hex(aes(x=x,y=price),color='white')

# bin continuous variable (i.e. carat) to act like categorical ones
ggplot(diamonds)+
  geom_boxplot(aes(x=carat,y=price,group=cut_width(carat,0.1)))


vignette("tibble")



# printing the informed number of rows (10)
nycflights13::flights %>% 
  print(n = 10, width = Inf)


df <- tibble(
  x = runif(5),
  y = rnorm(5)
)


df <- as.tibble(mtcars)
class(df)

?tibble::enframe()


# exploratory data analysis
View(flights)

# Number of flights per carrier
flights %>%
  select(carrier) %>% 
  group_by(carrier) %>% 
  summarise(count=n()) %>% 
  mutate(carrier = fct_reorder(carrier,count)) %>% 
  ggplot(aes(x=carrier,y=reorder(count,count)))+
  geom_col()+
  coord_flip()





## Working with strings


# string length
stringr::str_length(c('francisco', 'r for data science','NA'))

# combining strings
stringr::str_c('francisco','gabriela')

# combining strings with separators
stringr::str_c('francisco','gabriela',sep='  ')


name <- 'francisco'
time_of_day <- 'morning'
birthday <- TRUE

stringr::str_c('Good ',time_of_day,' ',name,if(birthday) ' and happy birthday','.')


# to collapse a vector of stirngs into a single string, use collapse

stringr::str_c(c('x','y','z'),collapse = ', ')



# Subsetting strings
x <- c('apple','banana','pear')

stringr::str_sub(string=x,start=3,end=1)
stringr::str_sub(string=x,start=-3,end=-1) # negative numbers count backwards


# matching patterns
x <- c('apple','banana','pear')

stringr::str_view(x,'^an')

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")


str_view_all("abababa", "aba")

## Factors

### database
forcats::gss_cat

gss_cat %>% 
  count(race)

# graph with the count
gss_cat %>% 
  ggplot(aes(x=race))+
  geom_bar()+
  scale_x_discrete(drop = F) # won't drop na values

# exploring the rincome variable
gss_cat %>% 
  group_by(rincome) %>% 
  summarise(qty = n(),
            age=mean(age,na.rm = T)) %>% 
  ggplot(aes(x=fct_relevel(rincome,'Not applicable'),y=age))+
  geom_point()+
  coord_flip()


# reordering factor variables
gss_cat %>% 
  group_by(relig) %>% 
  summarise(
    age=mean(age,na.rm = T),
    tvhours=mean(tvhours,na.rm = T),
    n=n()
  ) %>% 
  ggplot(aes(x=tvhours,y=fct_reorder(relig,tvhours)))+
  geom_point()


by_age <- 
  gss_cat %>% 
  filter(!is.na(age)) %>% 
  count(age,marital) %>% 
  group_by(age) %>% 
  mutate(prop=n/sum(n))

ggplot(data=by_age,aes(x=age,y=prop,color=marital))+
  geom_line(na.rm = T)

ggplot(data=by_age,aes(x=age,y=prop,color=fct_reorder2(marital,age,prop)))+
         geom_line()+
        labs(color='marital')



gss_cat %>% 
  mutate(marital=marital %>% fct_infreq() %>% fct_rev()) %>% 
  ggplot(aes(x=marital))+
  geom_bar()


# box ploting tvhours to see outliers






## plots with subtitles, caption and titles

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )


## color = car type, name of the legends
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  )


## scale continuous with breaks

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5))



  presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y")











