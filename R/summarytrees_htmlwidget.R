#' Interactively visualize summary trees in a browser
#'
#' @description Visualize your summary trees as an interactive \code{d3.js} using
#'                \code{htmlwidgets}.  The widget will work in various
#'                R contexts, such as RStudio viewer, R console, a web browser, or Shiny.
#'
#' @param json.object  character string output from \link{prepare.vis}.
#'
#' @return An \code{htmlwidget} object.
#' 
#' @examples 
#' library(summarytreesWidget)
#'
#' json <- paste0(
#'   readLines("http://www2.research.att.com/~kshirley/jsm2015/data.json")
#'   ,collapse="\n"
#' )
#' 
#' summarytrees_htmlwidget(json)
#' 
#' 
#' @import htmlwidgets
#'
#' @export
summarytrees_htmlwidget <- function(json.object, width = NULL, height = NULL) {

  # for now just leave like draw.vis and pass the json.object
  #   on to the htmlwidget.
  # Ideally, I think it would be more convenient to combine
  #   prepare.vis and draw.vis
  
  # forward options using x
  x = list(
    json = json.object
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'summarytrees_htmlwidget',
    x,
    width = width,
    height = height,
    package = 'summarytreesWidget'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
summarytrees_htmlwidgetOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'summarytrees_htmlwidget', width, height, package = 'summarytrees')
}

#' Widget render function for use in Shiny
#'
#' @export
renderSummarytrees_htmlwidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, summarytrees_htmlwidgetOutput, env, quoted = TRUE)
}
