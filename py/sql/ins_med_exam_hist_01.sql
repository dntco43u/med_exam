INSERT INTO med_exam_hist (
  usr_id
  , exam_id
  , exam_b_gb_cd
  , exam_tm
  , exam_sch_gb_cd
  , drg_adm_cls_cd
  , tm_err
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
  , current_database()
  )