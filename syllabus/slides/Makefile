ALL_MD = $(wildcard ../*.md) $(DST_RMD)
EXCLUDE_MD = ../capstone.md ../index.md ../shell-03-shortcuts.md ../shell-00-intro.md ../git-01-backup_karl_notes.md
SRC_MD = $(filter-out $(EXCLUDE_MD),$(ALL_MD))

## slides   : Make slides with challenges
DST_SLIDES_RMD = $(patsubst ../%.md,%_slides.Rmd,$(SRC_MD))
DST_SLIDES_HTML = $(patsubst %_slides.Rmd,%_slides.html,$(DST_SLIDES_RMD))

slides: $(DST_SLIDES_HTML)

%_slides.html: %_slides.Rmd
	R -e "rmarkdown::render('$(<F)')"

%_slides.Rmd: ../%.md
	ruby grab_challenges.rb $(<F)
