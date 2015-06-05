# Check the knitr version is high enough to render
# code blocks embedded in blockquotes (i.e. challenges and tool tips).
version.string <- packageDescription("knitr")$Version
version.numbers <- as.integer(strsplit(version.string, "\\.")[[1]])
if (version.numbers[1] <= 1 & version.numbers[2] <= 10 & version.numbers[3] < 12)
  stop("knitr must be version 1.10.12 or higher")

