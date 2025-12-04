INSERT INTO med_exam_rslt (
  usr_id
  , exam_id
  , val_id
  , rslt_tm
  , val_rslt
  , grdng_cd
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
  , current_database()
  )