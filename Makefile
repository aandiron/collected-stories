# NOTE: this file has been modified by A. Andiron from the original source
BUILD = build
BOOKNAME = EroticaToWorryYourLover
# This BOOKNAME variable is the output file name, not the title
TITLE = title.txt
METADATA = metadata.xml
# Metadata is a part of the epub standard, even if it repeats stuff in the title file
CHAPTERS = chapters/introduction.md chapters/Tremble_the_Flowering_Wood.md chapters/spit-blood-and-suck.md
# Chapters should be space separated, but apparently have to be on a single line.
TOC = --toc --toc-depth=2
# uncomment above line if you want a TOC; and uncomment pandoc lines below that includes TOC; comment line that doesn't
COVER_IMAGE = cover/cover-final.jpg
# I think the cover pic works better if you use a .png or a .jpg
# But upload a .tif to Amazon's cover pic
LATEX_CLASS = report
CSS = epub.css

all: book

book: epub html pdf

clean:
	rm -r $(BUILD)

epub: $(BUILD)/epub/$(BOOKNAME).epub

html: $(BUILD)/html/$(BOOKNAME).html

pdf: $(BUILD)/pdf/$(BOOKNAME).pdf

$(BUILD)/epub/$(BOOKNAME).epub: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/epub
	pandoc --from markdown+smart $(TOC) --epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^
#	above with TOC
#	pandoc --epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^

$(BUILD)/html/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)/html
	pandoc --from markdown+smart $(TOC) --to=html5 -o $@ $^
#	above with TOC
#	pandoc --to=html5 -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
	pandoc --from markdown+smart --pdf-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^
#	above with TOC
#	pandoc $(TOC) --pdf-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf
