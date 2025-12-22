SELECT 
  count(1) cnt
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd);

SELECT 
  count(1) cnt
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND grdng_cd = '001' ;

SELECT 
  count(1) cnt
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND grdng_cd = '002' ;

SELECT 
  count(1) cnt
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)  
  AND grdng_cd = '003' ;

SELECT 
  count(1) cnt
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)  
  AND grdng_cd = '004' ;

SELECT 
  count(1) cnt
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)  
  AND grdng_cd IN ('002', '003', '004');

SELECT (err_cnt / nullif(tot_cnt, 0)::FLOAT) * 100 per
FROM (
  SELECT count(1) tot_cnt
    , count(T6.usr_id) err_cnt
  FROM med_exam_rslt T1
  JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
  JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
    AND T2.sex = T3.sex
    AND T1.val_id = T3.val_id
  JOIN med_exam_val T4 ON T1.val_id = T4.val_id
  JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
  LEFT JOIN med_exam_rslt T6 ON T1.usr_id = T6.usr_id
    AND T1.exam_id = T6.exam_id
    AND T1.val_id = T6.val_id
    AND T1.rslt_tm = T6.rslt_tm
    AND T6.grdng_cd IN ('002', '003', '004')
  WHERE T1.usr_id = '$usr_id'
    AND T1.exam_id IN ($exam_id)
    AND to_char(T1.rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
    AND exam_a_gb_cd IN ($exam_a_gb_cd)
    AND exam_type_cd IN ($exam_type_cd)
    AND T1.grdng_cd IN ($grdng_cd)      
  )
;

SELECT count(1) cnt
FROM med_exam_hist T1
LEFT JOIN med_exam_schd T2 ON T1.exam_id = T2.exam_id
  AND T1.exam_tm = T2.exam_tm
JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
  AND T1.exam_id = T4.exam_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id    
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd);

SELECT count(1) cnt
FROM med_exam_hist T1
LEFT JOIN med_exam_schd T2 ON T1.exam_id = T2.exam_id
  AND T1.exam_tm = T2.exam_tm
JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
  AND T1.exam_id = T4.exam_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id    
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd)
  AND exam_b_gb_cd = '001';

SELECT count(1) || '일' cnt
FROM (
  SELECT to_char(T1.exam_tm, 'YYYYMMDD')
  FROM med_exam_hist T1
  LEFT JOIN med_exam_schd T2 ON T1.exam_id = T2.exam_id
    AND T1.exam_tm = T2.exam_tm
  JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
  JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
    AND T1.exam_id = T4.exam_id
  JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
  WHERE T1.usr_id = '$usr_id'
    AND T1.exam_id IN ($exam_id)
    AND exam_type_cd IN ($exam_type_cd)
    AND exam_b_gb_cd IN ($exam_b_gb_cd)
  GROUP BY to_char(T1.exam_tm, 'YYYYMMDD')
  )
;

SELECT coalesce(date_part('day', max(exam_tm) - min(exam_tm) + interval '1day')::varchar, '0') || '일간' cnt
FROM med_exam_hist T1
JOIN med_exam_reg T2 ON T1.usr_id = T2.usr_id
  AND T1.exam_id = T2.exam_id
JOIN med_exam_desc T3 ON T1.exam_id = T3.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd);

SELECT rnk
  , rslt_ymd
  , exam_a_gb
  , val_nm
  , val_rslt
  , val_per
  , CASE 
    WHEN val_per < 100
      AND min_val_yn = 'Y'
      THEN '×'
    ELSE '✓'
    END grdng
  , link
FROM (
  SELECT dense_rank() OVER (
      ORDER BY val_per
      ) rnk
    , rslt_ymd
    , val_nm
    , val_rslt
    , val_per
    , exam_a_gb
    , min_val_yn
    , link
  FROM (
    SELECT T4.val_nm
      , rtrim(val_rslt || ' ' || coalesce(val_unit, '')) val_rslt
      , (val_rslt::FLOAT / ref_min::FLOAT) * 100 val_per
      , to_char(rslt_tm, 'YYYY-MM-DD') rslt_ymd
      , com_cd_nm exam_a_gb
      , min_val_yn
      , link
    FROM med_exam_rslt T1
    JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
    JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
      AND T2.sex = T3.sex
      AND T1.val_id = T3.val_id
    JOIN med_exam_val T4 ON T1.val_id = T4.val_id
    JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
    JOIN com_cd T6 ON T4.exam_a_gb_cd = T6.com_cd
      AND T6.com_cd_id = 'M01'  
    WHERE T1.usr_id = '$usr_id'
      AND T1.exam_id IN ($exam_id)
      AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
      AND exam_a_gb_cd IN ($exam_a_gb_cd)
      AND exam_type_cd IN ($exam_type_cd)
      AND grdng_cd IN ($grdng_cd)  
      AND num_yn = 'Y'
    )
  )
WHERE rnk <= 10
ORDER BY rnk
  , rslt_ymd DESC;

SELECT rnk
  , rslt_ymd
  , exam_a_gb
  , val_nm
  , val_rslt
  , val_per
  , CASE 
    WHEN val_per > 100
      THEN '×'
    ELSE '✓'
    END grdng
  , link
FROM (
  SELECT dense_rank() OVER (
      ORDER BY val_per DESC
      ) rnk
    , rslt_ymd
    , val_nm
    , val_rslt
    , val_per
    , exam_a_gb
    , link
  FROM (
    SELECT T4.val_nm
      , rtrim(val_rslt || ' ' || coalesce(val_unit, '')) val_rslt
      , (val_rslt::FLOAT / ref_max::FLOAT) * 100 val_per
      , to_char(rslt_tm, 'YYYY-MM-DD') rslt_ymd
      , com_cd_nm exam_a_gb
      , link
    FROM med_exam_rslt T1
    JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
    JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
      AND T2.sex = T3.sex
      AND T1.val_id = T3.val_id
    JOIN med_exam_val T4 ON T1.val_id = T4.val_id
    JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
    JOIN com_cd T6 ON T4.exam_a_gb_cd = T6.com_cd
      AND T6.com_cd_id = 'M01'  
    WHERE T1.usr_id = '$usr_id'
      AND T1.exam_id IN ($exam_id)
      AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
      AND exam_a_gb_cd IN ($exam_a_gb_cd)
      AND exam_type_cd IN ($exam_type_cd)
      AND grdng_cd IN ($grdng_cd)  
      AND num_yn = 'Y'
    )
  )
WHERE rnk <= 10
ORDER BY rnk
  , rslt_ymd DESC;

SELECT usr_nm
  , regexp_replace(extract(YEAR FROM age(now(), birth_ymd::DATE))::VARCHAR, '[0-9]+', '*') usr_age
  , CASE 
    WHEN sex = 'M'
      THEN '남성'
    WHEN sex = 'F'
      THEN '여성'
    END sex
  , T8.com_cd_nm race_cd
  , trunc(wght::NUMERIC / power(hght::NUMERIC / 100, 2), 2) bmi
  , T2.com_cd_nm meal_gb
  , T3.com_cd_nm exercise_st
  , T4.com_cd_nm sleep_st
  , T5.com_cd_nm daily_smok
  , T6.com_cd_nm daily_alco
  , T7.com_cd_nm daily_caff
  , regexp_replace(dose_180d, '(.*[0-9]{2}):([0-9]{2}):([0-9]{2})', '\\1:**:\\3') dose_180d
FROM med_exam_usr T1
JOIN com_cd T2 ON T1.meal_gb_cd = T2.com_cd
  AND T2.com_cd_id = 'M13'
JOIN com_cd T3 ON T1.exercise_st_cd = T3.com_cd
  AND T3.com_cd_id = 'M14'
JOIN com_cd T4 ON T1.sleep_st_cd = T4.com_cd
  AND T4.com_cd_id = 'M15'
JOIN com_cd T5 ON T1.daily_smok_cd = T5.com_cd
  AND T5.com_cd_id = 'M08'
JOIN com_cd T6 ON T1.daily_alco_cd = T6.com_cd
  AND T6.com_cd_id = 'M09'
JOIN com_cd T7 ON T1.daily_caff_cd = T7.com_cd
  AND T7.com_cd_id = 'M10'
JOIN com_cd T8 ON T1.race_cd = T8.com_cd
  AND T8.com_cd_id = 'M11'
JOIN (
  SELECT T2.usr_id
    , to_char(DATE_ADD(max(drg_adm_tm) + (max(wait_tm_by_sq) * interval '1minute'), '180day'), 'YYYY-MM-DD HH24:MM:SS') dose_180d
  FROM med_exam_schd T1
  LEFT JOIN med_exam_hist T2 ON T2.exam_id = T2.exam_id
    AND T1.exam_tm = T2.exam_tm
  JOIN med_exam_reg T3 ON T3.usr_id = T2.usr_id
    AND T1.exam_id = T3.exam_id
  GROUP BY T2.usr_id
  ) T9 ON T9.usr_id = T1.usr_id
JOIN med_exam_reg T10 ON T10.usr_id = T1.usr_id
JOIN med_exam_desc T11 ON T10.exam_id = T11.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T10.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd);

SELECT CASE 
    WHEN usr_hist_cd IN ('003', '007')
      THEN '최근 3개월 ' || T2.com_cd_nm
    ELSE T2.com_cd_nm
    END usr_hist
  , val
FROM (
  SELECT usr_id
    , usr_hist_cd
    , CASE 
      WHEN usr_hist_cd = '003'
        THEN array_to_string(array_agg(val || ' (' || to_char(base_tm, 'YYYY-MM-DD') || ')' ORDER BY base_tm DESC), ', ')
      WHEN usr_hist_cd = '004'
        THEN array_to_string(array_agg(val), ', ')
      WHEN usr_hist_cd = '005'
        THEN coalesce(array_to_string(array_agg(val ORDER BY base_tm DESC), ', '), '-')
      WHEN usr_hist_cd = '006'
        THEN array_to_string(array_agg(val), ', ')
      WHEN usr_hist_cd = '007'
        THEN array_to_string(array_agg(val || ' (' || to_char(base_tm, 'YYYY-MM-DD') || ')' ORDER BY base_tm DESC), ', ')
      END val
  FROM med_exam_ucd
  WHERE usr_hist_cd IN ('004', '005', '006')
    OR (
      usr_hist_cd IN ('003', '007')
      AND base_tm > current_timestamp - interval '3 months'
      )
  GROUP BY usr_id
    , usr_hist_cd
  ORDER BY usr_hist_cd
  ) T1
JOIN com_cd T2 ON T1.usr_hist_cd = T2.com_cd
  AND T2.com_cd_id = 'M12'
JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
JOIN med_exam_desc T5 ON T4.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T5.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
ORDER BY usr_hist_cd;

SELECT to_char(to_date(schd_stt_ymd, 'YYYYMMDD'), 'YYYY-MM-DD') schd_stt_ymd
  , to_char(to_date(schd_end_ymd, 'YYYYMMDD'), 'YYYY-MM-DD') schd_end_ymd
  , T1.exam_id
  , exam_link
  , T2.com_cd_nm || ' ' || phase exam_type
  , trgt_dss
  , prod_id
  , client  
  , prod_link
  , org_nm
  , regexp_replace(org_reg_id, '(?<=..).', '*', 'g') org_reg_id
  , regexp_replace(exam_reg_id, '(?<=..).', '*', 'g') exam_reg_id
  , max_schd_prd || '기' max_schd_prd
  , regexp_replace(wait_tm_by_sq::VARCHAR, '[0-9]+', '*') wait_tm_by_sq
  , prtcp_cnt  
  , fee  
  , exam_desc
FROM med_exam_desc T1
JOIN com_cd T2 ON T1.exam_type_cd = T2.com_cd
  AND T2.com_cd_id = 'M03'
JOIN med_exam_reg T3 ON T1.exam_id = T3.exam_id
JOIN (
  SELECT max(exam_id) exam_id
    , max(schd_prd) max_schd_prd
  FROM med_exam_schd
  GROUP BY exam_id
  ) T4 ON T1.exam_id = T4.exam_id
WHERE usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
ORDER BY schd_stt_ymd;

SELECT T1.exam_id
  , exam_link
  , T3.com_cd_nm exam_sch_gb
  , schd_prd || '기' schd_prd
  , T2.com_cd_nm exam_gb_b
  , T1.exam_tm
  , drg_adm_tm
  , CASE 
    WHEN T3.com_cd IN ('002', '003', '004')
      AND exam_b_gb_cd IN ('001', '002', '003', '005')
      THEN regexp_replace(to_char(T1.exam_tm + wait_tm_by_sq * interval '1minute', 'YYYY-MM-DD HH24:MM:SS'), '(.*[0-9]{2}):([0-9]{2}):([0-9]{2})', '\\1:**:\\3')
    END exam_tm_by_sq    
  , 'D' || date_part('DAY', T1.exam_tm + '1day' - drg_adm_tm) days_from_drg_adm
  , CASE
    WHEN T2.com_cd IN ('001', '002', '003', '005')
      THEN regexp_replace(trunc(extract(epoch FROM T1.exam_tm - drg_adm_tm) / (60 * 60), 1)::TEXT, '(^[0-9]+)(.0)', '\\1')
    END after_drg_adm_tm  
  , alwd_tm_blod_clct
  , T4.com_cd_nm drg_adm_cls
  , tm_err
  , T1.remark
FROM med_exam_hist T1
JOIN com_cd T2 ON T1.exam_b_gb_cd = T2.com_cd
  AND T2.com_cd_id = 'M02'
JOIN com_cd T3 ON T1.exam_sch_gb_cd = T3.com_cd
  AND T3.com_cd_id = 'M05'
LEFT JOIN com_cd T4 ON T1.drg_adm_cls_cd = T4.com_cd
  AND T4.com_cd_id = 'M04'
JOIN med_exam_usr T5 ON T1.usr_id = T5.usr_id
LEFT JOIN med_exam_schd T6 ON T1.exam_id = T6.exam_id
  AND T1.exam_tm = T6.exam_tm
JOIN med_exam_reg T7 ON T1.usr_id = T7.usr_id
  AND T1.exam_id = T7.exam_id
JOIN med_exam_desc T8 ON T1.exam_id = T8.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd)
ORDER BY exam_tm
  , exam_b_gb_cd;

SELECT base_tm
  , val::FLOAT val_rslt
  , 90 ref_min
  , 140 ref_max
  , 'mmHg' val_unit
FROM med_exam_hist T1
LEFT JOIN med_exam_schd T2 ON T1.exam_id = T2.exam_id
  AND T1.exam_tm = T2.exam_tm  
JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
  AND T1.exam_id = T4.exam_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
JOIN med_exam_ucd T6 ON T1.usr_id = T6.usr_id
  AND T1.exam_tm = T6.base_tm
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd)  
  AND exam_b_gb_cd = '002'
  AND usr_hist_cd = '022';

SELECT base_tm
  , val::FLOAT val_rslt
  , 60 ref_min
  , 90 ref_max
  , 'mmHg' val_unit  
FROM med_exam_hist T1
LEFT JOIN med_exam_schd T2 ON T1.exam_id = T2.exam_id
  AND T1.exam_tm = T2.exam_tm  
JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
  AND T1.exam_id = T4.exam_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
JOIN med_exam_ucd T6 ON T1.usr_id = T6.usr_id
  AND T1.exam_tm = T6.base_tm
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd)  
  AND exam_b_gb_cd = '002'
  AND usr_hist_cd = '023';

SELECT base_tm
  , val::FLOAT val_rslt
  , 36.1 ref_min
  , 37.2 ref_max
  , '°C' val_unit
FROM med_exam_hist T1
LEFT JOIN med_exam_schd T2 ON T1.exam_id = T2.exam_id
  AND T1.exam_tm = T2.exam_tm  
JOIN med_exam_usr T3 ON T1.usr_id = T3.usr_id
JOIN med_exam_reg T4 ON T1.usr_id = T4.usr_id
  AND T1.exam_id = T4.exam_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
JOIN med_exam_ucd T6 ON T1.usr_id = T6.usr_id
  AND T1.exam_tm = T6.base_tm
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND exam_type_cd IN ($exam_type_cd)
  AND exam_b_gb_cd IN ($exam_b_gb_cd)  
  AND exam_b_gb_cd = '002'
  AND usr_hist_cd = '021';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CBC_WBC_COUNT';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CBC_RBC_COUNT';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CBC_HEMOGLOBIN';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CBC_HCT';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CBC_PLT_COUNT';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CBC_NEUTROPHILS';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_CALCIUM';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_PHOSPHATE';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_GLUCOSE';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_BUN';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_CREATININE';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_URIC_ACID';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_TOTAL_CHOLESTEROL';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_TOTAL_PROTEIN';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_ALBUMIN';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_ALP';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_AST';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_ALT';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_TOTAL_BILIRUBIN';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_GGT';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_LDH';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_CK';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_TRIGLYCERIDE';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_SODIUM';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_POTASSIUM';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_CL';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_AMYLASE';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'CHM_LIPASE';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_SPECIFIC_GRAVITY';

SELECT rslt_tm
  , val_rslt::FLOAT
  , ref_min::FLOAT
  , ref_max::FLOAT
  , val_unit
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_PH';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_ALBUMIN';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_GLUCOSE';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_KETONES';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_BLOOD';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt || ' ' || val_unit val_rslt
  , '-0.2 ' || val_unit ref_min
  , '+0.2 ' || val_unit ref_max  
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_UROBILINOGEN';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_BILIRUBIN';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_NITRITES';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_LEUKOCYTE_ESTERASE';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , '-' ref_min  
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_COLOR';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt
  , ref_min
  , T1.remark
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_TURBIDITY';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , val_rslt || ' ' || val_unit val_rslt
  , ref_min || ' ' || val_unit ref_min
  , ref_max || ' ' || val_unit ref_max
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'URN_RBC';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , (regexp_matches(val_rslt, '.*\\((.*)\\).*')) [1] val_rslt_desc
  , (regexp_matches(val_rslt, '(.*)\\(.*')) [1] val_rslt
  , ref_min
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'HPT_HB_SAG';

SELECT to_char(rslt_tm, 'YYYY-MM-DD') rslt_tm
  , (regexp_matches(val_rslt, '.*\\((.*)\\).*')) [1] val_rslt_desc
  , (regexp_matches(val_rslt, '(.*)\\(.*')) [1] val_rslt
  , ref_min
FROM med_exam_rslt T1
JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
  AND T2.sex = T3.sex
  AND T1.val_id = T3.val_id
JOIN med_exam_val T4 ON T1.val_id = T4.val_id
JOIN med_exam_desc T5 ON T1.exam_id = T5.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T1.exam_id IN ($exam_id)
  AND to_char(rslt_tm, 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_a_gb_cd IN ($exam_a_gb_cd)
  AND exam_type_cd IN ($exam_type_cd)
  AND grdng_cd IN ($grdng_cd)
  AND T1.val_id = 'HPT_ANTI_HCV';

SELECT model
  , to_char(to_timestamp(exam_ymd, 'YYYYMMDD'), 'YYYY-MM-DD') exam_ymd
  , regexp_replace(req, '([0-9]+)(-years-old)', '*\\2') req
  , regexp_replace(res_ko, '([0-9]+)(세)', '*\\2') res_ko
  , p_tokens  
  , p_temp
FROM med_exam_ai T1
JOIN med_exam_reg T2 ON T1.usr_id = T2.usr_id
JOIN med_exam_desc T3 ON T2.exam_id = T3.exam_id
WHERE T1.usr_id = '$usr_id'
  AND T2.exam_id IN ($exam_id)
  AND to_char(to_timestamp(exam_ymd, 'YYYYMMDD'), 'YYYY-MM-DD') IN ($rslt_ymd)
  AND exam_type_cd IN ($exam_type_cd)
  AND model IN ($ai_model)
ORDER BY ord, exam_ymd;
