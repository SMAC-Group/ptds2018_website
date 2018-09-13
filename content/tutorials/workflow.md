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

In data science context, reproducibility means that the whole analysis can be recreated (or repeated) from the fresh start and raw data and get exactly the same results. It means, for instance, that if the analysis involves generating random numbers, then one has to set a seed (an initial state of a random generator) to obtain the same random split each time. Ideally, everyone should also have an access to data and software to replicate analysis (it is not always the case, since data can be private). Why this is a big deal? First off, it gives more credibility to the research, because it can be verified and validated by a third party. Further, keeping the flow of analysis reproducable, makes it easier to extend.

Portability means that regardless the operating system or a computer, for minimal given prerequisits, the project would work. For instance, if the project uses a particular package that works only on Windows, then it is not portable. The project is also not considered as portable, if it utilizes a particular computer settings, such as absolute paths instead of relative to your project folder (e.g., when reading the data or saving plots to files). Normally, you should be able to run the code on your colaborator's machine without changing any lines in scripts.

We call a project self-contained, when it has as few external dependencies as possible. It does not mean that you cannot use packages. You can, and you should. However, using the function from the other project that only you have is not a good idea. Also scripts are not suppose to affect anything they did not creat. If you need, for instance, to save a processed data, then it should be saved separately, and not overwrite the raw data. 

There are no clear boundaries between these three properties, they are very close in meaning, and often overlap. As a concequence, techniques and practice we consider further improve all of them, rather than focusing on a particular one.

<img src="/tutorials/standards.png" alt="map" width="400px"/> 

Even if it might look like a yet another git / RStudio tutorial, this is a list of my recommendations based on my own experince and various posts.

### Project folder structure

The size of the project increases exponentially. A project started as a harmless code snippet can easily pile up into a huge snowball of over hundred files with unstructured folder tree. To avoid this, it is important do define the folder structure before stepping into analyses. Depending whether the project is a package or a case study, its skeleton differs significantly.

#### R packages

The folder structure of R packages is a subject to a regulation of community (CRAN and Bioconductor). It is well-defined and can be explored in [R packages book](http://r-pkgs.had.co.nz/package.html).

#### Analysis projects (case study)

In contrast to R packges, there is no a single right folder structure for analysis projects. Below, I present a simple yet extenssible folder structure for data analysis project, based on several references that cover this issue.

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

The parent folder that will contain all project's subfolders should have the same name as your project. Pick a good one. Spending an extra 5 minutes will save you from regrets in the future. The name should be short, concise, written in lower-case, and not contain any special symbols. One can apply similar [strategies](http://r-pkgs.had.co.nz/package.html) as for naming packages.

The folder `data` typically contains two subfolders, namely, `raw` and `processed`. The content of `raw` directory is data files of any kind, such as `.csv`, SAS, Excel, text and database files, etc. The content of this folder is *read only*, so that no sripts should change the original files or create new onces. For this purpose the `processed` directory is used: all processed, cleaned, and tidied datasets are saved here. It is a good practice to save files in R format, rather than in `.csv`, since the former one is a more efficient way of storing data (both in terms of space and time of reading/writing). The preference is given to `.rds` files over `.RData` (see why in Content of R files section). Again, files should have representative names (`merged_calls.rds` vs `dataset_1.rds`). Note that it should be possible to regenerate those datasets from your scripts. In other words, if you remove all files from this folder, it must be possible to restore all of them by executing your scripts that use only the data from `raw`.

The folder `figures` is the place where you may store plots, diagrams and other figures. There is not much to say about it. Common extenssions of such files are `.eps`, `.png`, `.pdf`, etc. Again, file names in the folder should be meaningful (the name `img1.png` does not represent anything).

All reports live in directory with the correspoding name `reports`. These reports can be of any formats, such as LaTeX, Markdown, R Markdown, Jupyter Notebooks, etc. Currently, more and more people prefer rich documents with text and executable code to LaTeX and friends.  

Not all output object of the analysis are data files. For example, you have calibrated and fitted your deep learning network to the data, which took about an hour. Of course, it would be painful to retrain the model each time you run the script, and you want to save this model. Then, it is reasonable to save it in `results` with `.rmd` extenssion.

Perhaps the first by importance folder is `scripts`. There you keep all your R scripts and codes. That is the exact place to use prefix numbers, if files should be run in a particular order ([see previous tutorial](https://ptds2018.netlify.com/tutorials/style/)). If you have files in other scripted languages (e.g., Python), it better to locate them in this folder as well. There is also an important subfolder called `depricated`. Whenever you want to remove one or the other script, it is a good practice to move it to `depricated` at first iteration, and only they delete. The script you want to remove can contain functions or analysis used by other collaborators. Moving it firstly to `depricated` ensures that the file is not used by other collaborators.

There are three important files in the project folder: `.gitignore`, `name_of_project.Rproj`, and `README.md`. The file `.gitignore` lists files that won't be added to Git system: LaTeX or C build artefacts, system files, very large files, or files generated for particlar cases. Further, the `name_of_project.Rproj` contains options and meta-data of the project: encoding, the number of spaces used for intendation, whether or not to restore a workspace with launch, etc. The `README.md` briefly describes all high-level information about the project, like an abstract of a paper.

The proposed folder structure is far from being exhaustive. You might need to introduce other folders, such as `paper` (where `.tex` version of a paper lives), `sources` ( a place for your compiled code here, e.g. C++), `references`, `presentations`, `NEWS.md`, `TODO.md`, etc. At the same time, if one of these folders do not have any files inside, it is better to remove it.

Packages [`ProjectTemplate`](http://projecttemplate.net/architecture.html), [`template`](https://github.com/Pakillo/template), [`templace`](https://github.com/cboettig/template), or forking [manuscriptPackage](https://github.com/jhollist/manuscriptPackage) or that [repo](http://www.statsravingmad.com/measure/sample-r-project-structure/) allow for more or less automated creation the proect structure. 

===========================

- Typicall organization includes... (picture, references)
Some people argue, that this structure is very similar to R pacakge structure, why not then use R package file organization as below? ...

    - not only R, but Bash, Python etc. scripts. 
    - No separation for function definitions and function applications. 
    - no place for .Rmd files. 
    - 

Packages: template


Do not keep an empty folders, unless you are planning to store anything in them, since it could be missleading. 

### Content of R files 

- No `install.packages()`
- No `rm(list = ls())`
- No `setwd()`, use only relative paths. 
- Always `set.seed()`, if the analysis involves random generation.
- Do not repeat yourself. If the code is repeated more than three times, then wrap it into a function. 
- Save files by `saveRDS` than by `save`.
- Do not repeat your self. If the same piece of code, or simply the same logic is repeated, then it is better to wrap it into a function.


### Inizializing a new project

Disclaimer: the procedure below can be done in different ways. This particular way is no better than the others, but from author opinion has the best  

Prerequisites:

1. Installed Git
2. Installed R and RStudio


1. Pick a good name.

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

*** References 
- [R packages](http://r-pkgs.had.co.nz/)
- [Project-oriented workflow](https://www.tidyverse.org/articles/2017/12/workflow-vs-script/)
- [`save()` vs `saveRDS()`](https://yihui.name/en/2017/12/save-vs-saverds/)
- [Jupyter And R Markdown: Notebooks With R](https://www.datacamp.com/community/blog/jupyter-notebook-r#alternatives)