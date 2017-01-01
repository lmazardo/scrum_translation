2016-Scrum-Guide-US.pdf:
	curl --remote-name --silent --show-error http://www.scrumguides.org/docs/scrumguide/v2016/$@

2013-Scrum-Guide-US.pdf:
	curl --output $@ --silent --show-error http://www.scrumguides.org/docs/scrumguide/v1/Scrum-Guide-US.pdf

%.txt: %.pdf
	pdftotext $< $@
