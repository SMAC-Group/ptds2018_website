# Load packages
#-------------------------------------------------------------------------------

library("xml2")
library("rvest")
library("magrittr")

# Get a sequence of pages
#-------------------------------------------------------------------------------

# initialize url of the Comparis (initial) page of items
url_path <- paste0(
  "https://en.comparis.ch/immobilien/result/list?requestobject={%22DealType%22",
  ":%2210%22,%22SiteId%22:%220%22,%22RootPropertyTypes%22:[],%22PropertyTypes%",
  "22:[],%22RoomsFrom%22:null,%22RoomsTo%22:null,%22FloorSearchType%22:%220%22",
  ",%22LivingSpaceFrom%22:null,%22LivingSpaceTo%22:null,%22PriceFrom%22:null,%",
  "22PriceTo%22:null,%22ComparisPointsMin%22:%220%22,%22AdAgeMax%22:%227%22,%2",
  "2AdAgeInHoursMax%22:null,%22Keyword%22:%22%22,%22WithImagesOnly%22:false,%2",
  "2WithPointsOnly%22:null,%22Radius%22:null,%22MinAvailableDate%22:null,%22Mi",
  "nChangeDate%22:%221753-01-01T00:00:00%22,%22LocationSearchString%22:%22Laus",
  "anne%22,%22Sort%22:%2211%22,%22HasBalcony%22:false,%22HasTerrace%22:false,%",
  "22HasFireplace%22:false,%22HasDishwasher%22:false,%22HasWashingMachine%22:f",
  "alse,%22HasLift%22:false,%22HasParking%22:false,%22PetsAllowed%22:false,%22",
  "MinergieCertified%22:false,%22WheelchairAccessible%22:false,%22LowerLeftLat",
  "itude%22:null,%22LowerLeftLongitude%22:null,%22UpperRightLatitude%22:null,%",
  "22UpperRightLongitude%22:null}&sort=11&page=1"
)

# fetch & parse, extract nodes, extract text from nodes, corece to numeric,
# take a maximum, subtract 1 (pages start from zero), and generate a sequence
pages <- read_html(x = url_path) %>%
  html_nodes(css = "#resultlist_paging a") %>%
  html_text() %>%
  as.numeric() %>%
  max(na.rm = TRUE) %>%
  subtract(e2 = 1) %>%
  seq(from = 0)

# Get prices from EACH page
#-------------------------------------------------------------------------------

# define container for prices
prices <- list()

for(page in pages) {

  # define url for a current page
  url_path_page <- paste0(
    "https://en.comparis.ch/immobilien/result/list?requestobject={%22DealType%",
    "22:%2210%22,%22SiteId%22:%220%22,%22RootPropertyTypes%22:[],%22PropertyTy",
    "pes%22:[],%22RoomsFrom%22:null,%22RoomsTo%22:null,%22FloorSearchType%22:%",
    "220%22,%22LivingSpaceFrom%22:null,%22LivingSpaceTo%22:null,%22PriceFrom%2",
    "2:null,%22PriceTo%22:null,%22ComparisPointsMin%22:%220%22,%22AdAgeMax%22:",
    "%227%22,%22AdAgeInHoursMax%22:null,%22Keyword%22:%22%22,%22WithImagesOnly",
    "%22:false,%22WithPointsOnly%22:null,%22Radius%22:null,%22MinAvailableDate",
    "%22:null,%22MinChangeDate%22:%221753-01-01T00:00:00%22,%22LocationSearchS",
    "tring%22:%22Lausanne%22,%22Sort%22:%2211%22,%22HasBalcony%22:false,%22Has",
    "Terrace%22:false,%22HasFireplace%22:false,%22HasDishwasher%22:false,%22Ha",
    "sWashingMachine%22:false,%22HasLift%22:false,%22HasParking%22:false,%22Pe",
    "tsAllowed%22:false,%22MinergieCertified%22:false,%22WheelchairAccessible%",
    "22:false,%22LowerLeftLatitude%22:null,%22LowerLeftLongitude%22:null,%22Up",
    "perRightLatitude%22:null,%22UpperRightLongitude%22:null}&sort=11&page=",
    page
  )

  # write prices to `page - 1`-th element of `prices`
  prices[[page + 1]] <- read_html(url_path_page) %>%
    html_nodes("#result_list_ajax_container strong") %>% # ".item-price strong"
    html_text() %>%
    substring(first = 5) %>%
    gsub(pattern = ",", replacement = "") %>%
    as.numeric()
}

# unlist and take a sum
prices %>% unlist() %>% sum(na.rm = TRUE)
