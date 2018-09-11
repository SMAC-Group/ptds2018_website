+++
title = "Project-oriented workflow"
date =  2018-09-03T11:19:38+02:00
weight = 10
+++

> It’s like agreeing that we will all drive on the left or the right. A hallmark of civilization is following conventions that constrain your behavior a little, in the name of public safety.
> <cite> Jenny Bryan </cite>

### Introduction

In this tutorial we will learn key aspects of making a research project:

- reproducible
- portable 
- self-contained

In data science context, reproducibility means that the whole analysis can be recreated (or repeated) from the fresh start and raw data and get exactly the same results. It means, for instance, that if the analysis involves generating random numbers, then one has to set a seed (an initial state of a random generator) to obtain the same random split each time. Ideally, everyone should have an access to data and software to replicate analysis. It is not always a case, since data can be private, etc. Why this is a big deal? First off, it gives more credibility to the research, because it can be verified and validated by a third party. Further, keeping the flow of analysis reproducable, makes it easier to extend.

Portability means that regardless the operating system or a computer, for minimal given prerequisits, the project would work. For instance, if the project uses a particular package that works only on Windows, then it is not portable. The project is also not considered as portable, if it utilizes a particular computer settings, such as absolute paths instead of relative to your project folder (e.g., when reading the data or saving plots to files). Normally, you should be able to run the code on your colaborator's machine without changing any lines in scripts.

We call a project self-contained, when it has as few external dependencies on external world as possible. It does not mean that you cannot use packages, you can, and you should. However, using the function from the other project that only you have is not a good idea. Also scripts are not suppose to affect anything they did not creat. If you need, for instance, to save a processed data, then it should be saved separately, and not overwrite the raw data. 

There are no clear boundaries between these three properties, they are very close in meaning, and often overlap. As a concequence, techniques and practice we consider further improve all of them, rather than focusing on a particular one.

Even if it might look like a yet another git / RStudio tutorial, this is a list of my recommendations based on my own experince and various posts.

### Project folder structure

The size of the project increases exponentially. A project started as a harmless code snippet can easily pile up into a huge snowball of over hundred files with unstructured folder tree. In contrast to R packges, there is no one particular right folder structure for analysis projects. There are several references at the end of this page, that cover this issue.

```
name_of_project/
|-  data
|   |-  raw
|   |-  processed
|-  figures
|-  reports
|-  results
|-  scripts
|   |-  deprecated
|-  .gitignore
|-  name_of_project.Rproj
|-  README.md
```

- Typicall organization includes... (picture, references)
Some people argue, that this structure is very similar to R pacakge structure, why not then use R package file organization as below? ...

    - not only R, but Bash, Python etc. scripts. 
    - No separation for function definitions and function applications. 
    - no place for .Rmd files. 
    - 

### The content of R files

- No `install.packages()`
- No `rm(list = ls())`
- No `setwd()`, use only relative paths. 
- Always `set.seed()`, if the analysis involves random generation.
- Do not repeat yourself. If the code is repeated more than three times, then wrap it into a function. 


### Inizializing a new project

Disclaimer: the procedure below can be done in different ways. This particular way is no better than the others, but from author opinion has the best  

Prerequisites:

1. Installed Git
2. Installed R and RStudio


1. Pick a good name. Spending an extra 5 minutes will save you from regrets in the future. The name should be short, concise, written in lower-case, and not contain any special symbols.

2. In RStudio create a project:

    - Navigate to File -> New project...
    - Select `New Directory`
    - Select `New project` (unless you are developing a package or a ShinyApp)
    - Insert your picked name into `Directory name`
    - Check `Create a git reposetory`
    
   This will create a folder with the name of the project, initialize a local git repository (repo for short), generate an `.Rproj` file, and a `.gitignore` file.
   
3. Add a file structure as disscussed in section, that is folder `data` (with `raw` and `processed` subfolders), `sourse`, `reports`, etc.

4. Create a README.md file.

5. Open `Terminal` and navigate your working directory (of `Terminal`, not `R`) to your project folder by, for istance, `cd /Users/irudnyts/Documents/projects/test`.

6. Record changes by `git add --all` and commit by `git commit -m "First commit."`. Traditionaly the message of the first commit is simple "First commit.". I prefer to write more concious message, like "Create a folder structure of the project.".

    Alternatively, if you do not like `Terminal`, you can do steps 5 and 6 directly from RStudio. Simply click ... and ... .
    
    Now all you changes are recoreded locally. 

3. Create a new repo in Github (the same procedure holds for Bitbucket and Gitlab). 
    - Repository name
    - Description. DRY Do repeat yourself, copy from README.md
    - For homeworks, the check `Private`
    
4. Connect your local repo to your Github repo by 
    
    ```
    git remote add origin git@github.com:irudnyts/test.git
    git push -u origin master
    ```
    
    Refresh the page at your browser to ensure that changes appear at Github repo. 
    
### Working with an existing repository/package

* Pull changes introduced by your collaborators.
* If you want to delete file, first off, move it to `\depricated`, and then remove it from there during the next iteration.