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
pdf:
	mkdocs2pandoc --outfile erc.pd
	# handle admonitions:
	sed -i 's:/img/:docs/img/:g' erc.pd
	sed -i 's/!!! warning/**Warning:**\n /g' erc.pd
	sed -i 's/!!! note/**Note:**\n /g' erc.pd
	sed -i 's/!!! tip "Example"/**Example:**\n /g' erc.pd
	sed -i 's/!!! tip/**Example:** /g' erc.pd
	# remove all leading whitespace (breaks code blocks but improves admonitions...)
	#sed -i 's/^[ \t]*//' erc.pd
	pandoc --toc -f markdown+grid_tables+table_captions -V colorlinks -o erc-spec-v${CURRENT_VERSION}.pdf erc.pd --latex-engine=xelatex --filter pandoc-latex-admonition
	# via HTML with a CSS file (pre, code { white-space: pre-wrap !important; }): works to have line breaks in code blocks
	#pandoc --toc -f markdown+grid_tables+table_captions -V colorlinks -t html5 --css pdf.css -o erc-spec-v${CURRENT_VERSION}.pdf erc.pd --latex-engine=xelatex --filter pandoc-latex-admonition --verbose
	rm erc.pd

pdf_travis:
	make pdf
	mv erc-spec*.pdf site/

# fiware/md2pdf and pdftk
pdf_md2pdf:
	docker run -v ${CURDIR}:/md2pdf fiware/md2pdf --input /md2pdf/mkdocs.yml --output /md2pdf/spectmp.pdf
	pdftk spectmp.pdf cat 2-end output erc-spec-v${CURRENT_VERSION}.pdf
	rm spectmp.pdf

# npm install -g markdown-pdf
#build_pdf:
#	markdown-pdf docs/spec/index.md --out spec.pdf