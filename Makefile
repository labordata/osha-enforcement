osha_enforcement.db : inspection.csv violation.csv accident.csv		\
                      accident_abstract.csv accident_injury.csv		\
                      optional_info.csv related_activity.csv		\
                      strategic_codes.csv violation_event.csv		\
                      violation_gen_duty_std.csv event_type.csv		\
                      fatality.csv operator.csv environmental.csv	\
                      human.csv injury.csv occupation.csv		\
                      body_part.csv injury_source.csv			\
                      degree_injury.csv task.csv project_type.csv	\
                      end_use.csv cost.csv
	csvs-to-sqlite $(word 1, $^) $@
	csvs-to-sqlite $(word 2, $^) $@
	csvs-to-sqlite $(wordlist 3, $(words $^), $^) $@
	sqlite-utils transform $@ accident --pk summary_nr
	sqlite-utils transform $@ inspection --pk activity_nr
	sqlite-utils transform $@ event_type --pk accident_number
	sqlite-utils transform $@ fatality --pk accident_number
	sqlite-utils transform $@ operator --pk accident_number
	sqlite-utils transform $@ environmental --pk accident_number
	sqlite-utils transform $@ human --pk accident_number
	sqlite-utils transform $@ injury --pk accident_number
	sqlite-utils transform $@ occupation --pk accident_number
	sqlite-utils transform $@ body_part --pk accident_number
	sqlite-utils transform $@ injury_source --pk accident_number
	sqlite-utils transform $@ degree_injury --pk accident_number
	sqlite-utils transform $@ task --pk accident_number
	sqlite-utils transform $@ project_type --pk accident_letter
	sqlite-utils transform $@ end_use --pk accident_letter
	sqlite-utils transform $@ cost --pk accident_letter
	sqlite-utils add-foreign-keys $@ \
            accident project_type project_type accident_letter \
            accident const_end_use end_use accident_letter \
            accident project_cost cost accident_letter \
            accident_abstract summary_nr accident summary_nr \
            accident_injury summary_nr accident summary_nr \
            accident_injury rel_insp_nr inspection activity_nr \
            accident_injury fat_cause fatality accident_number \
            accident_injury const_op_cause operator accident_number \
            accident_injury const_op operator accident_number \
            accident_injury evn_factor environmental accident_number \
            accident_injury event_type event_type accident_number \
            accident_injury hum_factor human accident_number \
            accident_injury nature_of_inj injury accident_number \
            accident_injury occ_code occupation accident_number \
            accident_injury part_of_body body_part accident_number \
            accident_injury src_of_injury injury_source accident_number \
            accident_injury degree_of_inj degree_injury accident_number \
            accident_injury task_assigned task accident_number \
            optional_info activity_nr inspection activity_nr \
            related_activity activity_nr inspection activity_nr \
            strategic_codes activity_nr inspection activity_nr \
            violation activity_nr inspection activity_nr \
            violation_event activity_nr violation activity_nr \
            violation_gen_duty_std activity_nr violation activity_nr

event_type.csv : accident_lookup2.csv
	csvgrep -c accident_code -m FT $< > $@

fatality.csv : accident_lookup2.csv
	csvgrep -c accident_code -m CAUS $< > $@

operator.csv : accident_lookup2.csv
	csvgrep -c accident_code -m OPER $< > $@

environmental.csv : accident_lookup2.csv
	csvgrep -c accident_code -m EN $< > $@

human.csv : accident_lookup2.csv
	csvgrep -c accident_code -m HU $< > $@

injury.csv : accident_lookup2.csv
	csvgrep -c accident_code -m IN $< > $@

occupation.csv : accident_lookup2.csv
	csvgrep -c accident_code -m OCC $< > $@

body_part.csv : accident_lookup2.csv
	csvgrep -c accident_code -m BD $< > $@

injury_source.csv : accident_lookup2.csv
	csvgrep -c accident_code -m SO $< > $@

cost.csv : accident_lookup2.csv
	csvgrep -c accident_code -m COST $< > $@

end_use.csv : accident_lookup2.csv
	csvgrep -c accident_code -m ENDU $< > $@

project_type.csv : accident_lookup2.csv
	csvgrep -c accident_code -m PTYP $< > $@

degree_injury.csv : accident_lookup2.csv
	csvgrep -c accident_code -m DEGR $< > $@

task.csv : accident_lookup2.csv
	csvgrep -c accident_code -m TASK $< > $@

%.csv : osha_%.csv.zip
	unzip $<
	csvstack `zipinfo -1 $<` > $@

%.csv.zip : data_summary.php
	wget -O $@ `grep -E $*_[0-9]+.csv.zip data_summary.php | perl -pe 's/^.*?<a href="(.*$*_\d+.csv.zip)".*/\1/'`

data_summary.php :
	curl 'https://enforcedata.dol.gov/views/data_summary.php' -X POST --data-raw 'agency=osha' > $@
