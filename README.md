---
author: Mara Averick
date: '2019-09-17'
title: Pivot to Video
output:
  html_document:
    keep_md: true
---



📺 OK, not _really_! 

This is actually about `tidyr::pivot_*()` functions, which you can learn all
about in the new tidyr version 1.0.0 [Pivoting
vignette](https://tidyr.tidyverse.org/articles/pivot.html)! 

But, I *will* be using some nifty TV- / movie-related data. So, I'm sticking
with the name.


```r
library(tidyverse)
```


## 🍔 Bob's Burgers: A Belcher Family survey


```r
sheet <- googlesheets::gs_title("bobs_burgers_survey_results")

bobs_ws <- googlesheets::gs_ws_ls(sheet)
```


```r
raw_dat <- sheet %>% 
  googlesheets::gs_read(ws = glue::glue("{bobs_ws}"))
```

```
## Accessing worksheet titled 'Form Responses 1'.
```

```
## Parsed with column specification:
## cols(
##   Timestamp = col_character(),
##   `Members of the Belcher family with whom I identify (select all that apply)` = col_character()
## )
```



```r
results <- tibble::rowid_to_column(raw_dat, "resp_id") %>%
  dplyr::rename("response" = `Members of the Belcher family with whom I identify (select all that apply)`) %>%
  dplyr::select(-Timestamp)
```

Because I used a [Google Form](https://docs.google.com/forms/d/e/1FAIpQLScYLAkzDzEOWvXrn601Vt79S6DsKLkv12NUsqbo72j1fmapWA/viewform) to collect this data, I don't have to worry about
order of names, since they come out the same every time.


```r
agg_results <- results %>%
  dplyr::group_by(response) %>%
  dplyr::summarise(total = n()) %>%
  dplyr::arrange(desc(total))

agg_results
```

```
## # A tibble: 30 x 2
##    response                       total
##    <chr>                          <int>
##  1 Bob                               49
##  2 Tina                              29
##  3 Louise                            23
##  4 Bob, Tina                         22
##  5 Bob, Tina, Louise                 17
##  6 Bob, Louise                       16
##  7 Tina, Louise                      12
##  8 Bob, Linda, Tina, Gene, Louise    11
##  9 Bob, Tina, Gene                   10
## 10 Bob, Gene                          8
## # … with 20 more rows
```

Let's make them long with
[`tidyr::separate_rows()`](https://tidyr.tidyverse.org/dev/reference/separate_rows.html).
I'm also adding a numeric variable, `identify` (short for "character(s) with
whom I identify"), and ensuring that respondent IDs don't get erroneously
treated as numeric, by converting them to characters.


```r
results <- results %>%
  tidyr::separate_rows(response) %>%
  dplyr::mutate(identify = 1,
                resp_id = as.character(resp_id))

head(results)
```

```
## # A tibble: 6 x 3
##   resp_id response identify
##   <chr>   <chr>       <dbl>
## 1 1       Linda           1
## 2 1       Tina            1
## 3 1       Louise          1
## 4 2       Bob             1
## 5 2       Gene            1
## 6 3       Bob             1
```


Now we'll take one of the "new" tidyr verbs for a spin, [`pivot_wider()`](https://tidyr.tidyverse.org/dev/reference/pivot_wider.html). 
Rather than fill things out with a bunch of `NA`s, we'll prepare our data 
to use with the `UpSetR` package by turning it into binaries, and ditch the 
respondent ID in the end.

I *highly* recommend Paul Campbell's
[code-through](https://www.cultureofinsight.com/blog/2018/01/25/2018-01-25-visualising-twitter-follower-overlap/)
using UpSetR, which gave me (among other things) the pro tip that `upset()` does
*not* like tibbles (hence the `as.data.frame()` at the end).


```r
binary_tib <- results %>%
  tidyr::pivot_wider(
    names_from = response,
    values_from = identify,
    values_fill = list(identify = 0)
  ) %>%
  dplyr::select(-resp_id)

binary_df <- as.data.frame(binary_tib)
```


```r
UpSetR::upset(binary_df, nsets = 5, order.by = "freq")
```

<img src="fig/basic-upset-1.png" width="1008" />






