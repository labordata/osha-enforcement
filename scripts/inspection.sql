BEGIN;

CREATE TABLE "inspection" (
   [activity_nr] INTEGER PRIMARY KEY,
   [reporting_id] INTEGER,
   [state_flag] INTEGER,
   [estab_name] TEXT,
   [site_address] TEXT,
   [site_city] TEXT,
   [site_state] TEXT,
   [site_zip] INTEGER,
   [owner_type] TEXT,
   [owner_code] INTEGER,
   [adv_notice] TEXT,
   [safety_hlth] TEXT,
   [sic_code] INTEGER,
   [naics_code] INTEGER,
   [insp_type] TEXT,
   [insp_scope] TEXT,
   [why_no_insp] TEXT,
   [union_status] TEXT,
   [safety_manuf] TEXT,
   [safety_const] TEXT,
   [safety_marit] TEXT,
   [health_manuf] TEXT,
   [health_const] TEXT,
   [health_marit] TEXT,
   [migrant] TEXT,
   [mail_street] TEXT,
   [mail_city] TEXT,
   [mail_state] TEXT,
   [mail_zip] INTEGER,
   [host_est_key] TEXT,
   [nr_in_estab] INTEGER,
   [open_date] TEXT,
   [case_mod_date] TEXT,
   [close_conf_date] TEXT,
   [close_case_date] TEXT,
   [ld_dt] TEXT
);

.mode csv
.import --skip 1  /dev/stdin inspection


END;
