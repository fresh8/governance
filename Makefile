readme: ## Generate Table of Contents
	adr generate toc -i README-tmpl.md > README.md -p doc/
	sed -i -e 1,2d README.md # Remove the forced title from adr tool
	rm README.md-e # Clean up tmp file
