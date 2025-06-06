% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/robustness_bound.R
\name{robustness_bound}
\alias{robustness_bound}
\title{Compute the robustness changepoint}
\usage{
robustness_bound(object, level = 0.95)
}
\arguments{
\item{object}{an \code{apm_est} object; the output of a call to \code{\link[=apm_est]{apm_est()}}. \code{M} must have been set to a nonzero value to use \code{robustness_bound()}.}

\item{level}{the desired confidence level. Set to 0 to ignore sampling variation in computing the interval bounds. Default is .95.}
}
\value{
A single number corresponding to the changepoint value of M. If there is no positive value of M for which the interval bounds cross 0, \code{NA} will be returned.
}
\description{
\code{robustness_bound()} computes the value of the sensitivity parameter M at which the robustness bounds change from excluding to including an ATT of 0.
}
\examples{
data("ptpdata")

# Combination of 4 models: 2 time trends, 2 lags
models <- apm_mod(list(crude_rate ~ 1),
                  lag = 0:1,
                  time_trend = 0:1)
models

# Fit the models to data; unit_var must be supplied for
# fixed effects
fits <- apm_pre(models,
                data = ptpdata,
                group_var = "group",
                time_var = "year",
                val_times = 2004:2007,
                unit_var = "state",
                nsim = 100,
                verbose = FALSE)

est <- apm_est(fits,
               post_time = 2008,
               M = 1,
               R = 20,
               verbose = FALSE)

est

# ATT estimate and bounds for M = 1
summary(est)

#Changepoint value of M ignoring estimation uncertainty
(M <- robustness_bound(est, level = 0))

summary(est, level = 0, M = M)

#Changepoint value of M accounting for estimation uncertainty
(M <- robustness_bound(est, level = .95))

summary(est, level = .95, M = M)
}
\seealso{
\code{\link[=summary.apm_est]{summary.apm_est()}} for examining the ATT and bounds for a given value of \code{M}; \code{\link[=uniroot]{uniroot()}} for the function that finds the changepoint value of \code{M}.
}
