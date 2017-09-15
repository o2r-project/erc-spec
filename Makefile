default:
	make serve

serve:
	mkdocs serve --verbose

build:
	mkdocs build --clean

build_verbose:
	mkdocs build --clean --verbose

pdf_epub:
	mkdocs2pandoc > erc.pd
	pandoc --toc -f markdown+grid_tables+table_captions -o erc-specification.pdf erc.pd
	pandoc --toc -f markdown+grid_tables -t epub -o erc-specifiction.epub erc.pd

.PHONY: build serve pdf_epub default