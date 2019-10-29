library(tidyverse)

family <- list(
  list(
    "name" = "Bob",
    "age" = 46,
    "father" = "Big Bob",
    "mother" = NA,
    "siblings" = list(NA),
    "children" = list("Tina", "Gene", "Louise"),
    "glasses" = FALSE
  ),
  list(
    "name" = "Linda",
    "age" = 45,
    "father" = "Al",
    "mother" = "Gloria",
    "siblings" = list("Gayle"),
    "children" = list("Tina", "Gene", "Louise"),
    "glasses" = TRUE
  ),
  list(
    "name" = "Tina",
    "age" = 13,
    "father" = "Bob",
    "mother" = "Linda",
    "siblings" = list("Gene", "Louise"),
    "children" = list(NA),
    "glasses" = TRUE
  ),
  list(
    "name" = "Gene",
    "age" = 11,
    "father" = "Bob",
    "mother" = "Linda",
    "siblings" = list("Tina", "Louise"),
    "children" = list(NA),
    "glasses" = FALSE
  ),
  list(
    "name" = "Louise",
    "age" = 9,
    "father" = "Bob",
    "mother" = "Linda",
    "siblings" = list("Tina", "Gene"),
    "children" = list(NA),
    "glasses" = FALSE
  )
)

belchers <- tibble(info = family)

belchers

names(belchers$info[[1]])

belchers %>% unnest_wider(info)

# From the belchers data frame in the listcol info,
# I want the element “name” in a column I’ll call name,
# the element “age” in a column I’ll call age,
# and the element “father” in a column I’ll call dad.
# I'll also get the first element of the nested list
# "children" and call it firstborn.
belchers %>% hoist(info,
                   name = "name",
                   age = "age",
                   dad = "father",
                   firstborn = list("children", 1L)
)

