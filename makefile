CURL=curl
CURL_FLAGS=--silent --show-error --location

all: 2013_2016_clean.diff 2013-Scrum-Guide-FR.txt

2016-Scrum-Guide-US.pdf:
	@echo "fetching $@"
	@$(CURL) $(CURL_FLAGS) --remote-name http://www.scrumguides.org/docs/scrumguide/v2016/$@

2013-Scrum-Guide-US.pdf:
	@echo "fetching $@"
	@$(CURL) $(CURL_FLAGS) --output $@ http://www.scrumguides.org/docs/scrumguide/v1/Scrum-Guide-US.pdf

2013-Scrum-Guide-FR.pdf:
	@echo "fetching $(subst 2013-,,$@)"
	@$(CURL) $(CURL_FLAGS) --output $@ http://www.scrumguides.org/docs/scrumguide/v1/$(subst 2013-,,$@)

%.txt: %.pdf
	@echo "converting $< to $@"
	@pdftotext $< - | sed -e 's/\f//' -e 's:due to th e:due to the:' -e 's:time -box:time-box:' -e 's:goal \.:goal.:' -e 's:coul d:could:' > $@

2013_2016.diff: 2013-Scrum-Guide-US.txt 2016-Scrum-Guide-US.txt
	@echo "generating $@ (diff between $?)"
	@diff -u $? | cat > $@

2013_2016_clean.diff: 2013_2016.diff
	@echo "remove useless diff from $? in $@"
	@sed -e "s@.©201. Scrum.Org and ScrumInc. Offered for license under the Attribution Share-Alike license of Creative Commons@@" \
		-e "s@.accessible at http://creativecommons.org/licenses/by.*-sa/4.0/legalcode and also described in summary form at@@" \
		-e "s@.http://creativecommons.org/licenses/by.*-sa/4.0/. By utilizing this Scrum Guide you acknowledge and agree that you@@" \
		-e "s@have read and agree to be bound by the terms of the Attribution Share-Alike license of Creative Commons.@@" $< >$@
	@sed -i -e '/^\s*$$/d' -e '/^[+-]$$/d' $@

clean:
	@rm -f 2013-Scrum-Guide-US.txt
	@rm -f 2016-Scrum-Guide-US.txt
	@rm -f 2013_2016.diff
	@rm -f 2013_2016_clean.diff
	@rm -f 2013-Scrum-Guide-US.pdf
	@rm -f 2016-Scrum-Guide-US.pdf
	@rm -f 2013-Scrum-Guide-FR.pdf
	@rm -f 2013-Scrum-Guide-FR.txt
