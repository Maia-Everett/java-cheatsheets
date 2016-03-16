SOURCES = $(shell echo *.md)
HTMLS = $(SOURCES:%.md=html/%.html)
PDFS = $(SOURCES:%.md=pdf/%.pdf)

all: $(HTMLS)

pdf: $(PDFS)

html/%.html: %.md
	mkdir -p html
	pandoc $< -f markdown -t html -c css/bootstrap.css -c css/style.css -c css/font-awesome.css -s --toc -o $@

pdf/%.pdf: html/%.html
	mkdir -p pdf
	wkhtmltopdf --enable-internal-links --zoom 0.8 $< $@

clean:
	rm $(HTMLS) $(PDFS)
