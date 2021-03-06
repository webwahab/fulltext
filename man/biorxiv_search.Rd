% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bio_utils.R
\name{biorxiv_search}
\alias{biorxiv_search}
\title{Biorxiv search}
\usage{
biorxiv_search(query, limit = 10, ...)
}
\arguments{
\item{query}{query terms}

\item{limit}{records to return. default: 10}

\item{...}{curl options passed on to \code{\link[httr]{GET}}}
}
\description{
Biorxiv search
}
\examples{
\dontrun{
biorxiv_search(query = "ecology", config = verbose())
}
}
\keyword{internal}
