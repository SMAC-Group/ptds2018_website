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
- Create and develop an interactive Shiny web-application

To begin with, create a (preferably private) GitHub repository for your group, and name it `ptds2018hw4`. Once again, make sure to add `samorso` and `irudnyts` as collaborators. This project **must** be done using GitHub and respect the following requirements:

- All members of the group must commit at least once.  
- All commit messages must be reasonably clear and meaningful.  
- Your GitHub repository must include at least one issue containing some form of TO DO list.

#### Problem 0: modify `find_pi` from Homework #3

In this problem we simplify the `find_pi` function in order to have two separated functions for simulation and vizualization (plotting) of simulated results. A nicely designed function should do one coherent action at a time. Further, the name of a function should be self-explanatrory, that is a user should be able to guess what function does by its name.

- **(a)** The function `find_pi` should do exactly one action, that is estimate $\pi$. Therefore, we need to introduce the following modifications:

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

- **(b)** Now, we can initialize the function to visualize our simulation. The function should take a returned value of `estimate_pi` as the argument, and produce a plot based on `points` element of such object:

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

- Create a package `ptds2018hw4gN` (where `N` is your group number) in RStudio: File -> New Project... -> New Directory -> R Package. Do not forget to check the box "Create a git repository".

- Record your changes and commit by `git add --all` and `git commit -m "Initialize the structure of the package."`. You can use build-in RStudio toolbar instead of `Shell` commands.

- Everything what we have done so far are local changes on your computer. Now we need to create a new GitHub repo `ptds2018hw4gN` (where `N` is your group number) and synchronize it with your local git repo by:

  ```{toml}
  git remote add origin git@github.com:YOURUSERNAME/ptds2018hw4gN.git
  git push -u origin master
  ```

  where `YOURUSERNAME` is your GitHub username and `N` is the group number.

- Copy the function `estimate_pi()` and `plot.pi()` from the previous problem into file `pi.R` in `\R` folder. Commit.

- Document the function `estimate_pi` and `plot.pi` using `roxygen2` comments. Use `devtools::document()` to generate help files afterwards. Do not forget to specify `@export` in `roxygen2` comments to export functions into NAMESPACE (make it visible outside the package). Commit.

- Fill in the DESCRIPTION file. Commit.

- Clean up the auto-generated file `hello.R` and `hello.Rd`, from `\R` and `\man`, respectively. Commit.

- Remove `NAMESPACE` file, since it was not auto-generated by `roxygen2` (and, therefore, prevents `roxygen2` to overwrite `NAMESPACE`). Then, evoke the command `devtools::document()` to generate it. Commit.

At the end of each step, please, do not forget to commit with a clear message.

Note if you use `ggplot2`, you have to specify it in `DESCRIPTION` file in the section `Imports`. To use the function from `ggplot2`, you have to specify its namespace, that is use `ggplot2::ggplot()` instead of `ggplot()`.

You can also check yourself at this step, if everything works well. You need to `Install and Restart` (in `Build` tab) and try to run `estimate_pi()`, as well as look at the help file by `?estimate_pi`.

#### Problem 2: introduce a high performance computing

This problem shows how to integrate the high performance computing into a package. We utilize `Rcpp` package for this purpose, which makes it straightforward.

- In console run `devtools::use_rcpp()`. This command will add `Rcpp` to `LinkingTo` and `Imports` (in `DESCRIPTION`), create `src\` folder (where `.cpp` files live), and add compiled files into `.gitignore`.

- Create file with the same name of the package (i.e., `ptds2018hw4gN.R`) and include the following lines in it:

  ```{toml}
  #' @useDynLib ptds2018hw4gN
  #' @importFrom Rcpp sourceCpp
  NULL
  ```

- Run `devtools::document()` and commit.

- Create a new file `is_inside.cpp` in `\src` (File -> New File -> C++ File). The file should contain a function `is_inside()` that supplies `NumericMatrix` of two columns, and returns a `LogicalVector`, for which `true` means that the point inside the circle, and `false`, respectively, outside. This function should perform a `for` loop to define whether or not points inside the circle. The file would look then as follows:

  ```{toml}
  #include <Rcpp.h>
  using namespace Rcpp;

  // [[Rcpp::export]]
  LogicalVector is_inside(NumericMatrix points) {

      LogicalVector inside(points.nrow());

      // for loop in which `inside` is defined

      return inside;
  }
  ```

- Document by `devtools::document()` and commit.

- Define a new R function `estimate_pi2()` in `pi.R` that would use `is_inside()` function instead of the native R `for` loop. Commit.

- Document `estimate_pi2()` function in a similar manner as in Problem 1. Commit.

#### Problem 3: Shiny App

Now we compliment the package with a Shiny app, so that a user can have an interactive interface to play around with the functionality of the package. The core functions of the package, `estimate_pi` vs `estiame_pi2`, have two inputs: the argument `seed` and the arguemnt `B` (the number of simulations). We  want to allow the user to choose the values of both, as well as select the function that will produce simulations. The result of the app should be the estimated value of $\pi$, the time spent on simulations, and finally, the plot of points in/out of the circle. Therefore, the interface should have:

- A side bar of the following elements:
  - A select box with two elements, namely, `estimate_pi` and `estiame_pi2`
  - A numeric input of the seed
  - A slider for a number of simulations that goes from `1` to `1000000`

- A main panel of the following elements:
  - A plot
  - A text with the value of estimated $pi$
  - A text with the time of the execution (use function `system.time` to measure)

Below a step-by-step instruction is presented:

- Add `shiny` package in `DESCRIPTION` file into the section `Imports`:

  ```{toml}
  ...
  Imports:
      Rcpp,
      shiny (>= 1.2.0)
  ...
  ```
- Create a folder `inst\shiny-examples` in a package directory (i.e., `inst` folder at top level, and `shiny-examples` inside `inst`).

- Click File -> New File -> Shiny Web App. Call the app as `pi`, select "Application type:" being "Multiple File (ui.R/server.R)", and then navigate "Create within directory:" to newly created `shiny-examples`. Commit.

- Modify `ui.R` according to the mentioned above specification. The file would look like:


  ```{toml}
  library(shiny)

  shinyUI(fluidPage(

      titlePanel("Pi Estimation"),

      sidebarLayout(

          sidebarPanel(

              selectInput("method", ...),

              numericInput("seed", ...),

              sliderInput("B", ...)

          ),

          mainPanel(

            plotOutput("plot"),

            textOutput("time"),

            textOutput("pi")
          )
      )
    ))
  ```

  where `"method"`, `"seed"`, `"B"` are `inputID`'s; and `"plot"`, `"time"`, and `"pi"` are `outputId`'s. Insert your code instead of `...`.

  Hint: see help `?selectInput`, `?numericInput`, and `?sliderInput` to figure out what should replace `...`.

- Modify `server.R`. Here we need to define a reactive expression (`simulate` in the chunk below), which will be executed whenever widgets are changed. This reactive depends on the values from `input` list with `inputID` elements (i.e., `"method"`).

  The `output` defines what will be rendered, therefore, the `server.R` file is as follows:

  ```{toml}
  library(shiny)
  library(ptds2018hw4gN) # REPLACE N BY YOUR GROUP NUMBER AND DELETE THIS COMMENT

  shinyServer(function(input, output) {

      simulate <- reactive({
          # simulate pi and measure the time here
          ...
      })

      output$plot <- renderPlot({
          # plot pi
          ...
      })

      output$time <- renderText({
          # extract the time of the execution
          ...
      })

      output$pi <- renderText({
          # extract the estimated value
          ...
      })

  })
  ```

  Do not forget to change N to the number of your group.

  Commit your changes.

- Add a file `runDemo.R` containing the following snippet:

  ```{toml}
  #' @export
  runDemo <- function() {
      # REPLACE N BY YOUR GROUP NUMBER AND DELETE THIS COMMENT
      appDir <- system.file("shiny-examples", "pi", package = "ptds2018hw4gN")
      if (appDir == "") {
          stop(
              # REPLACE N BY YOUR GROUP NUMBER AND DELETE THIS COMMENT
              "Could not find example directory. Try re-installing ptds2018hw4gN.",
              call. = FALSE
          )
      }

      shiny::runApp(appDir, display.mode = "normal")

  }
  ```

  Do not forget to change N to the number of your group.

  Add documentation to this function using `roxygen2` comments (as in Problem 1) and `devtools::document()`. Commit.

Phew! What a relief! 
