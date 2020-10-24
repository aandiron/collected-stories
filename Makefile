# NOTE: this file has been modified by A. Andiron from the original source
BUILD = build
BOOKNAME = A.Andiron_Collected-Stories
# This BOOKNAME variable is the output file name, not the title
TITLE = title.txt
# METADATA = metadata.xml
# I don't think this metadata file is necessary anymore. It's in the YAML in title.txt
CHAPTERS = chapters/Tremble_the_Flowering_Wood.md
# Arrival should be last. Include story for Caroline (with trigger warning) and story for heather.
# Change ``CHAPTERS`` to a space separated list of Pandoc Markdown chapters, in the order in which you want them to appear.
TOC = --toc --toc-depth=2
# uncomment above line if you want a TOC
COVER_IMAGE = cover/cover-final.png
# I think the cover pic works better if you use a .png
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
	pandoc $(TOC) ---css=$(CSS) -epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^
#	Below without TOC:
#	pandoc --css=$(CSS) --epub-cover-image=$(COVER_IMAGE) -o $@ $^

$(BUILD)/html/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)/html
	pandoc $(TOC) --to=html5 -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
	pandoc $(TOC) --pdf-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf
