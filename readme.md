
# tolkien <img src="man/figures/logo.png" align="right" width="120" />


[![cran version](http://www.r-pkg.org/badges/version/tolkien)](https://cran.r-project.org/package=tolkien)
[![rstudio mirror per-month downloads](http://cranlogs.r-pkg.org/badges/tolkien)](https://github.com/metacran/cranlogs.app)
[![rstudio mirror total downloads](http://cranlogs.r-pkg.org/badges/grand-total/tolkien?color=yellowgreen)](https://github.com/metacran/cranlogs.app)

This package provides the first round of palettes derived from the *Tolkien* universe.

They have been chosen manually, taking into account its consistency with all the existing branding of the franchise, but its suitability for data visualisation. 

> Most of us need to _listen_ to the music to understand how beautiful it is. But often that’s how statistics are presented: we show the notes instead of playing the music.

The colour palette should be beautiful, useful for plotting data and shoulr relate to desired style; in this case, should relate to the Tolkien legendarium. Some of the colours might change in future versions, in order to find this balance between suitability for plotting and relatable to the Tolkien legendarium.

<center><img src="https://raw.githubusercontent.com/aljrico/tolkien/master/readme_raw_files/examples/scales_houses.png" ></center>




Installation
-------------

Just copy and execute this bunch of code and you'll have the last version of the package installed:


```r
install.packages("tolkien")
```

And you can now use it:


```r
library(tolkien)
```

Usage
-----

The default colour scale of the package is the one named **Sauron**. If you prefer to choose another one, you'll need to specify which house you want the palette from.

You can get started using base R plot functions, and the `tolkien()` function. Its first argument `n` lets you set the number of colours to be mapped. This way you can set different resolutions. Let's say that you want a palette inspired by **Sauron**, then just type `option = "Sauron"`. 


```r
pal <- tolkien(n = 8, house = "Sauron")
image(volcano, col = pal)

pal <- tolkien(n = 128, house = "Sauron")
image(volcano, col = pal)
```

<center><img src="https://raw.githubusercontent.com/aljrico/tolkien/master/readme_raw_files/examples/gryffindor_volcano.png" ></center>

## ggplot2

Of course, this package has specific functions to behave seamlessly with the best data visiualisation library available. 
The package contains colour scale functions for **ggplot2** plots: `scale_colour_tolkien()` and `scale_fill_tolkien()`. 


Here is a made up example using the colours from the house of **Hufflepuff**,


```r
library(ggplot2)
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() + 
	coord_fixed() +
  scale_fill_tolkien(house = "Sauron") + 
	theme_bw()
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-6-1.png" ></center>


or more made-up heatmaps:

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-8-1.png" ></center>


Using the same function we can also plot these cloropleth maps of U.S. unemployment:

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/ggplot2-1.png" ></center>

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/ggplot2-2.png" ></center>


### Discrete Scales

But what if you want discrete scales? These functions also can be used for discrete scales with the argument `discrete = TRUE`. This argument, when TRUE, sets a finite number of sufficiently spaced colours within the selected palette to plot your data.


```r
ggplot(diamonds, aes(factor(color), fill=factor(cut))) +
	geom_bar(colour = "black") +
	scale_fill_tolkien(discrete = TRUE, option = "Sauron", name = "Cut") +
	ylab("") +
	xlab("Colour") +
	coord_flip()
```

<center><img src="https://raw.githubusercontent.com/aljrico/tolkien/master/readme_raw_files/examples/ronweasley_bar.png" ></center>

You can also use discrete scales by adding `_d()` at the end of it instead, like `scale_fill_tolkien_d()`.


```r
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
ggplot(dsamp, aes(carat, price)) +
	geom_point(aes(colour = clarity)) +
	scale_colour_tolkien_d(option = "Sauron", name = "Clarity") +
	xlab("Carat") +
	ylab("Price")
```

<center><img src="https://raw.githubusercontent.com/aljrico/tolkien/master/readme_raw_files/examples/Sauron_scatter.png" ></center>


Don't forget to try them all.

<center><img src="https://raw.githubusercontent.com/aljrico/tolkien/master/readme_raw_files/examples/mischief_always_tile.png" ></center>



# Palettes

```r
option = "Sauron"
```
<center><img src="https://raw.githubusercontent.com/aljrico/tolkien/master/readme_raw_files/palettes/sauron.png" width = "75%""; height="75%"></center>

---

