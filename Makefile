default:
	make serve

serve:
	mkdocs serve --verbose

build:
	mkdocs build --clean

build_verbose:
	mkdocs build --clean --verbose

# pip install pandoc-latex-admonition (https://github.com/chdemko/pandoc-latex-admonition)
# https://github.com/chdemko/pandoc-latex-admonition/issues/1
CURRENT_VERSION := $(shell grep -Po '(Specification version: \`)\K([0-9]|\.)*' docs/spec/index.md)
prepare_pd:
	@echo Running in ${CURDIR}
	mkdocscombine --outfile erc.pd --no-titles --admonitions-md --verbose
	# fix image paths
	sed -i 's:/img/:docs/img/:g' erc.pd
	# remove unwanted content: nothing after the first user guide, nothing before the spec title (first occurence)
	#sed -i '/User\ guide:\ ERC\ creation/Q' erc.pd
	#sed -n -i '/ERC\ specification/,$$p' erc.pd
	# add config for admonitions:
	cat docs/admonition_config.yml erc.pd > erc.tmp
	mv erc.tmp erc.pd

pdf: prepare_pd
	pandoc --toc -f markdown+grid_tables+table_captions -V colorlinks --include-before-body docs/pdf_cover.tex --highlight-style pygments --output erc-spec-v${CURRENT_VERSION}.pdf --latex-engine=xelatex --filter pandoc-latex-admonition erc.pd
	rm erc.pd

travis_pdf: prepare_pd
	mv erc.pd site/
	pandoc --toc -f markdown+grid_tables+table_captions -V colorlinks --include-before-body docs/pdf_cover.tex --include-in-header docs/pdf_header.tex --highlight-style pygments --output erc-spec-v${CURRENT_VERSION}.pdf --latex-engine=xelatex --filter pandoc-latex-admonition erc.pd
	mv erc-spec*.pdf site/

# fiware/md2pdf and pdftk
pdf_md2pdf:
	docker run -v ${CURDIR}:/md2pdf fiware/md2pdf --input /md2pdf/mkdocs.yml --output /md2pdf/spectmp.pdf
	pdftk spectmp.pdf cat 2-end output erc-spec-v${CURRENT_VERSION}.pdf
	rm spectmp.pdf
