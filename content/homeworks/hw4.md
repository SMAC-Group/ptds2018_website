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

#### Problem 0: modify `find_pi` from Homework #3

In this problem we simplify the `find_pi` function in order to have two separated functions for simulation and vizualization (plotting) of simulated results. A nicely designed function should do one coherent action at a time. Further, the name of a function should be self-explanatrory, that is a user should be able to guess what function does by its name.

- **a)** The function `find_pi` should do exactly one action, that is estimate $\pi$. Therefore, we need to introduce the following modifications:

    - Rename `find_pi` to `estimate_pi`
    - Remove `make_plot` arguemnt and the code chunk to plot the chart

The function `estimate_pi` should return both the estimated value of $\pi$ and simulated points. The simulated points will be used for plotting afterwards, therefore, it makes sense to store them in a data frame with three columns: `x`, `y`, and a logical column `inside` (`TRUE` if a point inside a circle, and `FALSE` otherwise).

As long as we need to return two objects, we keep them as elements of a list. Also, using S3 methodology, we assign a class `pi` to this list (to dispatch a `plot` method).

Incorporating these modifications, the function will look as follows:

```{toml}
estimate_pi <- function(B = 5000, seed = 10) {

    # set a seed
    set.seed(seed)

    # simulate B points
    points <- data.frame(
        x = runif(n = B, min = -1, max = 1),
        y = runif(n = B, min = -1, max = 1),
        inside = rep(NA, B)
    )

    # your loop goes here
    # ...

    # create a new list
    rval <- list(
        estimated_pi = estimated_pi,
        points = points
    )

    # assign pi class to rval
    class(rval) <- "pi"

    # return rval
    return(rval)

}
```

- **b)** Now, we can initialize the function to visualize our simulation. The function should take a returned value of `estimate_pi` as the argument, and produce a plot based on `points` element of such object:

```{toml}
plot.pi <- function(x) {

    points <- x[["points"]]

    # plot points

}
```

Note that this function returns nothing, but plots a chart. To call this function you can simply use `plot(x)`, where `x` is a result of the function `estimate_pi`.

- **bonus**

Validate arguments in each function, for instance, make sure that `B` and `seed` are positive and integer numbers, etc.

#### Problem 1: build an R package

In this problem, we simply wrap these function into a shape of a package.

- Create a package `ptds2018hw4gN` (where `N` is your group number) in RStudio: File -> New Project... -> New Directory -> R Package. Do not forget to select "Package w/ Rcpp" in "Type" and check the box "Create a git repository".

- Record your changes and commit by `git add --all` and `git commit -m "Initialize the structure of the package."`. You can use build-in RStudio toolbar instead of `Shell` commands.

- Everything what we have done so far are local changes on your computer. Now we need to create a new GitHub repo `ptds2018hw4gN` (where `N` is your group number) and synchronize it with your local git repo by:

```{toml}
git remote add origin git@github.com:YOURUSERNAME/ptds2018hw4g0.git
git push -u origin master
```

- Copy the function `estimate_pi()` and `plot.pi()` from the previous problem into file `pi.R` in `\R` folder. Commit.

- Document the function `estimate_pi` and `plot.pi` using roxygen2 comments. Use `devtools::document()` to generate help files afterwards. Do not forget to specify `@export` in roxygen2 comments to export functons into NAMESPACE (make it visible outside the package). Commit.

- Fill in the DESCRIPTION file. Commit.

- Clean up the auto-generated file `hello.R`, `rcpp_hello.cpp`, `hello.Rd`, `rcpp_hello.Rd` from `R`, `src`, and `man` directories. Commit.

At the end of each step, please, do not forget to commit with a clear message.

Note if you use `ggplot2`, you have to specify it in DESCRIPTION file in the section `Imports`. To use the function from `ggplot2`, you have to write `ggplot2::ggplot()` instead of `ggplot()`.

#### Problem 2: introduce a high perfomance computing

- Create a new file `is_inside.cpp`
- Define a function `is_inside` in that file:
<<<<<<< HEAD
    * The function should supply a matrix of the dimension `B x 2` and return a logical vector of length `B`, for which `TRUE` means that the point inside the circle, and `FALSE`, respectively, outside.
    * There should be a `for` loop in the function that would define whether or not points are inside the circle.
- Define a new R function `find_pi2` in `pi.R` that would use `is_inside` function instead of the native R `for` loop.
- Document `find_pi2` function appropriately. 
=======
    * The function should supply a matrix of the dimension `B x 2` and return a logical vector of length `B`, for which `TRUE` means that the point inside the circle, and `FLASE`, respectively, outside.
    * There should be a `for` loop in that function that would define whether or not points inside the circle.
- Define a new R function `estimate_pi2` in `pi.R` that would use `is_inside` function instead of the native R `for` loop.
- Document `estimate_pi2` function in a similar manner as in Problem 1.
>>>>>>> 0a65aec2fc3c1c53df1ccfcd7a86875ff55995be

#### Problem 3: Shiny App

The interface should have the side bar panel and the main panel.

The side bar panel should have the following elements:

- A select box with two elements, namely, `find_pi` and `find_pi2`
- A numeric input of the seed
- A slider for a number of simulations that goes from `1` to `100000000`
- A button `Run`

The main panel should have:

- A plot
- A text with the value of estimated $pi$
- A text with the time of the execution (use function `system.time` to measure)
