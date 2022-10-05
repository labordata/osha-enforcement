BEGIN;

CREATE TABLE "violation" (
  "activity_nr" INTEGER,
  "citation_id" TEXT,
  "delete_flag" TEXT,
  "standard" TEXT,
  "viol_type" TEXT,
  "issuance_date" TEXT,
  "abate_date" TEXT,
  "abate_complete" TEXT,
  "current_penalty" REAL,
  "initial_penalty" REAL,
  "contest_date" TEXT,
  "final_order_date" TEXT,
  "nr_instances" INTEGER,
  "nr_exposed" INTEGER,
  "rec" TEXT,
  "gravity" INTEGER,
  "emphasis" TEXT,
  "hazcat" TEXT,
  "fta_insp_nr" INTEGER,
  "fta_issuance_date" TEXT,
  "fta_penalty" REAL,
  "fta_contest_date" TEXT,
  "fta_final_order_date" TEXT,
  "hazsub1" TEXT,
  "hazsub2" TEXT,
  "hazsub3" TEXT,
  "hazsub4" TEXT,
  "hazsub5" TEXT,
  "load_dt" TEXT
);

.mode csv
.import /dev/stdin violation


END;
