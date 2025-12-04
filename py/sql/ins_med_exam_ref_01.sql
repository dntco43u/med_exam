INSERT INTO med_exam_ref (
  exam_id
  , sex
  , val_id
  , val_unit
  , ref_min
  , ref_max
  , num_yn
  , ord
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
  , current_database()
  )