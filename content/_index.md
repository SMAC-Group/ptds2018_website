+++
title = "Programming tools in data science"
+++

# Programming tools in data science

The objective of the website is to provide a support for *Programming tools in data science* given at the Faculty of Business and Economics (HEC Lausanne) of the University of Lausanne in Fall 2018. This course is intended to provide an introduction to programming using the R language. It will also provide students with notions of data management, manipulation and analysis as well as of reproducible research, result-sharing and version control (using GitHub). At the end of the class, student should be able to construct their own R package, make it available on GitHub, document it using literate programming and render it visible by making a website.

This class is based on the textbook: "An Introduction to Statistical Programming Methods with R" , which is available here: <http://r.smac-group.com>. This document is **under development** and it is therefore preferable to always access the text online to be sure you are using the most up-to-date version.

This class uses the `stat297` R package (and its dependencies). To install this package you can run the following commands in R. **Make sure to continuously update package every week, for we are adding new functions and instructions every day.**

```toml
# Install dependencies
install.packages(c("devtools","knitr","rmarkdown"))

# Install/Update the package from GitHub
devtools::install_github("SMAC-Group/stat297")

# Another way to update the package
library(stat297)
update_stat297()
```