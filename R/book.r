#' The Rethink Priorities bookdown output format
#'
#' @export
book <- function(
  fig_caption = TRUE, 
  number_sections = TRUE, 
  anchor_sections = TRUE, 
  lib_dir = 'libs', 
  pandoc_args = NULL, 
  extra_dependencies = NULL,
  ...
) {
  template <- system.file(
    "resources", "book.html", 
    package = 'rethinkpriorities', 
    mustWork = TRUE
  )
  
  config <- bookdown::html_chapters(
    toc = TRUE,
    number_sections = number_sections, 
    fig_caption = fig_caption,
    anchor_sections = anchor_sections,
    lib_dir = lib_dir, 
    theme = NULL,
    template = template,
    page_builder = build_page,
    split_bib = TRUE,
    split_by = "chapter",
    extra_dependencies = c(book_dependency(), extra_dependencies), 
    highlight = "tango"
  )
  
  config
}

build_toc <- function(toc) {
  # Set the TOC depth
  toc_depth = 0
  
  # Remove all 'li' elements
  toc <- stringr::str_replace_all(
    string = toc, 
    pattern = "<li>|</li>", 
    replacement = ""
  )
  
  # Loop over each element in the TOC vector and adjust the content if needed
  for (i in 1:length(toc)) {
    x = toc[i]
    
    if (stringr::str_detect(x, "<ul>")) {
      toc_depth = toc_depth + 1
      
      if (toc_depth == 1) {
        toc[i] <- stringr::str_replace(x, "<ul>", 
          '<div id="TOC" class="list-group list-group-flush">')
      } else {
        toc[i] <- stringr::str_replace(x, "<ul>", 
          '<div class="list-group list-group-flush list-subgroup">')
      }
    }
    
    if (stringr::str_detect(x, "</ul>")) {
      toc_depth = toc_depth - 1
      toc[i] <- stringr::str_replace(x, "</ul>", '</div>')
    }
    
    if (stringr::str_detect(x, "<a href=")) {
      id = stringr::str_extract(toc[i], '(?<=html#).+?(?=")')
      toc[i] <- stringr::str_replace(
        string = x, 
        pattern = "<a href=", 
        replacement = paste0(
          '<a id="item-', 
          id, 
          '" class="list-group-item ps-3" href=')
        )
    }
  } 
  
  return(toc)
}

build_nav <- function() {
  paste(
    '<!-- Top navigation-->
    <nav 
      id="navbar" 
      class="navbar navbar-expand-lg navbar-light bg-light border-bottom"
    >
      <div class="container-fluid">
        <button class="btn btn-primary p-1" id="sidebarToggle">
          <svg 
            xmlns="http://www.w3.org/2000/svg" 
            width="26" 
            height="26" 
            fill="currentColor" 
            class="bi bi-list" viewBox="0 0 16 16"
          >
            <path 
              fill-rule="evenodd" 
              d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
          </svg>
        </button>
        <button 
          class="navbar-toggler" 
          type="button" 
          data-bs-toggle="collapse" 
          data-bs-target="#navbarContent" 
          aria-controls="navbarContent" 
          aria-expanded="false" 
          aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarContent">
          <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
            <li class="nav-item dropdown">
              <a 
                class="nav-link dropdown-toggle" 
                id="navbarDropdown" 
                href="#" 
                role="button" 
                data-bs-toggle="dropdown" 
                aria-haspopup="true" 
                aria-expanded="false">
                  Settings
              </a>
              <div 
                class="dropdown-menu dropdown-menu-end" 
                aria-labelledby="navbarDropdown">
                  <a class="dropdown-item" href="#!">Toggle code</a>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </nav>'
  )
}

build_chapter <- function(chapter) {
  in_div <- FALSE
  
  for (i in 1:length(chapter)) {
    x <- chapter[i]
    
    if (x == '<div class="foldable">') {
      in_div <- TRUE
      chapter[i] <- '<div class="foldable"><a>Show me more</a><div class="collapse">'
    }
    
    if (in_div) {
      if (x == "</div>") {
        in_div <- FALSE
        chapter[i] <- "</div></div>"
      }
    }
    
    if (stringr::str_detect(x, "<table")) {
      chapter[i] <- stringr::str_replace(
        string = x, 
        pattern = "<table", 
        replacement = '<div class="table-container overflow-auto"><table class="table"'
      )
    } 
    
    if (stringr::str_detect(x, "</table>")) {
      chapter[i] <- stringr::str_replace(
        string = x, 
        pattern = "</table>", 
        replacement = '</table></div>'
      )
    }
    
  }
  
  return(chapter)
}

build_page <- function(
  head, toc, chapter, link_prev, link_next, rmd_cur, html_cur, foot
) {
  toc <- build_toc(toc)
  nav <- build_nav()
  chapter <- build_chapter(chapter)
  
  paste(c(
    head,
    toc,
    '<!-- Page content wrapper-->
    <div id="page-content-wrapper">',
    nav,
    '<!-- Page content-->
    <div id="main-container" class="container-fluid">',
    '<main class="mx-md-5">',
    chapter,
    '<div class="text-center m-3">',
    ifelse(
      length(link_prev) != 0, 
      sprintf(
        '<a href="%s"><button class="btn btn-secondary">%s</button></a>', 
        link_prev, 'Previous'
      ), 
      ""
    ),
    ifelse(
      length(link_next) != 0, 
      sprintf(
        '<a href="%s"><button class="btn btn-secondary">%s</button></a>', 
        link_next, 'Next'
      ), 
      ""
    ),
    '</div>',
    '</main>',
    '</div>',
    '</div>',
    foot
  ), collapse = '\n')
}

book_dependency <- function() {
  resources <- system.file("resources", package = 'rethinkpriorities')
  
  list(
    htmltools::htmlDependency(
      name = "book",
      version = "1.0.0",
      src = resources,
      stylesheet = "style.css", 
      script = "littlefoot.js"
    )
  )
}