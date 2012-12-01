##' merge x委員yz ==> xyz
merge_name1 <- function(tag, i, schema.element) {
  text <- md.raw[i]
  gregexpr.result <- gregexpr(schema.element$pattern, text=text, perl=TRUE, useBytes=FALSE)[[1]]
  item.name <- colnames(attr(gregexpr.result, "capture.start"))
  capture.start <- attr(gregexpr.result, "capture.start")
  capture.length <- attr(gregexpr.result, "capture.length")
  obj <- list(type=type)
  for(name in item.name) {
    obj[[name]] <- substring(text, capture.start[,name], capture.start[,name] + capture.length[,name] - 1)
  }
  obj[["name"]] <- sub(x=obj[["name"]], pattern="委員", replacement="", fixed=TRUE)
  if (is.null(tag[[i]])) {
    tag[[i]] <- list()
    tag[[i]][[1]] <- obj
  } else {
    tag[[i]][[length(tag[[i]]) + 1]] <- obj
  }
  return(tag)
}