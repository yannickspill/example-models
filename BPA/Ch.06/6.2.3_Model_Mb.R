## 6. Estimation of the size of a closed population
## 6.2. Generation and analysis of simulated data with data
## augmentation
## 6.2.3. Behavioral or memory effects: model Mb

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
set.seed(1234)

## Read data
## The data generation code is in bpa-code.txt, available at
## http://www.vogelwarte.ch/de/projekte/publikationen/bpa/complete-code-and-data-files-of-the-book.html
stan_data <- read_rdump("Mb.data.R")

## Initial values
inits <- function() list(p = runif(1, 0, 1))

## Parameters monitored
params <- c("N", "p", "c", "trap_response", "omega")

## MCMC settings
ni <- 2000
nt <- 1
nb <- 1000
nc <- 4

## Call Stan from R
out <- stan("Mb.stan",
            data = stan_data, init = inits, pars = params,
            chains = nc, iter = ni, warmup = nb, thin = nt,
            seed = 1,
            open_progress = FALSE)

## Summarize posteriors
print(out, digits = 3)
