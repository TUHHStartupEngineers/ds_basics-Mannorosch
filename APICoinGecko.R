library(jsonlite)
library(data.table)
library(purrr)
library(dplyr)
library(stringr)

response = fromJSON("https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Ccardano%2Cdogecoin%2Cstellar&vs_currencies=EUR&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true")
Coins <- as.data.frame(response)
Coins
