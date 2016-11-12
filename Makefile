SOURCES = $(shell echo *.md)
HTMLS = $(SOURCES:%.md=html/%.html)
PDFS = $(SOURCES:%.md=pdf/%.pdf)
DPI := $(shell xrdb -q | grep dpi | egrep -o "[0-9]+")

all: $(HTMLS)

pdf: $(PDFS)

html/%.html: %.md
	mkdir -p html
	pandoc $< -f markdown -t html -c css/bootstrap.css -c css/style.css -c css/font-awesome.css -s --toc -o $@

pdf/%.pdf: html/%.html
	mkdir -p pdf/`dirname $<`
	echo 'Xft.dpi: 96' | xrdb -override
	wkhtmltopdf --enable-internal-links -s b5 $< $@
	echo 'Xft.dpi: $(DPI)' | xrdb -override

clean:
	rm $(HTMLS) $(PDFS)
