% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sumtab.R
\name{sumtab}
\alias{sumtab}
\title{A styled summary table for one outcome by another grouping variable. A lovely set of statistics}
\usage{
sumtab(df, depvar, treatvar, caption = "", digits = 3, label = TRUE)
}
\description{
A styled summary table for one outcome by another grouping variable. A lovely set of statistics
}
\details{
uses kable and kable_styling
}
\examples{
 sumtab(movies_long, budget, genre)
 airquality \%>\% mutate(ifelse(Ozonesumtab(airquality, Ozone, Month)
}
