library(markdown)
argv <- commandArgs(TRUE)
markdownToHTML(argv[1], output=argv[2])