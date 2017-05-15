all: 2013_2016_clean.diff

2016-Scrum-Guide-US.pdf:
	curl --remote-name --silent --show-error http://www.scrumguides.org/docs/scrumguide/v2016/$@

2013-Scrum-Guide-US.pdf:
	curl --output $@ --silent --show-error http://www.scrumguides.org/docs/scrumguide/v1/Scrum-Guide-US.pdf

Scrum-Guide-FR.pdf:
	curl --output $@ --silent --show-error http://www.scrumguides.org/docs/scrumguide/v1/$@

%.txt: %.pdf
	pdftotext $< - | sed -e 's/\f//' -e 's:due to th e:due to the:' -e 's:time -box:time-box:' -e 's:goal \.:goal.:' -e 's:coul d:could:' > $@ 

2013_2016.diff: 2013-Scrum-Guide-US.txt 2016-Scrum-Guide-US.txt
	diff -u $? >$@

2013_2016_clean.diff: 2013_2016.diff
	sed -e "s@.©201. Scrum.Org and ScrumInc. Offered for license under the Attribution Share-Alike license of Creative Commons@@" \
		-e "s@.accessible at http://creativecommons.org/licenses/by.*-sa/4.0/legalcode and also described in summary form at@@" \
		-e "s@.http://creativecommons.org/licenses/by.*-sa/4.0/. By utilizing this Scrum Guide you acknowledge and agree that you@@" \
		-e "s@have read and agree to be bound by the terms of the Attribution Share-Alike license of Creative Commons.@@" $< >$@
	sed -i -e '/^\s*$$/d' -e '/^[+-]$$/d' $@

all: 2013_2016_clean.diff

clean:
	@rm -f 2013-Scrum-Guide-US.txt
	@rm -f 2016-Scrum-Guide-US.txt
	@rm -f 2013_2016.diff
	@rm -f 2013_2016_clean.diff
	@rm -f 2013-Scrum-Guide-US.pdf
	@rm -f 2016-Scrum-Guide-US.pdf
	@rm -f Scrum-Guide-FR.pdf
	@rm -f Scrum-Guide-FR.txt
