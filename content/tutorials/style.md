+++
title = "R Coding Style Guide"
date =  2018-09-03T12:06:38+02:00
weight = 5
+++

> Good coding style is like using correct punctuation. You can manage without
> it, but it sure makes things easier to read. 
> <cite> Hadley Wickham </cite>

### Introduction

A language is a tool that allows human beings to interact and communicate with each other. The clearer we express ourselves, the better an idea is transferred from our mind to the other. The same applies to programming languges: concise, clear and consistent codes are easier to read and/or edit. It is especially important, if you have collaborators, who depend on your code. However, even if you don't, keep in mind that at some point in time, you might come back to your code, for example, to fix an error. And if you did not follow consistently your coding style, reviewing your code can take much longer, than you expected. In this context, taking care of your audience means to make your code as readble as possible.

There is no such thing as a "correct" coding style, as there is no such thing as the best color. At the end of the day, the coding style is a set of developers' preferences. If you are coding alone, sticking to your coding style and being consistent is more than enogh. The story is a bit different if you are working in a team: it is crucial to agree on a convention beforehand and make sure that everyone follows it. 

Even though there is no an official style guide, R is mature and steady enogh to have an "unofficial" convention. In this tutorial, you will learn these "unofficial" rules, their deviations, and most common styles.

### Naming 

#### Naming files 

The convention actually depends on whether you develop a file for a pacakge, or as a part of data analysis process. There are, however, **common rules**:

* File names should use `.R` extenssion.

    ```{toml}
    # Good
    read.R

    # Bad 
    read
    ```

* File names should be meaningful.

    ```{toml}
    # Good 
    model.R
    
    # Bad
    Untitled1.R
    ```

* File names should not contain `/` and spaces. Instead, a dash (`-`) or underscore (`_`) should be used.

    ```{toml}
    # Good 
    fir_regression.R
    fir-regression.R
    
    # Bad
    fit regression.R
    ```

If the file is **a part of the data analysis**, then it makes sense to follow the following recommendations:

* File names should be lowercase. There is nothing bad in having capital case names, just bear in mind UNIX systems are case insenative, meaning that `test.R` and `Test.R` do not differ.

    ```{toml}
    # Good
    analyse.R
    
    # Bad
    Analyse.R
    ```

* Use meaningful verbs for file names.

    ```{toml}
    # Good 
    validate-vbm.R
    
    # Bad
    regression.R
    ```

If the file is used **in a pacakge**, than slightly different rules should be taken care of:

* Mind special names:

    - `AllClasses.R` (or `AllClass.R`), a file that stores all S4 classes definitions.
    - `AllGenerics.R` (or `AllGeneric.R`), a file that stores all S4 generic functions.
    - `zzz.R`, a file that contains `.onLoad()` and friends.
 
* If the file contains only one function, name it with the function name.

* Use `methods-` prefix for S4 class methods.
 


#### Naming variables

* Generally, names should be as short as possible, still meaningful nouns.

    ```{toml}
    # Good 
    fit_rt
    split_1
    imdb_page
    
    # Bad
    fit_regression_tree
    cross_validation_split_one
    foo
    ```

* Variable names should be typically lowercase.

    ```{toml}
    # Good 
    event
    
    # Bad 
    Event
    ```
    
* NEVER separate words within the name by `.` (reserved for an S3 dispatch) or use CamelCase (reserved for S4 classes definitions). Instead, use an underscore (`_`).

    ```{toml}
    # Good 
    event_window
    
    # Bad 
    event.window
    EventWindow
    ```
    
* DO NOT use names of existing function and variables (especially, built-in ones). 

    ```{toml}
    # Bad
    T <- 10 # T is a shortcut of TRUE in R
    c <- "constant"
    ```
    
#### Naming functions 

Many points of naming variables are similar for naming functions:

* Generally, function names should be verbs. 

    ```{toml}
    # Good
    add()
    
    # Bad
    addition()
    ```

* Use `.` ONLY for dispatching S3 generic.

    ```{toml}
    # Good 
    bw_test()
    
    # Bad
    bw.test()
    ```
    
* Add the underscore (`_`) prefix to a standard evaluation (SE) equiualent of a fucntion (`summrize` vs `sumarize_` ).

#### Naming classes

Class names should be nouns in CamelCase with initial capital case letter.


### Syntax 

#### Line length 

The maximum length of lines is limited to 80 characters (thanks to IBM Punch Card).

#### Spacing

* Put spaces around all infix binary operators (`=`, `+`, `*`, `==`, `&&`, `<-`, `%*%`, etc.).

    ```{toml}
    # Good 
    x == y
    a <- a + 1
    
    # Bad
    x==y
    a<-a+1
    ```
    
* Put spaces around "=" in function calls (except for Bioconductor).

    ```{toml}
    # Good 
    mean(x = c(1, NA, 2), na.rm = TRUE)
    
    # Bad
    mean(x=c(1, NA, 2), na.rm=TRUE)
    ```

* DO NOT place space for subsetting (`$` and `@`), namespace manipulation (`::` and `:::`), and for sequence generation (`:`).

    ```{toml}
    # Good 
    car$cyl
    dplyr::select
    1:10
    
    # Bad
    car $cyl
    dplyr:: select
    1: 10
    ```

* Put a space after a coma: 

    ```{toml}
    # Good 
    mtcars[, "cyl"]
    mtcars[1, ]
    mean(x = c(1, NA, 2), na.rm = TRUE)
    
    # Bad
    mtcars[,"cyl"]
    mtcars[1 ,]
    mean(x = c(1, NA, 2),na.rm = TRUE)
    ```
    
* Use a space before left parentheses, except in a function call.


#### 



    
* The required (with no default value) arguments should be first, followed by optional arguemnts.
    
    ```{toml}
    # Good
    raise_to_power(x, power = 2.7)
    
    # Bad
    raise_to_power(power = 2.7, x)
    ```

* The `...` argument shold either be in the beginning, or in the end.

    ```{toml}
    # Good
    standardize(..., scale = TRUE, center = TRUE)
    save_chart(chart, file, width, height, ...)
    
    # Bad
    standardize(scale = TRUE, ..., center = TRUE)
    save_chart(chart, ..., file, width, height)
    ```

* Good practice is to set default arguments inside the function using `NULL` idiom, and avoid dependence between arguments:

```{toml}
# Good
standardize <- function(..., scale = NULL, center = NULL)
```

### Comments 

- Same as commit: not the what, but the why.

### References 

* [Advanced R](http://adv-r.had.co.nz/Style.html)
* [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml)
* [Bioconductor Coding Style](http://bioconductor.org/developers/how-to/coding-style/)
* [Efficient R programming](https://csgillespie.github.io/efficientR/coding-style.html)
* [Colin Gillespie’s R style guide](https://csgillespie.wordpress.com/2010/11/23/r-style-guide/)


http://r-pkgs.had.co.nz/r.html
