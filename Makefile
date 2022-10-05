osha.db : accident.csv accident_abstract.csv accident_injury.csv	\
          accident_lookup2.csv inspection.csv metadata.csv		\
          optional_info.csv related_activity.csv strategic_codes.csv	\
          violation.csv violation_event.csv				\
          violation_gen_duty_std.csv
	csvs-to-sqlite $^ $@


%.csv : osha_%.csv.zip
	unzip $<
	csvstack `zipinfo -1 $<` > $@

%.csv.zip : data_summary.php
	wget -O $@ `grep -E $*_[0-9]+.csv.zip data_summary.php | perl -pe 's/^.*?<a href="(.*$*_\d+.csv.zip)".*/\1/'`

data_summary.php :
	curl 'https://enforcedata.dol.gov/views/data_summary.php' -X POST --data-raw 'agency=osha' > $@
