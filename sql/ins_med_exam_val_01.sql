INSERT INTO med_exam_val (
  val_id
  , val_nm
  , exam_a_gb_cd
  , exam_b_gb_cd
  , min_val_yn
  , link
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