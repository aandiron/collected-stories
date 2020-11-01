# NOTE: this file has been modified by A. Andiron from the original source
BUILD = build
BOOKNAME = EroticaToMakeYourLoverWonder
# This BOOKNAME variable is the output file name, not the title
TITLE = title.txt
METADATA = metadata.xml
# Metadata is a part of the epub standard, even if it repeats stuff in the title file
CHAPTERS = chapters/0.Introduction_collected-stories.md chapters/1.Kraken_collected-stories.md chapters/2.Take-Off-Go-Around_collected-stories.md chapters/3.As-If-It-Isnt-Even-Difficult-To-Do_collected-stories.md chapters/4.La-Cappella_collected-stories.md chapters/5.How-To-Tie-A-Handcuff-Knot_collected-stories.md chapters/6.The-Ride-Home_collected-stories.md chapters/7.Tremble-the-Flowering-Wood_collected-stories.md chapters/8.Its-Your-Birthday_collected-stories.md chapters/9.A-Permanent-Sad-Fantasy_collected-stories.md chapters/10.Chinese-Finger-Trap_collected-stories.md chapters/11.Spit-Blood-And-Suck_collected-stories.md chapters/12.Binding-Off_collected-stories.md chapters/13.Listen-To-The-Music_collected-stories.md chapters/14.Arrival_collected-stories.md
# Chapters should be space separated, but apparently have to be on a single line.
TOC = --toc --toc-depth=1
# uncomment above line if you want a TOC; and uncomment pandoc lines below that includes TOC; comment line that doesn't
COVER_IMAGE = cover/AAndiron_Collected-Stories_book-cover.png
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
	pandoc --css=$(CSS) --from markdown+smart $(TOC) --epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^

$(BUILD)/html/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)/html
	pandoc --from markdown+smart $(TOC) --to=html5 -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
	pandoc --from markdown+smart $(TOC) --pdf-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf
