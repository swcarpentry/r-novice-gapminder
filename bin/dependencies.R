install_required_packages <- function(lib = NULL, repos = getOption("repos", default = c(CRAN = "https://cran.rstudio.com/"))) {
  
  # The option 'repos' might be set to a special value which confuses
  # install.packages if it is forwarded explicitly. See ?options for docs of 
  # the repos option.
  if(identical(repos, "@CRAN@") && !interactive()){
    options(repos = c(CRAN = "https://cran.rstudio.com/"))
    repos <- getOption("repos")
  }

  if (is.null(lib)) {
    lib2 <- .libPaths()
  }else{
    # If the lib= argument is provided to install.packages(), all of the
    # specified folders must be readable. Thus, forward NULL to install.packages
    # when it is provided to this function.
    lib2 <- lib
  }

  message("lib paths: ", paste(lib2, collapse = ", "))
  missing_pkgs <- setdiff(
    c("rprojroot", "desc", "remotes", "renv"),
    rownames(installed.packages(lib.loc = lib2))
  )

  install.packages(missing_pkgs, lib = lib, repos = repos)

}

find_root <- function() {

  cfg  <- rprojroot::has_file_pattern("^_config.y*ml$")
  root <- rprojroot::find_root(cfg)

  root
}

identify_dependencies <- function() {

  root <- find_root()

  required_pkgs <- unique(c(
    ## Packages for episodes
    renv::dependencies(file.path(root, "_episodes_rmd"), progress = FALSE, error = "ignore")$Package,
    ## Packages for tools
    renv::dependencies(file.path(root, "bin"), progress = FALSE, error = "ignore")$Package
  ))

  required_pkgs
}

create_description <- function(required_pkgs) {
  d <- desc::description$new("!new")
  lapply(required_pkgs, function(x) d$set_dep(x))
  d$write("DESCRIPTION")
}

install_dependencies <- function(required_pkgs, ...) {

  create_description(required_pkgs)
  on.exit(file.remove("DESCRIPTION"))
  remotes::install_deps(dependencies = TRUE, ...)

  if (require("knitr") && packageVersion("knitr") < '1.9.19') {
    stop("knitr must be version 1.9.20 or higher")
  }

}
