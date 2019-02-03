library(tidyverse)
library(data.table)

map <- list()

# Define colours
sauron <- c("#180010", "#4E2729", "#df7b74", "#E8A577", "#fcd882")

options <- list(sauron = sauron
                )



# Expand palette to accept contiuous scales or longer discrete scales
complete_palette <- function(option, n = 3e3){
	complete_col <- c()
	for(i in 1:(length(option)-1)){
		cols <- colorRampPalette(c(option[i], option[i+1]))
		complete_col <- c(complete_col, cols(n))
	}
	return(complete_col)
}

# Build DF map
make_map <- function(option){
	options[[option]] %>%
		complete_palette() %>%
		grDevices::col2rgb() %>%
		t() %>%
		as.data.frame() %>%
		dplyr::rename(V1 = red) %>%
		dplyr::rename(V2 = green) %>%
		dplyr::rename(V3 = blue) %>%
		dplyr::mutate(option = option)
}

for(h in names(options)){
	df <- make_map(h)
	map <- rbind(map,df)
}


tolkien.map <- map
save(tolkien.map, file = "data/tolkien.map.rda", ascii = FALSE, compress = 'xz')
usethis::use_data(tolkien.map, internal = TRUE, overwrite = TRUE)

