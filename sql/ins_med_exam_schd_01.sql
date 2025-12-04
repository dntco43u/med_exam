INSERT INTO med_exam_schd (
  exam_id
  , exam_tm
  , drg_adm_tm
  , alwd_tm_blod_clct
  , schd_prd
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
  , current_database()
  )