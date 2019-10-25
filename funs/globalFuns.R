#### ---- Contains some function I use mostly ----
#### ---- Date: 2019 Oct 25 (Fri) ----

#### ---- 1. Create subdirectorie ----
## dirname: Name of the subdir
## dirpath: Directory to create subdir into


#### ---- 1. Create subdirectorie ----
## dirname: Name of the subdir
## dirpath: Directory to create subdir into

#### ---- 1. Create subdirectorie ----
## dirname: Name of the subdir
## dirpath: Directory to create subdir into
createDir <- function(dirname, dirpath = "."){
	dirs <- list.dirs(dirpath)
	dirname <- dirname
	if (length(dirs)>1 & sum(grepl(paste0(dirname, "$"), dirs, ignore.case = TRUE))==0){
   	dir.create(paste0("./", dirname))
	}
}

