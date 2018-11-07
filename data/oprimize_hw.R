# How do I optimize?
#-------------------------------------------------------------------------------
?optim

d <- c(453.2136, 288.8427, 418.3106)

s1 <- c(-300, 300)
s2 <- c(300, 300)
s3 <- c(0, -300)

# Caution: the max width of lines is violated for pedagogical reasons. Please
# do NOT violate this rule in your homework.

objective <- function(theta) {
    ((s1[1] - theta[1]) ^ 2 + (s1[2] - theta[2]) ^ 2 - (d[1] - theta[3]) ^ 2) ^ 2 + 
        ((s2[1] - theta[1]) ^ 2 + (s2[2] - theta[2]) ^ 2 - (d[2] - theta[3]) ^ 2) ^ 2 + 
        ((s3[1] - theta[1]) ^ 2 + (s3[2] - theta[2]) ^ 2 - (d[3] - theta[3]) ^ 2) ^ 2
}

objective(c(0, 0, 0))

my_position <- optim(par = c(0, 0, 0), fn = objective)
my_position
my_position$par

# How do I dispatch generics (a trick of having custom plot and print)?
#-------------------------------------------------------------------------------

get_position <- function(d) {
    
    # Optimize
    # rval <- optim(...)[["par"]]
    rval <- c(1, 1, 1)
    
    # Return
    class(rval) <- "position"
    return(rval)
    
}

plot.position <- function(x) {
    print("This message is returned only if x is of a class position.")
}

summary.position <- function(x) {
    print("This message is returned only if x is of a class position.")
}


my_position <- get_position()
plot(my_position)
summary(my_position)

# Bonus
#-------------------------------------------------------------------------------
# Use S3 system to dispatch get_position
# See for details: http://adv-r.had.co.nz/OO-essentials.html (S3 part)