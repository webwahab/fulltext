

# Internal regexp functions
.grep.url <- function(url, regexp, which=1){
    html <- as.character(GET(url))
    return(.grep.text(html, regexp, which))
}
.grep.text <- function(text, regexp, which=1){
    links <- gregexpr(regexp, text)
    pos <- as.numeric(links[[1]][which])
    return(substr(text, pos, pos+attr(links[[1]], "match.length")[which]-1))
}

# Internal download function
.download <- function(url, dir, save.name, cache=TRUE){
    destination <- file.path(dir, save.name)
    if(cache==TRUE & file.exists(destination))
        return(destination)
    result <- download.file(url, destination, quiet=TRUE)
    if(result != 0)
        stop("Error code", result, " downloading file; file may not exist")
    return(destination)
}

# Internal unzip function
.unzip <- function(zip, dir, save.name, cache, si, list=FALSE){
    files <- unzip(zip, list=TRUE)
    if(list){
        cat("Files in ZIP:")
        print(files)
    }
    if(!si %in% files$Name)
        stop("Required file not in zipfile ", zip)
    file <- unzip(zip, si)
    file.rename(file, file.path(dir, save.name))
    return(file.path(dir, save.name))
}

# Internal URL 'redirect' function
.url.redir <- function(x)
    return(GET(x)$url)

.tmpdir <- function(dir){
    if(!is.na(dir)){
        if(!file.exists(dir))
            stop("'dir' must exist unless NA")
    } else dir <- tempdir()
    return(dir)
}
.save.name <- function(doi, save.name, file){
    if(is.na(save.name)){
        save.name <- paste(doi,file, sep="_")
        save.name <- gsub(.Platform$file.sep, "_", save.name, fixed=TRUE)
    }
    return(save.name)
}
#Expanding arguments when handling ft-classes
.fix.param <- function(x, param, name){
    if(length(x) != length(param)){
        if((length(x) %% length(param)) != 0)
            stop("length of ", "name (", length(param), ") is incompatible with 'x' (", length(x), ")")
        param <- rep(param, length(x))
    }
    return(param)
}