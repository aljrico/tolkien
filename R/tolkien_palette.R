#' Original 'Tolkien' colour map
#'
#' A dataset containing some colour palettes inspired on the Tolkien Universe
#'
#'
#'@format A data frame containing all the colours used in the palette:
#'\itemize{
#'   \item V1: Red value
#'   \item V2: Green value
#'   \item V3: Blue value
#'   \item option: It is intended to be a general option for choosing the specific colour palette.
#'}
"tolkien.map"



#' Available Palettes.
#'
#' This function outpus a vector containing the names of all the available palettes in the 'tolkien' package.
#'
#' @return \code{tolkien_palettes} returns a character vector with the names of the palettes available to use.
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}
#'
#'
#' @examples
#' tolkien_palettes()
#'
#' @rdname tolkien_palettes
#' @export

tolkien_palettes <- function(){
	return(unique(tolkien.map$option))
}

#'
#'
#'
#'
#' Tolkien Colour Map.
#'
#' This function creates a vector of \code{n} equally spaced colors along the
#' 'tolkien colour map' of your selection
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#'
#' @param alpha	The alpha transparency, a number in [0,1], see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in [0,1] at which the tolkien colormap begins.
#'
#' @param end The (corrected) hue in [0,1] at which the tolkien colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are ordered from darkest to lightest. If -1, the order of colors is reversed.
#'
#' @param option A character string indicating the colourmap from a option to use.
#'
#' @param house A character string indicating the colourmap from a option to use. This parameter is deprectaed, 'option' should be used instead.
#'
#' @return \code{tolkien} returns a character vector, \code{cv}, of color hex
#' codes. This can be used either to create a user-defined color palette for
#' subsequent graphics by \code{palette(cv)}, a \code{col =} specification in
#' graphics functions or in \code{par}.
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}, \href{https://aljrico.github.io}{Personal Blog}
#'
#' @details
#'
#' \if{html}{Here are the color scales:
#'
#'   \out{<div style="text-align: center">}\figure{hogwarts-scales.png}{houses: style="width:750px;max-width:90\%;"}\out{</div>}
#'
#'   }
#' \if{latex}{Here are the color scales:
#'
#'   \out{\begin{center}}\figure{hogwarts-scales.png}\out{\end{center}}
#'   }
#'
#'
#' Semi-transparent colors (\eqn{0 < alpha < 1}) are supported only on some
#' devices: see \code{\link[grDevices]{rgb}}.
#'
#' @examples
#' library(ggplot2)
#' library(hexbin)
#'
#' dat <- data.frame(x = rnorm(1e4), y = rnorm(1e4))
#' ggplot(dat, aes(x = x, y = y)) +
#'   geom_hex() +
#'   coord_fixed() +
#'   scale_fill_gradientn(colours = tolkien(128, option = 'Sauron'))
#'
#' pal <- tolkien(256, option = "Sauron")
#' image(volcano, col = pal)
#'
#' @rdname tolkien
#' @export
#'
tolkien <- function(n, alpha = 1, begin = 0, end = 1, direction = 1, option = 'Sauron', house = NULL) {

	if(!is.null(house)) option <- house

	option <- tolower(option)
	option <- gsub(" ", "", option, fixed = TRUE)
	option <- gsub("\\_", "", option, fixed = FALSE)

	if (begin < 0 | begin > 1 | end < 0 | end > 1) {
		stop("begin and end must be in [0,1]")
	}

	if (abs(direction) != 1) {
		stop("direction must be 1 or -1")
	}

	if (direction == -1) {
		tmp <- begin
		begin <- end
		end <- tmp
	}

	colnames(tolkien.map) <- c("R", "G", "B", "option")

	map <- tolkien.map[tolkien.map$option == option, ]

	map_cols <- grDevices::rgb(map$R, map$G, map$B, maxColorValue = 255)
	fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	cols <- fn_cols(seq(begin, end, length.out = n)) / 255
	grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}



#' @rdname tolkien
#'
#' @export
tolkien_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, option = 'Sauron', house = NULL) {

	if(!is.null(house)) option <- house
	option <- tolower(option)
	option <- gsub(" ", "", option, fixed = TRUE)
	option <- gsub("\\_", "", option, fixed = FALSE)

	function(n) {
		tolkien(n, alpha, begin, end, direction, option)
	}
}


#' @rdname scale_tolkien
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @export
scale_color_tolkien <- function(option = 'Sauron', ..., alpha = 1, begin = 0, end = 1, direction = 1,
													 discrete = FALSE, house = NULL) {

	if(!is.null(house)) option <- house
	option <- tolower(option)
	option <- gsub(" ", "", option, fixed = TRUE)
	option <- gsub("\\_", "", option, fixed = FALSE)

	if (discrete) {
		discrete_scale("colour", "tolkien", tolkien_pal(alpha, begin, end, direction, option), ...)
	} else {
		scale_color_gradientn(colours = tolkien(256, alpha, begin, end, direction, option), ...)
	}
}

#' @rdname scale_tolkien
#' @aliases scale_color_tolkien
#' @importFrom ggplot2 discrete_scale
#' @export
scale_colour_tolkien <- scale_color_tolkien

#' @rdname scale_tolkien
#' @aliases scale_color_tolkien
#' @export
scale_colour_tolkien_d <- function(option = 'Sauron', ..., alpha = 1, begin = 0, end = 1,
															direction = 1) {
	discrete_scale("colour", "tolkien", tolkien_pal(alpha, begin, end, direction, option), ...)
}

#' @rdname scale_tolkien
#' @aliases scale_color_tolkien
#' @export
scale_color_tolkien_d <- scale_colour_tolkien_d


#' @rdname scale_tolkien
#' @aliases scale_fill_tolkien
#' @importFrom ggplot2 discrete_scale
#' @export
scale_fill_tolkien_d <- function(option = 'Sauron', ..., alpha = 1, begin = 0, end = 1,
														direction = 1) {
	discrete_scale("fill", "tolkien", tolkien_pal(alpha, begin, end, direction, option), ...)
}


#' @rdname tolkien
#' @aliases tolkien
#' @export
tolkien <- tolkien

#' Talkien colour scales
#'
#' Uses the Tolkien color scale.
#'
#' For \code{discrete == FALSE} (the default) all other arguments are as to
#' \link[ggplot2]{scale_fill_gradientn} or \link[ggplot2]{scale_color_gradientn}.
#' Otherwise the function will return a \code{discrete_scale} with the plot-computed
#' number of colors.
#'
#'
#' @param ... parameters to \code{discrete_scale} or \code{scale_fill_gradientn}
#'
#' @param alpha pass through parameter to \code{tolkien}
#'
#' @param begin The (corrected) hue in [0,1] at which the tolkien colormap begins.
#'
#' @param end The (corrected) hue in [0,1] at which the tolkien colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are as output by \code{tolkien_pal}. If -1, the order of colors is reversed.
#'
#' @param discrete generate a discrete palette? (default: \code{FALSE} - generate continuous palette)
#'
#' @param option A character string indicating the colourmap  to use.
#'
#' @param house A character string indicating the colourmap from a option to use. This parameter is deprectaed, 'option' should be used instead.
#'
#' @rdname scale_tolkien
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}
#'
#' @importFrom ggplot2 scale_fill_gradientn scale_color_gradientn discrete_scale
#'
#' @importFrom gridExtra grid.arrange
#'
#' @examples
#' library(ggplot2)
#'
#'
#'
#' ggplot(mtcars, aes(factor(cyl), fill=factor(vs))) +
#' geom_bar() +
#' scale_fill_tolkien(discrete = TRUE, option = "Sauron")
#'
#' ggplot(mtcars, aes(factor(gear), fill=factor(carb))) +
#' geom_bar() +
#' scale_fill_tolkien(discrete = TRUE, option = "Sauron")
#'
#' ggplot(mtcars, aes(x = mpg, y = disp, colour = hp)) +
#' geom_point(size = 2) +
#' scale_colour_tolkien(option = "Sauron")
#'
#'
#'
#'
#' @export
scale_fill_tolkien <- function(option = 'Sauron', ..., alpha = 1, begin = 0, end = 1, direction = 1,
													discrete = FALSE, house = NULL) {

	if(!is.null(house)) option <- house
	option <- tolower(option)
	option <- gsub(" ", "", option, fixed = TRUE)
	option <- gsub("\\_", "", option, fixed = FALSE)

	if (discrete) {
		discrete_scale("fill", "tolkien", tolkien_pal(alpha, begin, end, direction, option), ...)
	} else {
		scale_fill_gradientn(colours = tolkien(256, alpha, begin, end, direction, option), ...)
	}
}