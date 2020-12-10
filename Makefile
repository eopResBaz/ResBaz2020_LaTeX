OUT = output
PAGES = pages
BIB = documentRef.bib
TEX = document.tex
PROJ = document
TEMPLATE = template

CLEAN_DIRS  = $(OUT) $(PAGES) .

clean : 
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.swp         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.aux         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.bbl         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.blg         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.fdb_latexmk )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.fls         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.log         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.out         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.pdf         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.gz          )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.toc         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.glo         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.glsdefs     )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.glsist      )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.ist         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.odt         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.4ct         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.4tc         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.bcf         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.dvi         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.idv         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.lg          )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.tmp         )
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.xref        )
	@ -rm -r $(OUT)/* || true 
	@ -mkdir $(OUT)

cleanpdf :
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.pdf )

cleanodt :
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.odt )

cleanword :
	@ -$(foreach dir, $(CLEAN_DIRS) , rm -f $(dir)/*.docx )

pdf :
	cp $(BIB) $(OUT)
	# natbib
	#pdflatex -output-directory $(OUT) $(TEX)
	#-cd $(OUT); bibtex $(PROJ)

	# bibTex
	pdflatex -output-directory $(OUT) $(TEX)
	-cd $(OUT); biber $(PROJ)
	-pdflatex -output-directory $(OUT) $(TEX)
	cp $(OUT)/*pdf .

ool:
	pandoc $(TEX) --biblio=$(BIB) -o ${OUT}/${PROJ}.odt --citeproc
	cp $(OUT)/${PROJ}.odt .

word:
	pandoc $(TEX) --biblio=$(BIB) -o ${OUT}/${PROJ}.docx --citeproc
	cp $(OUT)/${PROJ}.docx .

endnote:
	bib2xml $(BIB) | xml2end > ${OUT}/citations.enw