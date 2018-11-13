+++
title = "homework #4"
date =  2018-08-17T16:40:59+02:00
weight = 30
+++

{{% notice warning %}}
**Deadline: 2018-12-03 at 4pm**  
To submit your work, add `samorso` and `irudnyts` as collaborators to your private GitHub repo.  
We will grade only the latest files prior to the deadline. Any ulterior modifications are pointless. 
{{% /notice %}}

The objectives of this homework assignment are the followings:

- Build your own R packages
- Incorporate the high performance computing into a pacakge using `Rcpp` package
- Create and develop an interactive Shiny web-applications

To begin with, create a (preferably private) GitHub repository for your group, and name it `ptds2018hw4`. Once again, make sure to add `samorso` and `irudnyts` as collaborators. This project **must** be done using GitHub and respect the following requirements:

- All members of the group must commit at least once.  
- All commit messages must be reasonably clear and meaningful.  
- Your GitHub repository must include at least one issue containing some form of TO DO list.

#### Problem 1: building an R package

- Create a package `ptds2018hw4`.
- Do not forget select `Package w/ Rcpp` in the final step.
- Clean up the auto-generated file `hello.R` and the content of `man` directory.
- Copy the function `find_pi` from the previous homework into file `pi.R` in `\R` folder.
- Document the function `find_pi` using roxygen2 comments. Use `devtools::document()` to generate help files afterwards.
- Fill in the DESCRIPTION file.

#### Problem 2: high perfomance computing

- Create a new file `is_inside.cpp`
- Define a function `is_inside` in that file:
    * The function should supply a matrix of the dimension `B x 2` and return a logical vector of length `B`, for which `TRUE` means that the point inside the circle, and `FALSE`, respectively, outside.
    * There should be a `for` loop in the function that would define whether or not points are inside the circle.
- Define a new R function `find_pi2` in `pi.R` that would use `is_inside` function instead of the native R `for` loop.
- Document `find_pi2` function appropriately. 

#### Problem 3: Shiny App

First off, you need to modify `find_pi` and `find_pi2` by adding a new arguemnt `return_points`, a logical length one vector, indicating whether or not to return the matrix of points. Note that 

The interface should have the side bar panel and the main panel. 

The side bar panel should have the following elements:
    
- A select box with two elements, namely, `find_pi` and `find_pi2`
- A numeric input of the seed
- A slider for a number of simulations that goes from `1` to `100000000`
- A button `Run`
    
The main panel should have:

- A plot
- A text with the value of estimated $pi$
- A text with the time of the execution    
    
As you can already guess, we want 
