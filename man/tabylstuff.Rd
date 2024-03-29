% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adorn_tabyls.R
\name{tabylstuff}
\alias{tabylstuff}
\title{A set of functions to 'adorn' and format janitor::tabyl() table objects}
\usage{
tabylstuff(df, cap = "")
}
\arguments{
\item{df}{is a 'tabyl' style tibble}

\item{cap}{is a caption text (quoted string)}

\item{digits}{(in adornme and adornme_not) lets you specify the digits in the percentage}

\item{adorn}{(in adornme and adornme_not) lets you specify whether row or column will be made into percentages ... not sure this actually makes sense!}
}
\description{
\code{tabylstuff} is a function that puts totals for row and column, formats rows with 1 digit percentages, adds "N" counts, makes it a kable with a caption, and styles the kable
\code{tabylstuff_nocol} is like tabylstuff but without column totals
\code{adornme} adds a title and does some other things differently, but I'm not sure what. This may be mostly redundant
\code{adornme_not} is adornme without a title
}
\details{
XXX This function does nothing. It relies on no packages
}
\examples{
 XXX nothing(mtcars)
}
