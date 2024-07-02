inkscape --export-png=06-rmd-inequality.0.png 06-rmd-inequality.0.svg
# use ImageMagick to grab top and bottom halves
# (surely there's a better way ... too much space at the bottom of the first)
convert 06-rmd-inequality.0.png -crop 100%x50% tmp.png
mv tmp-0.png 06-rmd-inequality.1.png
mv tmp-1.png 06-rmd-inequality.2.png

