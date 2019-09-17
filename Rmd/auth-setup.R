library(googlesheets) 
options(httr_oob_default=TRUE) 
gs_auth(new_user = TRUE) 


# works as well -----------------------------------------------------------
library(googlesheets)
library(httr)

file.remove('.httr-oauth') # Remove current token

oauth2.0_token(
  endpoint = oauth_endpoints("google"),
  app = oauth_app(
    "google", 
    key = getOption("googlesheets.client_id"), 
    secret = getOption("googlesheets.client_secret")
  ),
  scope = c(
    "https://spreadsheets.google.com/feeds", 
    "https://www.googleapis.com/auth/drive"),
  use_oob = TRUE,
  cache = TRUE
)


# test it out -------------------------------------------------------------

suppressPackageStartupMessages(library(tidyverse))
library(googlesheets)

sheet <- gs_url("https://docs.google.com/spreadsheets/d/16F7E_3s2UYXt__qq5N1GtxVbMR8BvPpU7L_WE9enszg/edit#gid=2018729513")

bobs_ws <- gs_ws_ls(sheet)

# run this if you want to double check in browser
sheet %>% gs_browse(glue::glue("{bobs_ws}"))

raw_dat <- sheet %>% gs_read(ws = glue::glue("{bobs_ws}"))
