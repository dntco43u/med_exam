INSERT INTO med_exam_ucd (
  usr_id
  , usr_hist_cd
  , base_tm
  , val
  , remark
  , reg_usr
  )
VALUES (
  %s
  , %s
  , %s
  , %s
  , %s
  , current_database()
  )