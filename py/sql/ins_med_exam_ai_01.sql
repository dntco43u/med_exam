INSERT INTO med_exam_ai (
  usr_id
  , model
  , exam_ymd
  , req
  , res
  , res_ko
  , p_tokens
  , p_temp
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
  , %s
  , current_database()
  )