---
title: "README"
author: "Your name here"
output: html_document
---

# Project template overview

This README gives an overview of what the project template folder structure is. Please customize the folder structure as needed.

After understanding what is written in this README, please delete the text and replace it with instructions of how this project works, so that anyone else can understand and run the code.

Once you are done with the project, please fill out a post summarizing what you've done in the team's project blog, and link copies of the final deliverables into the post.

# `RProj` name

Please ensure that the `RProj` file and main project folder are saved with the following filename  (where `YYYY-MM-DD` is the `RProj` creation date):

`YYYY-MM-DD-descriptive_project_name`

## Project folder structure

This is the basic outline for a typical analysis project. Feel free to delete any of these folders if you do not need them.

`R`: Use the `R` folder to store your functions. One file per function. Use the `fnmate` to help create the functions, if you'd like.

`data`: The `data` folder is for storing raw data files only. `drake` will take care of any intermediate and final values.

`deliverables`: The `deliverables` folder is for any data deliverables, like PDF reports, Excel files, dashboards, etc. If this project will span multiple time periods, put the respective deliverables for each time period as a sub-folder (e.g., `2019`, `2020`).

`reference`: The `reference` folder is for any requirements documents, project charters, email message chains, etc. that may help someone understand the context of this project.

## `git`

Git has been set up for this project. Please use version control with this project and also, please connect it to our Azure DevOps online repository system. Ensure that a coworker completes a code review of this project before it is released.

## `drake`

`drake` is set up with this project. Please use a function-based workflow using `r_make()`. This is what the `packages.R`, `_drake.R` and `R/plan.R` files are for. Please refer to Miles McBain's blog post (https://milesmcbain.xyz/the-drake-post/), the `drake` book (https://books.ropensci.org/drake/), and the `dflow` README on Github (https://github.com/sharleenw/dflow) for more information.

### `packages.R`

This is the file to store all of your library calls. Source this file using the `dflow::loadd_packages()` function.

### `R/plan.R`

This file is where the `drake` plan goes.

## `renv`

`renv` has been initialized for this project. Please capture snapshots of this project's dependencies using `renv::snapshot()` if your packages change. This will help you in a year from now :).
