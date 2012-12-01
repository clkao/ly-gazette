#! /usr/local/bin/Rscript

##' write tag to md.raw
##'
##' @param tag obj
##' @param md.raw markdown document
##' @return result
write_tag <- function(tag, md.raw, header="```json", footer="```") {
	for(i in 1:length(tag)) {
		if (is.null(tag[[i]])) next
		for(tag.element in tag[[i]]) {
			md.raw[i] <- paste(md.raw[i], header, toJSON(tag.element, method="R"), footer, sep="\n")
		}
	}
	return(md.raw)
}