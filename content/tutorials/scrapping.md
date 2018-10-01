+++
title = "Web-scrapping in R"
date =  2018-09-03T11:21:38+02:00
weight = 20
+++


Disclaimer: the course staff takes no responsibility of misuse of this tutorial. The technique below should use with a care and NOT FOR EVIL PUROPOSES :smiling_imp:

Imagine: you are invited to your significant one's parents for a dinner. You know that his father is a big fan of Swiss wine. Obviously (or maybe not), you want to impress his father. Reading all these big wine enceclopidia would not be too lame, and you decide to show off with your data science skills and build a story around Chasselas grapes. After an intence googling you realize that the desired dataset simply does not exist, and therefore, you have to collect it by yourself. You find a nice app Vivino, which is a great representative of the recent trends in wine. But how to get the data? Manually copy&pasting the content? And here you remember a nice tutorial you took in your Master...

Very often (if not always) data you need for analysis does not exist and you need to collect it by yourself. A vast majority of data we are interested in is user-generated content (heard of Web 2.0?). Moreover, the data could vary over the time (e.g., the rating of a particular wine). But all this information is located in Internet in human-readible format, that is you have an accesses to these data.

Therefore, the problem is not in accessing but how convert this info into the structured format (think of tabular of spreadsheet-like). 


A vast majority of data in web presented in unstructured format (HTML tags). If you are  

Indeed, in real life it is very likely that the dataset you need either does not exist or have not yet been collected. Further, some datasets are changing over the time, and you want to get a snapshot with some frequency. 


Very ofter (if not always) the data is changing (think of your FB friend's list), and you might want to get the data over the time in order to look at dynamic trends. 


To compliment your cooking masterpiece you need to pick a bottle of a good white wine, prefferebly Chasselas. 

Imagine your boss asks you to analize the market of Chasselas grapes wine. It is very likely that a desired dataset does not exist, and therefore, you have to create it by yourself. You, a big fan of wine, use 

Often (if not always) the data you need for your analysis has not yet been collcted. 



The data is not always 

is not availible or hard to collect

Very often data you need for your analysis does not exist in a nice (tabular or spreadsheet-like) format. 

In this tutorial you will learn: 

### robots.txt



### Legal issues

### Selectorgadget

### Workflow 

0. Make sure that scraping is legal and ethical for a given web-page. You can inspect a particular subdomain (path) using `path_allower` from `robotstxt`:

    ```{toml}
    library("robotstxt")
    
    paths_allowed(
        path = "/en/real-estate/rent/city-basel",
        domain = "https://www.immoscout24.ch/"
    )
    ```
    
    or manually go through `robots.txt` of the domain (a function `get_robotstxt()`):
    
    ```{toml}
    get_robotstxt(domain = "https://www.immoscout24.ch/")
    ```
    
    Sometimes R could fail loading this file, and it is a good idea to double check yourself by opening the link to `robots.txt` at your browser (e.g., [https://www.comparis.ch/robots.txt](https://www.comparis.ch/robots.txt)).
    
1. Load (fetch) and parse the HTML file by using function `read_html()` from `xml2` package:

    ```{toml}
    library("xml2")
    
    real_estate <- read_html(
        "https://www.immoscout24.ch/en/real-estate/rent/city-basel"
    )
    ```

2. Using [selectorgadget](https://selectorgadget.com) define a css element of interest. 

    Selectorgadget is a tool in your browser (JavaScript bookmarklet) that uses the idea of backengeneering to determine which css object contains the data you want to extract. Selectorgadget is like a kind librerian who tells you in which section to look for a particular book.

    First off, we need to install it. Depending on your browser you can install a Google Chrome [extenssion](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb) or drag the link from [https://selectorgadget.com page](https://selectorgadget.com) to Bookmarks (shown in picture below).
    
    <img src="/tutorials/sg_install.png" alt="map" width="400px"/> 
    
    Once it is installed, in your browser (1) navigate to the desired page, (2) click on selectorgadget in your Bookmarks, (3) click on the element you want to select, (4) copy the css selector from the text box (see [`vignette("")`](https://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html) for details or watch the video at this [page](https://selectorgadget.com)).
    
    <img src="/tutorials/sg_use1.png" alt="map" width="400px"/> 
    
    <img src="/tutorials/sg_use2.png" alt="map" width="400px"/> 
    
3. Extract data from from the web-page by using `html_nodes()` and `html_text()` from `rvest`:

    ```{toml}
    library("rvest")
    library("magrittr")
    real_estate %>% 
        html_nodes(".feHEZp") %>%
        html_text()
    ```


### References: 

- [Web Scraping and Crawling Are Perfectly Legal, Right?](https://benbernardblog.com/web-scraping-and-crawling-are-perfectly-legal-right/)
- [Six Compelling Facts about Legality of Web Scraping](http://www.prowebscraper.com/blog/six-compelling-facts-about-legality-of-web-scraping/)
- [Scraping Responsibly with R](https://www.r-bloggers.com/scraping-responsibly-with-r/)
- [SelectorGadget](https://selectorgadget.com)
-[Selectorgadget tutorial by Hadley Wickham](https://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html)
- [rvest: easy web scraping with R](https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/)
- [Beginner’s Guide on Web Scraping in R (using rvest) with hands-on example](https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/)
- [Using rvest to scrape data from Wikipedia](http://categitau.com/using-rvest-to-scrape-data-from-wikipedia/)
- [How to prevent getting blacklisted while scraping](https://www.scrapehero.com/how-to-prevent-getting-blacklisted-while-scraping/)
- [Web Scraping in R: rvest Tutorial](https://www.datacamp.com/community/tutorials/r-web-scraping-rvest)
- [Web scraping tutorial in R](https://towardsdatascience.com/web-scraping-tutorial-in-r-5e71fd107f32)
- [Learn To Create Your Own Datasets — Web Scraping in R](https://towardsdatascience.com/learn-to-create-your-own-datasets-web-scraping-in-r-f934a31748a5)
