INSERT INTO med_exam_reg (
  usr_id
  , exam_id
  , org_reg_id
  , exam_reg_id
  , wait_tm_by_sq
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