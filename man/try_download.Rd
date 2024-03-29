% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/try_download.R
\name{try_download}
\alias{try_download}
\title{downloads from a url to a local path, without breaking if it fails}
\usage{
try_download(url, path)
}
\description{
\code{try_download} downloads from a URL to a local path. Often used for 'getting background stuff in bookdowns. Catches errors
}
\examples{
try_download(
"https://raw.githubusercontent.com/daaronr/dr-rstuff/master/functions/project_setup.R",
 here::here("code", "project_setup.R")
)

}
