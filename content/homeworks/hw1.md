+++
title = "homework #1"
date =  2018-08-17T16:40:54+02:00
weight = 15
+++

{{% notice warning %}}
**Deadline: 2018-10-15 at 4pm**  
To submit your work, add `samorso` and `TBD` as collaborators to your private GitHub repo.  
We will grade only the latest files prior to the deadline. Any ulterior modifications are pointless. 
{{% /notice %}}

The objectives of this homework assignment are the followings:

- Build your own RMarkdown document.  
- Master different aspects of RMarkdown syntax.  
- Become familiar with GitHub as a collaborative tool.

To begin with, create a (preferably private) GitHub repository for your group, and name it `ptds2018hw1`. Once again, make sure to add `samorso` and `TBD` as collaborators. This project **must** be done using GitHub and respect the following requirements:

- All members of the group must commit at least once.  
- All commit messages must be reasonably clear and meaningful.  
- Your GitHub repository must include at least one issue containing some form of TO DO list.  

In your repository, create a RMarkdown file called `hw1.Rmd` providing an HTML output with the theme `cerulean` and syntax highlighting `tango`. This file should contain the following elements:

+ A "title" section which should at least include:  
  - A title (e.g. Homework 1)  
  - The authors  
  - The date (think of using `Sys.time()`)  
+ A section called "Introduction" where you provide a short summary of the structure of your homework. Moreover, record a short video to introduce your group and include it in your RMarkdown document.  
+ A section called "Group Members". This section should have one sub-section for each group member in your team. For example, a group with three members should have three sub-sections. Each of these sub-sections (named after each group member) should include small biographies containing at least the following elements:
  - A picture of your choice (preferably of yourself). Make sure to include a caption for this image.  
  - A paragraph describing your favorite hobby as well as one interesting fact about yourself (preferably true).  
  - Your favorite quote in blockquote format. Make sure to reference your quote using BibTex.  
  - A table having two columns (first column containing the classes you are following this semester; second column containing the time of these classes).  
+ A section called "RMarkdown Syntax", where you will demonstrate your RMarkdown skills! In this section make sure to:
  - Show an example where the chunk option `cache = T` leads to a misleading answer. This example must be different from the one presented in the textbook.  
  - Simulate 100 random samples from a standard normal distribution using the function `rnorm()`. Store these 100 values in a vector called `x`. Then, compute the empirical median, mean and variance of `x`. Are these results different from 0, 0 and 1 (their respective theoretical values)? Is this result surprising? Justify your answer.  
  - Include a graph showing the histogram of `x` (make sure to include a caption to this figure). You can use the R function `hist()` or the `ggplot2` function.  
  - Include the following equation: ![eq](/homeworks/eq_hw1.png)
  - Include the following in-line equation: <img src="/homeworks/eq2_hw1.png" alt="eq2" width="200px"/>  
  - Include the following text in blue: "Vérité dans un temps, erreur dans un autre.", Charles de Montesquieu  
  - Include a "More info" button with hide/unhide functionality.  
  - Include a "color box"" with some text.  
+ A "References" section that contains all the references used in your document. 