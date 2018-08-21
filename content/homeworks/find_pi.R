make_circle = function(center = c(0,0), radius = 1,  nb_step = 300, col = "darkblue", fill = NULL, lty = 1){
  my_points = seq(from = 0, to = 2*pi, length.out = nb_step)
  coords = cbind(radius*cos(my_points) + center[1], radius*sin(my_points) + center[2])
  lines(coords, col = col, lty = lty)
  if (!is.null(fill)){
    polygon(c(coords[,1]), c(coords[,2]), col = fill, border = NULL)
  }
}

make_square = function(bottom_left = c(-1,-1), side = 2, col = "darkblue", fill = NULL){
  lines(c(bottom_left, bottom_left), c(bottom_left + side, bottom_left), col = col)
  lines(c(bottom_left + side, bottom_left), c(bottom_left + side, bottom_left + side), col = col)
  lines(c(bottom_left + side, bottom_left + side), c(bottom_left, bottom_left + side), col = col)
  lines(c(bottom_left, bottom_left + side), c(bottom_left, bottom_left), col = col)
  if (!is.null(fill)){
    polygon(c(bottom_left, bottom_left+side, bottom_left+side, bottom_left), c(bottom_left, bottom_left, bottom_left+side, bottom_left+side), border = NULL, col = fill)
  }
}

inside_unit_circle = function(x){
  # Compute squared distance from center
  d = x[1]^2 + x[2]^2
  (d < 1)
}

find_pi = function(B = 5000, seed = 10, make_plot = FALSE){
  # Control seed
  set.seed(seed)
  
  # Simulate B points
  point = matrix(runif(2*B, -1, 1), B, 2)
  
  # Compute the number of points inside unit circle
  nb_inside = apply(point, 1, inside_unit_circle)
  pi_hat = sum(nb_inside)/B
  
  # Make plot
  if (make_plot){
    plot(NA, xlim = c(-1.1,1.1), ylim = c(-1.1,1.1), xlab = "x", ylab = "y")
    make_square()
    cols = hcl(h = seq(15, 375, length = 3), l = 65, c = 100, alpha = 0.2)[1:2]
    grid()
    for (i in 1:B){
      points(point[i,1], point[i,2], pch = 16, col = cols[1 + nb_inside[i]])
    }
    make_circle()
  }
  
  # return estimated value of pi
  return(4*pi_hat)
}

B <- seq(from = 10^2, to = 10^4, by = 10^2)
pi_hat <- matrix(nr=length(B),nc=1)
for(i in seq_along(B)){
  pi_hat[i] <- find_pi(B = B[i])
}
plot(B,abs(pi_hat-pi),type="b")
abline(h=pi,lty=2)
