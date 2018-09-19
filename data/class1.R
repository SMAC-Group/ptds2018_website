install.packages("devtools")
devtools::install_github("SMAC-Group/ptds2018")
require(ptds2018)

# basic R commands
# addition of two plus two
2+2
4/2
3 * 2^(0.8)
sqrt(2)
pi

# Generate 100 random Normal variables
?rnorm
rnorm(n = 100)

# Example: Normal test scores of College Entrance Exam 
mu <- 70
sigma <- 15
pnorm(q = 90, mean = mu, sd = sigma, lower.tail = FALSE)

# Summary statistics
x <- rnorm(n = 10000)
mean(x)
median(x)
var(x)
sd(x)
summary(x)
IQR(y)
?IQR

# Factor values
rep("Yellow", 20) # 20 times "Yellow"
c(rep("Yellow", 20), rep("Green", 10), rep("Blue", 50))
?c
y <- as.factor(c(rep("Yellow", 20), rep("Green", 10), rep("Blue", 50)))
table(y)

# Call Iris dataset
data(iris)
iris
summary(iris)
