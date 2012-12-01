#! /usr/local/bin/Rscript

##' add result of gregexpr to tag obj
##'
##'@param tag tag obj
##'@param gregexpr.result result of gregexpr
##'@result tag obj
add_tag <- function(tag, gregexpr.result) {
	count.index <- 0
	for(i in 1:length(gregexpr.result)) {
		gregexpr.result.element <- gregexpr.result[[i]]
		if (gregexpr.result.element == -1) next
		text <- md.raw[i]
		item.name <- colnames(attr(gregexpr.result.element, "capture.start"))
		capture.start <- attr(gregexpr.result.element, "capture.start")
		capture.length <- attr(gregexpr.result.element, "capture.length")
		obj <- list(type=type)
		for(name in item.name) {
			obj[[name]] <- substring(text, capture.start[,name], capture.start[,name] + capture.length[,name] - 1)
		}
		if (is.null(tag[[i]])) {
			tag[[i]] <- list()
			tag[[i]][[1]] <- obj
		} else {
			tag[[i]][[length(tag[[i]]) + 1]] <- obj
		}
		count.index <- count.index + 1
	}
	cat(sprintf("一共搜尋到並處理了%d行\n", count.index))
	return(tag)
}