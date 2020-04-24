-- begin query that extracts the data
SELECT
    MAX(mrn) AS mrn
  , MAX(subject_id) AS subject_id
  , MAX(hadm_id) AS hadm_id
  , MAX(stay_id) AS stay_id
  , MAX(charttime) AS charttime
  , le.spec_id
  -- convert from itemid into a meaningful column
  , MAX(CASE WHEN itemid = 51002 THEN value ELSE NULL END) AS troponin_i
  , MAX(CASE WHEN itemid = 52598 THEN value ELSE NULL END) AS troponin_i_poc
  , MAX(CASE WHEN itemid = 51003 THEN value ELSE NULL END) AS troponin_t
  , MAX(CASE WHEN itemid = 50911 THEN valuenum ELSE NULL END) AS ck_mb
FROM mimic_covid_hosp_phi.labevents le
WHERE le.itemid IN
(
    51002, -- Troponin I
    52598, -- Troponin I, point of care
    51003, -- Troponin T
    50911  -- Creatinine Kinase, MB isoenzyme
)
GROUP BY le.spec_id
ORDER BY mrn, charttime;
