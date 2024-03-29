% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summ.R
\name{.summ}
\alias{.summ}
\title{Preferred version of vtable::sumtable, with nice names}
\usage{
.summ(
  data,
  vars = NA,
  out = NA,
  file = NA,
  summ = c("notNA(x)", "sum(x != 0)", "mean(x)", "sd(x)", "pctile(x)[50]",
    "pctile(x)[90]"),
  summ.names = c("N Responses", "N positive", "Mean", "Sd", "Median", "90th pct"),
  add.median = FALSE,
  group = NA,
  group.long = FALSE,
  group.test = FALSE,
  group.weights = NA,
  col.breaks = NA,
  digits = 1,
  fixed.digits = FALSE,
  factor.percent = TRUE,
  factor.counts = TRUE,
  factor.numeric = FALSE,
  logical.numeric = FALSE,
  logical.labels = c("No", "Yes"),
  labels = TRUE,
  title = "Summary Statistics",
  note = NA,
  anchor = NA,
  col.width = NA,
  col.align = NA,
  align = NA,
  note.align = "l",
  fit.page = "\\\\textwidth",
  simple.kable = TRUE,
  opts = list()
)
}
\description{
Preferred version of vtable::sumtable, with nice names
}
\details{
vtable must be installed
}
\examples{
 (
 don_inc_career_tab <- eas_all_s_rl_imp \%>\%
           filter(!is.na(don_av2_yr)) \%>\%
     mutate(`Earn-to-give` = as.factor(d_career_etg),
          `GwwC` = as.factor(d_gwwc_ever_0)) \%>\%
 ungroup() \%>\%
 filter(year_f \%in\% c("2018", "2019", "2020")) \%>\%
dplyr::select(starts_with("don"), starts_with("d_don"), starts_with("inc"), -income_c_imp_diqr,
              d_pt_employment, d_not_employed,
              `Earn-to-give`, `GwwC`) \%>\%
 dplyr::select(-starts_with("l_"), -d_don_10pct, -ends_with("d2sd"),
               -matches("_if_|_post_")) \%>\%
   .summ(title = "Donations, income, career, 2018-2020,  (subset: reporting 0+ donation)",
         digits = c(0,0,1,1,2,1),
         labels=TRUE,
         logical.labels = c("No", "Yes"),
         factor.counts = FALSE,
          out="kable") \%>\%
 kable_styling()
)
}
