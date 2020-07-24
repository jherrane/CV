NAME=cv
TEXOUT=output
TEX=pdflatex
TEXFLAGS=-output-directory $(TEXOUT) -halt-on-error

# Default target, build the pdf
default: $(NAME).pdf
	
# Target 'all', compile .tex with BibTeX
all: $(TEXOUT)/$(NAME).bbl $(NAME).pdf
.phony: all

# Build the pdf by running the typesetter twice
$(NAME).pdf: $(NAME).tex
	mkdir -p $(TEXOUT)
	$(TEX) $(TEXFLAGS) $(NAME).tex
	$(TEX) $(TEXFLAGS) $(NAME).tex
	cp $(TEXOUT)/$(NAME).pdf .

clean:
	rm -rf $(NAME).pdf
	rm -rf $(TEXOUT)
	rm -rf $(NAME).aux
	rm -rf $(NAME).log
	rm -rf $(NAME).synctex.gz
.phony: clean

veryclean:
	rm -rf $(NAME).pdf
	rm -rf $(NAME).aux
	rm -rf $(NAME).log
	rm -rf $(NAME).synctex.gz
	rm -rf $(NAME).toc
	rm -rf $(NAME).blg
	rm -rf $(NAME).out
	rm -rf $(NAME).bbl
	rm -rf $(NAME).bib.bak
	rm -rf Images/*.aux
	rm -rf Images/*.log
	rm -rf Images/*.synctex.gz
	rm -rf output
.phony: veryclean
