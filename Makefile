osha_enforcement.db : accident.csv accident_abstract.csv	\
                      accident_injury.csv accident_lookup2.csv	\
                      inspection.csv optional_info.csv		\
                      related_activity.csv strategic_codes.csv	\
                      violation.csv violation_event.csv		\
                      violation_gen_duty_std.csv
	csvs-to-sqlite $^ $@
	sqlite-utils transform $@ accident --pk summary_nr
	sqlite-utils transform $@ inspection --pk activity_nr
	sqlite-utils add-foreign-keys $@ \
            accident_abstract summary_nr accident summary_nr \
            accident_injury summary_nr accident summary_nr \
            accident_injury rel_insp_nr inspection activity_nr \
            optional_info activity_nr inspection activity_nr \
            related_activity activity_nr inspection activity_nr \
            strategic_codes activity_nr inspection activity_nr \
            violation activity_nr inspection activity_nr \
            violation_event activity_nr violation activity_nr \
            violation_gen_duty_std activity_nr violation activity_nr

%.csv : osha_%.csv.zip
	unzip $<
	csvstack `zipinfo -1 $<` > $@

%.csv.zip : data_summary.php
	wget -O $@ `grep -E $*_[0-9]+.csv.zip data_summary.php | perl -pe 's/^.*?<a href="(.*$*_\d+.csv.zip)".*/\1/'`

data_summary.php :
	curl 'https://enforcedata.dol.gov/views/data_summary.php' -X POST --data-raw 'agency=osha' > $@
