
# set working directory
setwd('C:/Users/francisco.piccolo/Desktop/teste_r')

files_names <- list.files(pattern='.txt$')

# create an empty list that will serve as a container to receive the incoming files
list.data <-list()

n <- length(files_names)

for (i in 1:n)
{
  list.data[[i]] <- read.table(files_names[i])
}

