# dflow

An opinionated lightweight template for smooth `drake` flows.

This version has been modified from Miles McBain's original version, for use by my team specifically.

## Installation

`remotes::install_github("sharleenw/dflow")`

## About

`dflow` tries to set up a minimalist ergonomic workflow for `drake` pipeline
development. To get the most out of it follow these tips:

1. Put all your target code in separate functions in `R/`. Use `fnmate` to
   quickly generate function definitions in the right place. Let `plan.R` define
   the structure of the workflow and use it as a map for your sources. Use 'jump
   to function' to quickly navigate to them.

2. Use a call `r_make()` to kick off building your plan in a new R session (via
   `callr`). `_drake.R` is setup to make this work. Bind a keyboard shortcut to
   this using the addin in drake.

3. Put all your `library()` calls into `packages.R`. This way you'll have them
   in one place when you go to add sandboxing with `renv`, `packrat`, and
   `switchr` etc.

4. Take advantage of automation for loading drake targets at the cursor with the
   'loadd target at cursor' addin.

## Opinions

Some things are baked into the template that will help you avoid common pitfalls
and make your project more reproducible:

1. `library(conflicted)` is called in `packages.R` to detect package masking issues.

2. `.env` is added carrying the following options to avoid misuse of logical vector tests:

```
_R_CHECK_LENGTH_1_LOGIC2_=verbose
_R_CHECK_LENGTH_1_CONDITION_=true
```

## Usage

`dflow::use_dflow()`

Creates a package structure template specific to the team, initializing both `git` and `capsule`. This template should be called on new `RProj`s only.

```
.
+-- .git
+-- .RProj.user
+-- data
+-- deliverables
+-- packages.R
+-- R
|   \-- plan.R
+-- README.md
+-- reference
+-- renv
|   +-- activate.R
|   +-- library
|   |   \-- R-4.0
|   \-- settings.dcf
+-- .env
+-- .gitignore
+-- .RProfile
+-- renv.lock
+-- test_dflow.Rproj
\-- _drake.R
```

### Creating new `Rmd` files:

`dflow::use_rmd("analysis.Rmd")`:

```
v Creating 'deliverables/'
v Writing 'deliverables/analysis.Rmd'
Add this target to your drake plan:

target_name = target(
  command = {
    rmarkdown::render(knitr_in("deliverables/analysis.Rmd")),
    file_out("deliverables/analysis.html")
  }
)

(change output extension as appropriate if output is not html)
library(rmarkdown) added to ./packages.R
```


## This fork-specific Opinions

### Project folder structure

This is the basic outline for a typical analysis project. Feel free to delete any of these folders if you do not need them.

`R`: Use the `R` folder to store your functions. One file per function. Use the `fnmate` to help create the functions, if you'd like.

`data`: The `data` folder is for storing raw data files only. `drake` will take care of any intermediate and final values.

`deliverables`: The `deliverables` folder is for any data deliverables, like PDF reports, Excel files, dashboards, etc. If this project will span multiple time periods, put the respective deliverables for each time period as a sub-folder (e.g., `2019`, `2020`).

`reference`: The `reference` folder is for any requirements documents, project charters, email message chains, etc. that may help someone understand the context of this project.


## `git`

Git has been set up for this project. Please use version control with this project and also, please connect it to our Azure DevOps online repository system. Ensure that a coworker completes a code review of this project before it is released.

## `drake`

`drake` is set up with this project. Please use a function-based workflow using `r_make()`. This is what the `packages.R`, `_drake.R` and `R/plan.R` files are for. Please refer to Miles McBain's blog post (https://milesmcbain.xyz/the-drake-post/), the `drake` book (https://books.ropensci.org/drake/), and the `dflow` README on Github (https://github.com/sharleenw/dflow) for more information.

## `packages.R`

This is the file to store all of your library calls. Source this file using the `dflow::loadd_packages()` function.

## `R/plan.R`

This file is where the `drake` plan goes.

## `capsule`

`capsule`, which is a more relaxed wrapper for `renv`, created by Miles McBain, has been initialized for this project (`capsule::create()` has been run with `dflow::use_dflow()`). Please capture snapshots of this project's dependencies using `capsule::recreate()` if your packages change. This will help you in a year from now :).

## Project-specific `.Rprofile`

A project-specific `.Rprofile` has been set up with this project.

It will run the global `.Rprofile`, and will also convert any warnings into errors, so that they are properly dealt with in the code.

## Automatically have `dflow` run interactively

Since `dflow` will only be called interactively, I recommend calling `usethis::edit_r_profile()` and adding the following options to the file that appears:

```
if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(usethis))
  suppressMessages(require(dflow))  # Add this line!
}
```

This will work even within the `capsule` environment of the package because we also load the global `.Rprofile`.

## Loading packages

`dflow::loadd_packages()` loads all packages after restarting R.

Another option is to use the `shrtcts` package and add the following lines to the `shrtcts.yaml` package (source: https://github.com/MilesMcBain/nycr_meetup_talk):

```
- Name: Source ./packages.R
  Binding: |
    cat(glue::glue('> source(\"./packages.R\")\n\n'))
    source("./packages.R")
  Interactive: true
```

## Loading all functions

`dflow::loadd_functions()` loads all packages and your defined functions after restarting R.

Or you can source all functions directly (sourcing the packages separately) by using the `shrtcts` package, and adding this to the `shrtcts.yaml` package (sort of sourced from: https://github.com/MilesMcBain/nycr_meetup_talk):

```
- Name: Source all functions
  Binding: |
    lapply(list.files("./R", full.names = TRUE), source)
  Interactive: true
```

## Loading all targets

`drake::loadd()` loads all targets.

### Other handy shortcuts by Garrick Aden-Buie:

These other shortcuts made using the `shrtcts` package (source: https://gist.github.com/gadenbuie/140204f122240f397e68e610643a4190) may help your workflow:

```
#' Drake - Load Project
#'
#' @description Source "_drake.R"
#' @id 3
#' @interactive
function() {
  drake_src <- here::here("_drake.R")
  if (file.exists(drake_src)) {
    rstudioapi::sendToConsole(paste0("source(\"", drake_src, "\")"))
    rstudioapi::executeCommand("activateConsole")
  }
  else {
    message("_drake.R file not found: ", drake_src)
  }
}

#' Drake - Loadd Targets for Function
#'
#' @description Load the targets used by the selected function
#' @id 5
function() {
  ctx <- rstudioapi::getSourceEditorContext()
  if (!nzchar(ctx$selection[[1]]$text)) {
    message("Nothing selected")
    return(invisible())
  }
  if (!exists("plan", envir = globalenv())) {
    stop("Please load a drake plan first.", call. = FALSE)
  }
  plan <- get("plan", globalenv())
  args <- names(formals(ctx$selection[[1]]$text))
  cache <- getOption("rstudio_drake_cache") %||% drake::drake_cache()
  cache <- drake:::decorate_storr(cache)
  targets <- intersect(args, plan$target)
  cat("loading targets:", paste(targets, collapse = ", "))
  drake::loadd(list = targets, envir = globalenv(), cache = cache)
}
```

