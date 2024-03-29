---
author: Mara Averick
date: '2019-10-28'
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

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#eayatsssmc .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  background-color: #FFFFFF;
  /* table.background.color */
  width: auto;
  /* table.width */
  border-top-style: solid;
  /* table.border.top.style */
  border-top-width: 2px;
  /* table.border.top.width */
  border-top-color: #A8A8A8;
  /* table.border.top.color */
  border-bottom-style: solid;
  /* table.border.bottom.style */
  border-bottom-width: 2px;
  /* table.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table.border.bottom.color */
}

#eayatsssmc .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#eayatsssmc .gt_title {
  color: #333333;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding - not yet used */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#eayatsssmc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 0;
  padding-bottom: 4px;
  /* heading.bottom.padding - not yet used */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#eayatsssmc .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* heading.border.bottom.color */
}

#eayatsssmc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  padding-top: 4px;
  padding-bottom: 4px;
}

#eayatsssmc .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  /* column_labels.background.color */
  font-size: 16px;
  /* column_labels.font.size */
  font-weight: initial;
  /* column_labels.font.weight */
  vertical-align: middle;
  padding: 5px;
  margin: 10px;
  overflow-x: hidden;
}

#eayatsssmc .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#eayatsssmc .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eayatsssmc .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#eayatsssmc .gt_group_heading {
  padding: 8px;
  /* row_group.padding */
  color: #333333;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #D3D3D3;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#eayatsssmc .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #D3D3D3;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#eayatsssmc .gt_striped {
  background-color: #8080800D;
}

#eayatsssmc .gt_from_md > :first-child {
  margin-top: 0;
}

#eayatsssmc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#eayatsssmc .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#eayatsssmc .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#eayatsssmc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#eayatsssmc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#eayatsssmc .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#eayatsssmc .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#eayatsssmc .gt_table_body {
  border-top-style: solid;
  /* table_body.border.top.style */
  border-top-width: 2px;
  /* table_body.border.top.width */
  border-top-color: #D3D3D3;
  /* table_body.border.top.color */
  border-bottom-style: solid;
  /* table_body.border.bottom.style */
  border-bottom-width: 2px;
  /* table_body.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* table_body.border.bottom.color */
}

#eayatsssmc .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #D3D3D3;
  /* footnotes.border.top.color */
}

#eayatsssmc .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#eayatsssmc .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #D3D3D3;
  /* sourcenotes.border.top.color */
}

#eayatsssmc .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#eayatsssmc .gt_center {
  text-align: center;
}

#eayatsssmc .gt_left {
  text-align: left;
}

#eayatsssmc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#eayatsssmc .gt_font_normal {
  font-weight: normal;
}

#eayatsssmc .gt_font_bold {
  font-weight: bold;
}

#eayatsssmc .gt_font_italic {
  font-style: italic;
}

#eayatsssmc .gt_super {
  font-size: 65%;
}

#eayatsssmc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="eayatsssmc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead>
    <tr>
      <th colspan="3" class="gt_heading gt_title gt_font_normal gt_center gt_bottom_border" style><strong>Functions used in this section</strong></th>
    </tr>
    
  </thead>
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">definition</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">link</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left"><div class='gt_from_md'><p><code>tidyr::separate_rows()</code></p>
</div></td>
      <td class="gt_row gt_left">If a variable contains observations with multiple delimited values, this separates the values and places each one in its own row.</td>
      <td class="gt_row gt_left"><a href=https://tidyr.tidyverse.org/reference/separate_rows.html>docs</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped"><div class='gt_from_md'><p><code>tidyr::pivot_wider()</code></p>
</div></td>
      <td class="gt_row gt_left gt_striped">"Widens" data, increasing the number of columns and decreasing the number of rows.</td>
      <td class="gt_row gt_left gt_striped"><a href=https://tidyr.tidyverse.org/reference/pivot_wider.html>docs</a></td>
    </tr>
  </body>
  
  
</table></div><!--/html_preserve-->

<br />


```r
library(googlesheets4)
library(googledrive)
```


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
##  1 Bob                               53
##  2 Tina                              31
##  3 Louise                            24
##  4 Bob, Tina                         22
##  5 Bob, Louise                       19
##  6 Bob, Tina, Louise                 18
##  7 Tina, Louise                      13
##  8 Bob, Linda, Tina, Gene, Louise    12
##  9 Bob, Tina, Gene                   10
## 10 Bob, Gene                          9
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
```

```
## Note: Using an external vector in selections is brittle.
## ℹ If the data contains `vars` it will be selected instead.
## ℹ Use `all_of(vars)` instead of just `vars` to silence this message.
```

```r
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






