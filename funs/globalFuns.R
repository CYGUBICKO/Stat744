#### ---- Contains some function I use mostly ----
#### ---- Date: 2019 Oct 25 (Fri) ----

#### ---- 1. Create subdirectories ----
## dirname: Name of the subdir
## dirpath: Directory to create subdir into

createDir <- function(dirname, dirpath = "."){
	dirs <- list.dirs(dirpath)
	dirname <- dirname
	if (length(dirs)>1 & sum(grepl(paste0(dirname, "$"), dirs, ignore.case = TRUE))==0){
   	dir.create(paste0("./", dirname))
	}
}

#### ---- 2. Dowunload dataset ----
# The function will check if the dataset is in the dir (and load) otherwise download (and load)

## filename: The name (can also be a pattern string) of the file to check or save as the output (without .filetype)
## filetype: file extension (no ".")
## url: Data url

downloadDf <- function(filename, filetype, df_url){
	if(length(list.files("."))>0 & sum(grepl(filename, list.files("."), ignore.case = TRUE))==1){
		df_name <- grep(filename, list.files(), value = T)
		cat("Reading dataset from your computer... \n")
		working_df <- read.csv(df_name)
		cat(paste0(filename, ".", filetype), " dataset already saved!!! \n")
	} else {
		# Download data
		cat("Downloading dataset from ", df_url, "\n")
		temp_df <- read.csv(df_url)
		write.csv(temp_df, paste0(filename, ".", filetype), row.names = FALSE)
		working_df <- temp_df
		cat(filename
			, " didn't exist!!! We've downloaded data from the url "
			, df_url, "\n Dataset dim: "
			, dim(temp_df)
		)
	}
	return(working_df)
}


#### ---- 3. Summarise a dataframe ----
# `summarizeDf` summariz(s)es dataframe. Computes ([min, max]; mean (sd)) for numerical or integer variables and frequency distribution (percent) for categorical variables.

# Inputs:
## `df` - Input dataframe
## `output` - Specifies the output structure. `output = "simple"` returns R-output-like output. `output = "tex"` returns xtable ready format.
## digits - Number of digits to return.

# Details:
# For categorical variables with several categories, `output = "tex"` is preferrable. Add sanitize.text.function = function(x){x} to xtable print function for .tex.

# Value:
# It returns an object of class `data.frame`.

summarizeDf <- function(df, output = c("simple", "tex"), digits = 1){
	if (!missing(output) & sum(!output %in% c("simple", "tex")) > 0){
		stop("output can only be 'simple' or 'tex'")
	}
	vars <- colnames(df)
	df_summary <- data.frame(Variable = rep(NA, length(vars))
		, Type = rep(NA, length(vars))
		, Summary = rep(NA, length(vars))
	)
  	for (i in 1:length(vars)){
		vals <- df[, vars[[i]]]
		if (class(vals) == "numeric" | class(vals) == "integer"){
			df_summary[["Type"]][[i]] <- "numeric"
			df_summary[["Variable"]][[i]] <- vars[[i]]
			df_summary[["Summary"]][[i]] <- paste0("["
				, round(min(vals, na.rm = TRUE), digits), ", "
				, round(max(vals, na.rm = TRUE), digits), "]; "
				, round(mean(vals, na.rm = TRUE), digits), " ("
				, round(sd(vals, na.rm = TRUE), digits), ")"
			)
		} else{
			df_summary[["Type"]][[i]] <- "categorical"
			df_summary[["Variable"]][[i]] <- vars[[i]]
			perc <- sort(round(prop.table(table(vals))*100, digits)
				, decreasing = TRUE
			)
			if (missing(output) | sum(output %in% "simple") > 0){
				perc <- paste0(names(perc), " (", perc, "%)")
				df_summary[["Summary"]][[i]] <- paste0(perc
					, collapse = "; \n"
				)
			} else{
				perc <- paste0(names(perc), " (", perc, "\\%)")
				df_summary[["Summary"]][[i]] <- paste0(perc
					, collapse = "; \\\\  & & "
				)
			}
		}
	}
	return(df_summary)
}


