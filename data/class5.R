bet <- "head"

# flip a coin
set.seed(123) # fix the randomness
coin <- rbinom(n = 1, size = 1, prob = 0.5) # generate 0/1
if(coin == 1){
  result <- "head"
}
if(coin == 0){
  result <- "tail"
}
result

coin <- rbinom(n = 1, size = 1, prob = 0.5) # generate 0/1
if(coin == 1){
  result <- "head"
} else {
  result <- "tail"
}

if(bet == result){
  print("You win!")
} else {
  print("Sorry, better lcuk next time.")
}

coin <- rbinom(n = 1, size = 10, prob = 0.5) # generate 0/1
if(coin == 1){
  result <- "head"
} else if (coin == 0){
  result <- "tail"
} else {
  print("Something wrong with the code.")
}




# logical operator
any(TRUE,TRUE,FALSE)
all(TRUE,TRUE,FALSE)

is.double(1)

# If statement
# all doubles positive
x <- -4
if(x < 0){
  x <- -x
}
x

# check if the number is even
x <- 1000
if (x %% 2 == 0){
  print(paste(x,"is an even number"))
} else {
  print(paste(x,"is an odd number"))
}

# switch 
number1 <- 321
number2 <- 23

# operator: + - / * %%

operator <- "/"

operator <- readline(prompt="Please enter any ARITHMETIC OPERATOR: ")

switch(operator,
       "+" = print(paste("Addition of the two numbers is: ", number1 + number2)),
       "-" = print(paste("Substraction of the two numbers is: ", number1 - number2)),
       "/" = print(paste("Division of the two numbers is: ", round(number1 / number2,2))),
       "*" = print(paste("Multiplication of the two numbers is: ", number1 * number2)),
       "%%" = print(paste("Modulo of the two numbers is: ", number1 %% number2))
)

# for loops
for(i in 2:10){
  print(i)
}

for(i in seq(from = 3, to = 4, by = 0.1)){
  print(i)
}


for(x in 1:10){
  if (x %% 2 == 0){
    print(paste(x,"is an even number"))
  } else {
    print(paste(x,"is an odd number"))
  }
}

# print only odd numbers
for(x in 1:10){
  if (x %% 2 == 0){
    next
  } else {
    print(paste(x,"is an odd number"))
  }
}

# while loop
x <- 1
while(x <= 6){
  x <- x - 1
  print(x)
}

#----------------------
# St Petersburg paradox
#----------------------
# one game
fee <- 5
head <- TRUE
bet <- 1
# set.seed(124356)
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
print(paste("The gain of the game is:", bet - fee))


# k games
k <- 1000
gains <- vector(mode = "double", length = k)
fee <- 5
set.seed(123)

for(i in 1:k){
  head <- TRUE
  bet <- 1
  # set.seed(124356+i)
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





#--------------
# random walk
#--------------
# Control seed
set.seed(1992)

# Number of steps
steps <- 10^5

# Direction probability (i.e. all direction are equally likely)
probs <- c(0.25, 0.5, 0.75)

# Initial matrix
step_direction <- matrix(nr=steps+1, nc=2)

# Start random walk
for (i in seq(2, steps+1)){
  # Draw a random number from U(0,1)
  rn <- runif(1)
  
  # Go right if rn \in [0,prob[1])
  if (rn < probs[1]) {step_direction[i,1] = 1}
  
  # Go left if rn \in [probs[1], probs[2])
  if (rn >= probs[1] && rn < probs[2]) {step_direction[i,1] = -1}
  
  # Go forward if rn \in [probs[2], probs[3])
  if (rn >= probs[2] && rn < probs[3]) {step_direction[i,2] = 1}
  
  # Go backward if rn \in [probs[3],1]
  if (rn >= probs[3]) {step_direction[i,2] = -1}
}

# Cumulative steps
position <- data.frame(x = cumsum(step_direction[, 1]), 
                       y = cumsum(step_direction[, 2]))

# Let's make a nice graph...
# Graph parameters
color <- "blue4"
xlab <- "X-position"
ylab <- "Y-position"
pt_pch <- 16
pt.cex <- 2
main <- paste("Simulated 2D RW with", steps, "steps", sep = " ")
hues <- seq(15, 375, length = 3)
pt_col <- hcl(h = hues, l = 65, c = 100)[1:2]
par(mar = c(5.1, 5.1, 1, 2.1))

# Main plot
plot(NA,  xlim = range(position[,1]), 
     ylim = range(range(position[,2])), 
     xlab = xlab, ylab = ylab, xaxt = 'n', 
     yaxt = 'n', bty = "n", ann = FALSE)
win_dim = par("usr")

par(new = TRUE)
plot(NA, xlim = range(position[,1]), ylim = c(win_dim[3], win_dim[4] + 0.09*(win_dim[4] - win_dim[3])),
     xlab = xlab, ylab = ylab, xaxt = 'n', yaxt = 'n', bty = "n")
win_dim = par("usr")

# Add grid
grid(NULL, NULL, lty = 1, col = "grey95")

# Add title
x_vec <- c(win_dim[1], win_dim[2], win_dim[2], win_dim[1])
y_vec <- c(win_dim[4], win_dim[4],
           win_dim[4] - 0.09*(win_dim[4] - win_dim[3]),
           win_dim[4] - 0.09*(win_dim[4] - win_dim[3]))
polygon(x_vec, y_vec, col = "grey95", border = NA)
text(x = mean(c(win_dim[1], win_dim[2])), y = (win_dim[4] - 0.09/2*(win_dim[4] - win_dim[3])), main)

# Add axes and box
lines(x_vec[1:2], rep((win_dim[4] - 0.09*(win_dim[4] - win_dim[3])),2), col = 1)
box()
axis(1, padj = 0.3)
y_axis = axis(2, labels = FALSE, tick = FALSE)
y_axis = y_axis[y_axis < (win_dim[4] - 0.09*(win_dim[4] - win_dim[3]))]
axis(2, padj = -0.2, at = y_axis)

# Add trajectory
lines(position, type = "l", col = color, pch = 16)

# Start and end points
points(c(0,position[steps+1,1]), c(0,position[steps+1,2]), cex = pt.cex, col = pt_col, pch = pt_pch)

# Legend
leg_pos <- c(min(position[,1]), max(position[,2]))
legend(leg_pos[1], leg_pos[2], c("Start","End"), 
       col = pt_col, pch = pt_pch, pt.cex = pt.cex, bty = "n")





