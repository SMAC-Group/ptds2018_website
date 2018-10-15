+++
title = "Web scraping in R"
date =  2018-09-03T11:21:38+02:00
weight = 20
+++


Disclaimer: the course staff takes no responsibility of misuse of this tutorial. The technique below should be used with a care and NOT FOR EVIL PUROPOSES :smiling_imp:

Imagine: you are invited to your significant one's parents' place for a dinner. You know that her father is a big fan of Swiss wine. Obviously (or maybe not), you want to impress her father. You are not an expert of wine, but you can "show off" with your data science skills and build a story around Chasselas grapes. After an intence googling you realize that the desired dataset simply does not exist, and therefore, you have to collect it by yourself. You find a nice app Vivino, which is a great representative of the recent trends in wine. But how to get the data? Manually copy&pasting the content? And here you remember a nice tutorial you took in your Master...

Very often (if not always) well-structured data you need for analysis does not exist and you need to collect it somehow by yourself. Nowedays, a vast majority of data are user-generated content, presented in unstructured HTML format. But it is not the worst part -- the data typically is dynamic and vary over the time (e.g., the rating of a particular wine or your Facebook friend list). The good thing is that all information is located in Internet in human-readible format, that is you have an accesses to these data. Therefore, the problem is not in accessing the data, but how convert this information into the structured (think of tabular of spreadsheet-like) format. 

In this tutorial you will learn what is the web scraping, how to scrape using R, and when it is legal.

### Web scraping overview

Web scraping is the process of collecting the data from the World Wide Web and transforming it to a structured format. Typically web scraping is refered to an automated procedure, even though formally it includes a manual human scraping. We distringuish several techniques of web scraping: 

- Human manual copy-and-paste
    The name is self-explanatory, that is when humans copy the content of the page and paste into a well-formated data sctructured. This method is very slow, but sometimes is unavoidable as the only solution. For instance, one can copy all prices and names from the Vivino list directly into a data frame.
    
- Text pattern matching
    This approach is the next step in web scraping. After fetching the page, regular expressions (regex) are used to match the pattern in the text. For example, you can get each character that starts with "Price:" and ends with "CHF".
    
- Using API/SDK (socket programming)
    Web APIs are interfaces, introduced by large websites, to allow getting the content of the web-pages (think of databases) directly by posing an HTTP requests. For example, Twitter has its API to search tweets, account activity, etc., so that anyone can get these data by sending an HTTP request. R, however, has a package called [twitteR](http://geoffjentry.hexdump.org/twitteR.pdf), that generates those requests for you (i.e., it can be considered as Software Development Kit, SDK for short).
    
- HTML parsing
    Mostly web pages are generated dynamically from databases using a similar template and css selector. Identifying such css selectors allows mimicing the structure of databases' tables.
    
- etc.

The focus of this tutorial is on the HTML parsing, and at the end of it you should be able to srape data using R. But there is one more thing.

### Denial-of-service (DoS), crawl rate, and robots.txt

Web pages are stored on servers, so that if there will be too many requests per a unit of time, they can became unavailible (i.e., shut down). When the server is not accessible by intended users, it is called denial-of-service (DoS). Often, this issue is exploited for DoS attacks, that is when websites are flooded with trafic (buffer overflow attacks) and stop responding. However, it could happen unintentional (e.g., an introduction of a new exciting website, which was developed to handle only a limited number of users). 

Another concept we need to introduce is a *web crawling*, which has been used extenssively by the search engines, such as Google, Bing, for web indexing. This process is similar to web scraping, but after fetching the content of the web page, crawler extracts only hyperlinks. It means that web crawling also accesses the web page by sending requests. The number of such requests per unit of time is called a crawl rate. Each web crawling requests is the same as a request of a user. Therefore, if your crawler sends too many requests (crawl rate is too high), the server can cause the DoS.

That is exactly what happens to Martijn Koster's server, when Charles Stross's web crawler caused DoS (if rumors are trusted). It triggered Martijn Koster to propose a new standard, a file `robots.txt` that stores a set of rules defining which parts of a website should not be accessed by web crawlers and bots.

The same applies to web scraping, the number of requests should not be too high, and you should access only parts not listed in *robots.txt*.

### Why web scraping could be bad?

Over the years the reputation of the web scraping is decreasing. There are more and more people who ignore and violate not only *robots.txt*, but also Terms of Service (ToS) of websites.

Remember the film "The Social Network"? At the beggning of the movie, the main character scrapes pictures of female students, and then creates a service to measure their attractiveness. This is a good example of unethical use. The topic is very subjective and controversial, therefore, you are at your own responsibility to define what is ethical and what is not (there is no `robots.txt` to define ethics). 
### How to avoid troubles?

Rules are simple: 

1. Read carefully the Terms of Service.

2. Inspect `robots.txt` to identify which parts can be accessed.

3. Do not be too agressive with too frequent requests. If the crawl rate is not mentioned in `robot.txt` (section `crawl-delay:`), than use something meaninful, e.g. one request per 10 second.


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
- [What is a denial-of-serive attack (DoS)?](https://www.paloaltonetworks.com/cyberpedia/what-is-a-denial-of-service-attack-dos)
