#! /usr/local/bin/Rscript

library(rjson)
source("add_tag.fun.R")
source("write_tag.fun.R")
for(fun_file_name in dir("rule")) {
  source(paste("rule", fun_file_name, sep="/"))
}

schema <- fromJSON(file="schema.json")

file_list <- dir("raw")
pass_file_list <- "index.md"

for(file_name in file_list) {
	if (is.element(file_name, pass_file_list)) next
	md.raw <- readLines(paste("raw", file_name, sep="/"))
	cat(sprintf("載入%s...\n",file_name))
	if (!length(md.raw)) next
	tag <- list(); length(tag) <- length(md.raw)
	for(schema.element in schema) {
		cat(sprintf("處理%s中...\n",schema.element$pattern))
    if (is.null(schema.element$rule)) {
      type <- schema.element$type
  		tag <- add_tag(tag, gregexpr(pattern=schema.element$pattern, text=md.raw, perl=TRUE, useBytes=FALSE))
    } else {
      type <- schema.element$type
      index <- grep(pattern=schema.element$pattern, x=md.raw, perl=TRUE, useBytes=FALSE)
      for(i in index) {
        tag <- get(schema.element$rule)(tag, i, schema.element)
      }
      cat(sprintf("使用rule:%s處理%d行\n", schema.element$rule, length(index)))
    }
	}	
	write(write_tag(tag=tag, md.raw=md.raw), file=paste("output", file_name, sep="/"))
	gc()
}
