default:
	make serve

serve:
	mkdocs serve --verbose --dev-addr localhost:8001

build:
	mkdocs build --clean
	make clean_newpage_html

build_verbose:
	mkdocs build --clean --verbose
	make clean_newpage_html

clean_newpage_html:
	# remove \newpage paragraphs from HTML
	find ./site -type f -name '*.html' -exec sed -i -e 's|<p>\\newpage</p>||g' {} \;

# pip install pandoc-latex-admonition (https://github.com/chdemko/pandoc-latex-admonition)
# https://github.com/chdemko/pandoc-latex-admonition/issues/1
CURRENT_VERSION := $(shell grep -Po '(Specification version: \`)\K([0-9]|\.)*' docs/spec/index.md)
VCS_REF := $(shell git rev-parse --short HEAD)
CURRENT_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
SPEC_FILE_NAME_PDF := $(shell echo erc-spec-v`grep -Po '(Specification version: \`)\K([0-9]|\.)*' docs/spec/index.md`.pdf)
SPEC_FILE_NAME_MD  := $(shell echo erc-spec-v`grep -Po '(Specification version: \`)\K([0-9]|\.)*' docs/spec/index.md`.md)

prepare_md:
	mkdocscombine --outfile erc.md --no-titles --verbose
	# fix image paths
	sed -i 's:/img/:docs/img/:g' erc.md
	# remove unwanted content: nothing after the first user guide
	sed -i '/User\ guide:\ ERC\ creation/Q' erc.md
	# BROKEN: remove unwanted content: nothing before the spec title
	#sed -n -i '/ERC\ specification/,$$p' erc.pd
	#sed -i '/ERC\ specification/,$$!d' erc.pd
	# remove multiple empty lines:
	sed -i 'N;/^\n$$/D;P;D;' erc.md

prepare_md_for_pdf:
	mkdocscombine --outfile erc.tmp --no-titles --admonitions-md --verbose
	# fix image paths
	sed -i 's:/img/:docs/img/:g' erc.tmp
	# remove unwanted content: nothing after the first user guide
	sed -i '/User\ guide:\ ERC\ creation/Q' erc.tmp
	# BROKEN: remove unwanted content: nothing before the spec title
	#sed -n -i '/ERC\ specification/,$$p' erc.pd
	#sed -i '/ERC\ specification/,$$!d' erc.pd
	# remove multiple empty lines:
	sed -i 'N;/^\n$$/D;P;D;' erc.tmp
	# update dates
	sed -i 's/@@VERSION@@/${VCS_REF}/g' erc.tmp
	sed -i 's/@@TIMESTAMP@@/${CURRENT_DATE}/g' erc.tmp
	# add config for admonitions:
	cat docs/admonition_config.yml erc.tmp > erc.tmp2
	mv erc.tmp2 erc.tmp

pdf: prepare_md_for_pdf
	pandoc --toc -f markdown -V colorlinks --include-before-body docs/pdf_cover.tex --highlight-style pygments --output ${SPEC_FILE_NAME_PDF} --pdf-engine=xelatex --filter pandoc-latex-admonition erc.tmp
	rm erc.tmp

travis_pdf: prepare_md_for_pdf
	# update version in cover page
	sed -i 's/@@VCSREF@@/${VCS_REF}/g' docs/pdf_cover.tex
	# create PDF
	pandoc --toc -f markdown -V colorlinks --include-before-body docs/pdf_cover.tex --highlight-style pygments --output ${SPEC_FILE_NAME_PDF} --filter pandoc-latex-admonition --verbose erc.tmp
	mv erc-spec*.pdf site/
	# create unversioned file for current spec PDF
	cp `ls site/erc-spec-v*.pdf | sort | tail -n 1` site/erc-spec.pdf
	rm erc.tmp

local_pdf: prepare_md_for_pdf
	pandoc --toc -f markdown -V colorlinks --include-before-body docs/pdf_cover.tex --highlight-style pygments --output ${SPEC_FILE_NAME_PDF} --filter pandoc-latex-admonition erc.tmp
	rm erc.tmp

# publish a single file Markdown version of the spec
travis_md: prepare_md
	sed -i 's/@@VERSION@@/${VCS_REF}/g' erc.md
	sed -i 's/@@TIMESTAMP@@/${CURRENT_DATE}/g' erc.md
	mv erc.md site/${SPEC_FILE_NAME_MD}
	cp `ls site/erc-spec-v*.md | sort | tail -n 1` site/erc-spec.md
