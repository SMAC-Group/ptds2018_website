+++
title = "R Coding Style Guide"
date =  2018-09-03T12:06:38+02:00
weight = 5
+++

> Good coding style is like using correct punctuation. You can manage without
> it, but it sure makes things easier to read. 
> <cite> Hadley Wickham </cite>

### Introduction

The size of the project increases exponentially. A project started as a harmless code snippet can easily pile up into a huge snowball of over hundred files with unstructured folder tree. 

You might think that it is a yet another git / RStudio tutorial.

### Inizializing a new project

Prerequisites:

1. Installed Git
2. Installed R and RStudio


1. Pick a good name. Spending an extra 5 minutes will save you from regrets in the future. The name should not be very long, should not contain special symbols, and should be written in lower-case.

2. In RStudio create a project:

    - File -> New project...
    - Select `New Directory`
    - Select `New project` (unless you developing a package or a ShinyApp)
    - Insert your picked name into `Directory name`
    - Check `Create a git reposetory`
    
   This will create a folder with the name of the project, initialize a local git repository (repo for short), generate an `.Rproj` file, and a `.gitignore` file.
   
3. Add a file structure as disscussed in section, that is folder `data` (with `raw` and `processed` subfolders), `sourse`, `reports`, etc.

4. Create a README.md file.

3. Open `Terminal` and navigate your working directory (of `Terminal`, not `R`) to your project folder by, for istance, `cd /Users/irudnyts/Documents/projects/test`.

3. Record changes by `git add --all` and commit by `git commit -m "First commit."`. Traditionaly the message of the first commit is simple "First commit.". I prefer to write more concious message, like "Create a folder structure of the project.".

    Alternatively, if you do not like `Terminal`, you can do it directly from RStudio. Simply click ... and ... .
    
    Now all you changes are recoreded locally. 

3. Create a new repo in Github (the same procedure holds for Bitbucket and Gitlab). 
    - Repository name
    - Description. DRY Do repeat yourself, copy from README.md
    
4. Connect your local repo to your Github repo by 
    
    ```
    git remote add origin git@github.com:irudnyts/test.git
    git push -u origin master
    ```
    
    Refresh the page at your browser to ensure that changes appear at Github repo. 