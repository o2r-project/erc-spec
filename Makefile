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
VCS_REF := $(shell git rev-parse --short HEAD)
CURRENT_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
SPEC_FILE_NAME := $(shell echo erc-spec-v`grep -Po '(Specification version: \`)\K([0-9]|\.)*' docs/spec/index.md`.pdf)
prepare_pd:
	@echo Running in ${CURDIR}
	mkdocscombine --outfile erc.pd --no-titles --admonitions-md --verbose
	# fix image paths
	sed -i 's:/img/:docs/img/:g' erc.pd
	# remove unwanted content: nothing after the first user guide
	sed -i '/User\ guide:\ ERC\ creation/Q' erc.pd
	# BRORKEN: remove unwanted content: nothing before the spec title
	#sed -n -i '/ERC\ specification/,$$p' erc.pd
	#sed -i '/ERC\ specification/,$$!d' erc.pd
	# add config for admonitions:
	cat docs/admonition_config.yml erc.pd > erc.tmp
	# remove multiple empty lines:
	sed -i 'N;/^\n$$/D;P;D;' erc.tmp
	mv erc.tmp erc.pd

update_version:
	sed -i 's/___VCS_REF___/${VCS_REF}/g' docs/pdf_cover.tex

update_version_in_pdf:
	sed -i 's/@@VERSION@@/${VCS_REF}/g' erc.pd
	sed -i 's/@@TIMESTAMP@@/${CURRENT_DATE}/g' erc.pd

pdf: prepare_pd update_version_in_pdf
	pandoc --toc -f markdown -V colorlinks --include-before-body docs/pdf_cover.tex --highlight-style pygments --output ${SPEC_FILE_NAME} --latex-engine=xelatex --filter pandoc-latex-admonition erc.pd
	rm erc.pd

travis_pdf: prepare_pd update_version_in_pdf update_version
	cp erc.pd site/
	pandoc --toc -f markdown -V colorlinks --include-before-body docs/pdf_cover.tex --highlight-style pygments --output ${SPEC_FILE_NAME} --latex-engine=xelatex --filter pandoc-latex-admonition --verbose erc.pd
	mv erc-spec*.pdf site/
	# create unversioned file for current spec PDF
	cp $(shell ls site/erc-spec-v*.pdf | sort | tail -n 1) site/erc-spec.pdf
	rm erc.pd

# fiware/md2pdf and pdftk
pdf_md2pdf:
	docker run -v ${CURDIR}:/md2pdf fiware/md2pdf --input /md2pdf/mkdocs.yml --output /md2pdf/spectmp.pdf
	pdftk spectmp.pdf cat 2-end output erc-spec-v${CURRENT_VERSION}.pdf
	rm spectmp.pdf
