f <- function(){
  100
}
f()

f <- function(){
  return(100)
}
f()
f <- function(){
  100
  30
}

f()

f <- function(){
  return(100)
  30
}
f()

my_mean <- function (x) {
  average <- sum(x, na.rm = T)/sum(!is.na(x))
  return(average)
}
data("precip")
precip
my_mean(x = precip)
my_mean(precip)

my_prod <- function (a, b) {
  prod <- a*b
  return(prod)
}
my_prod(10,15)
my_div <- function (a, b) {
  div <- a/b
  return(div)
}

my_div(10,15)
my_div(15,10)

my_div(b = 10, a = 15)
matrix(1,nrow = 2, ncol =3) 
matrix(1,nr = 2, nc =3) 
matrix(1,nc = 3, nr =2) 
matrix(1, nc = 3, nr =2) 

my_mean <- function (x, ...) {
  average <- sum(x, ...)/sum(!is.na(x), ...)
  return(average)
}

precip2 <- precip
precip2[1] <- NA
my_mean(precip2)
my_mean(precip2, na.rm=T)

formals(mean)
mean(precip)


my_mean <- function (x = 1, ...) {
  average <- sum(x, ...)/sum(!is.na(x), ...)
  return(average)
}
my_mean()

set.seed(123)
x <- rnorm(10)
my_mean <- function (...) {
  average <- sum(x, ...)/sum(!is.na(x), ...)
  return(average)
}
my_mean()

# infix functions
1 + 2
"+"(1,2)
"*"(1,2)

"%^%" <- function(a,b){
  prod = a * b
  abs(prod)
}
"%^%"(-1, 10)

-1 %^% 10

# class argument
image <- matrix(rgamma(100, shape = 2), 10, 10)
class(image) <- NULL
class(image) <- "pixel"
plot(image)
plot.default(image)
plot.pixel(image)
plot.pixel <- function(mat) {
  heatmap(mat, Colv=NA, Rowv=NA, 
          labRow=NA, labCol=NA, scale="none")
}
plot(image)
class(image) = "pixel"

var <- function(x) 100
stats::var(precip)
var(precip)
# require(ggplot2)
ggplot2::qplot(precip)

# St Petersburg paradox
# arguments are defined with default values
st_petersburg_game <- function(
  n_games = 10,
  fee = 10,
  seed = 1234,
  plot = FALSE,
  ... # to be passed to histogram
){
  # st Petersburg game
  gains <- vector(mode = "double", length = n_games)
  
  set.seed(seed)
  
  for(i in 1:n_games){
    head <- TRUE
    bet <- 1
    while (head) {
      # toss a coin
      x <- rbinom(n = 1, size = 1, prob = 0.5) 
      
      # verify the coin
      if(x == 0){
        head <- FALSE
      }
      
      # update the bet
      bet <- bet * 2
    }
    # save the result
    gains[i] <- bet - fee
  }
  
  # Plot
  if(plot) hist(gains, ...)
  
  return(gains)
}

# some calls of the function
st_petersburg_game()
st_petersburg_game(plot=TRUE)
st_petersburg_game(n_games = 100, plot=TRUE)
st_petersburg_game(n_games = 100, plot=TRUE, main = "Gain in St-Petersburg games")
