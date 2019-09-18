---
author: Mara Averick
date: '2019-09-17'
title: Box Office Mojo
output:
  html_document:
    keep_md: true
---




```r
library(tidyverse)
```


```r
boxofficemojo_data <- read_csv(here::here("data", "boxofficemojo_data.csv"), 
    col_types = cols(Weekend = col_date(format = "%Y-%m-%d")))
```

