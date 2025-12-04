INSERT INTO med_exam_usr (
  usr_id
  , usr_nm
  , birth_ymd
  , sex
  , hght
  , wght
  , meal_gb_cd
  , exercise_st_cd
  , sleep_st_cd
  , daily_smok_cd
  , daily_alco_cd
  , daily_caff_cd
  , race_cd
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
  , current_database()
  )