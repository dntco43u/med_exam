INSERT INTO med_exam_map (
  exam_id
  , map_gb_cd
  , cd_k
  , cd_v
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