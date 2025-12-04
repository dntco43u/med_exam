INSERT INTO med_exam_desc (
  exam_id
  , exam_type_cd
  , phase
  , trgt_dss
  , exam_desc
  , client
  , prod_id
  , prod_nm
  , dosage
  , org_nm
  , org_dep
  , schd_stt_ymd
  , schd_end_ymd
  , prtcp_cnt
  , fee
  , exam_link
  , prod_link
  , remark
  , reg_usr
  )
VALUES (
  %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , %s
  , current_database()
  )