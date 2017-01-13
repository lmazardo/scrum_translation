2016-Scrum-Guide-US.pdf:
	curl --remote-name --silent --show-error http://www.scrumguides.org/docs/scrumguide/v2016/$@

2013-Scrum-Guide-US.pdf:
	curl --output $@ --silent --show-error http://www.scrumguides.org/docs/scrumguide/v1/Scrum-Guide-US.pdf

%.txt: %.pdf
	pdftotext $< $@

2013_2016.diff: 2013-Scrum-Guide-US.txt 2016-Scrum-Guide-US.txt
	diff -u $? >$@

2013_2016.clean_diff: 2013_2016.diff
	sed -e "s@.©201. Scrum.Org and ScrumInc. Offered for license under the Attribution Share-Alike license of Creative Commons@@" \
		-e "s@.accessible at http://creativecommons.org/licenses/by.*-sa/4.0/legalcode and also described in summary form at@@" \
		-e "s@.http://creativecommons.org/licenses/by.*-sa/4.0/. By utilizing this Scrum Guide you acknowledge and agree that you@@" \
		-e "s@have read and agree to be bound by the terms of the Attribution Share-Alike license of Creative Commons.@@" $< >$@
	sed -i -e '/^\s*$$/d' -e '/^[+-]$$/d' $@

clean:
	@rm 2013-Scrum-Guide-US.txt
	@rm 2016-Scrum-Guide-US.txt
	@rm 2013_2016.diff
	@rm 2013_2016.clean_diff
