from com_ai import *
import sys
import time
import argparse
import configparser
import re
import csv
import uuid
import psycopg2
from bs4 import BeautifulSoup
from deep_translator import GoogleTranslator
import deepl

con = psycopg2.connect(
  host     = str(os.environ.get("PGSQL_HOST")),
  dbname   = str(os.environ.get("PGSQL_DB")),
  user     = str(os.environ.get("PGSQL_USER")),
  password = str(os.environ.get("PGSQL_PASSWORD")),
  port     = int(os.environ.get("PGSQL_PORT"))
)

def get_cfg(section, key):
  """cfg 파일에서 요소 반환"""
  config = configparser.ConfigParser()
  config.read("/opt/python/med_exam.cfg")
  return config[section][key]

def init_aes_key():
  """aes_key, iv를 ini 파일에 재생성"""
  config = configparser.ConfigParser()
  config.read("/opt/python/med_exam.cfg")
  config["common"]["aes_key"] = uuid.uuid4().hex [:32]
  config["common"]["iv"] = uuid.uuid4().hex [:16]
  print(f"aes_key={config["common"]["aes_key"]}")
  print(f"iv={config["common"]["iv"]}")
  with open("/opt/python/med_exam.cfg", "w", encoding="UTF-8") as f:
    config.write(f, space_around_delimiters=False)

def is_valid_jumin_id(jumin_id):
  """jumin_id 유효성 여부"""
  return (re.compile("^[0-9]{2}[0-1][0-9]{1}[0-3][0-9]{1}[1-8]{1}[0-9]{6}$").match(jumin_id))

def is_valid_usr_id(usr_id):
  """usr_id 유효성 여부"""
  return (re.compile("^[A-Za-z0-9+/]{22}==$").match(usr_id))

def is_number(src):
  """val_rslt 결과값 숫자(계산 가능) 여부"""
  return (re.compile("^(?![0-9]~)[-+]?[0-9]*\\.*[0-9]+").match(src))

def percentage(part, whole, scale):
  """percentage 반환"""
  return round(100.0 * float(part) / float(whole), scale)

def encrypt_plain(plain):
  """aes 암호화"""
  aes_key = get_cfg("common", "aes_key")
  iv = get_cfg("common", "iv")
  try:
    cur = con.cursor()
    cur.execute("SELECT encode(encrypt_iv(%s, %s, %s, 'aes'), 'base64')", (plain, aes_key, iv,))
    row = cur.fetchone()
    cur.close()
    return row[0]
  except Exception as e:
    print(f"e={e}")

def decrypt_cipher(cipher):
  """aes 복호화"""
  aes_key = get_cfg("common", "aes_key")
  iv = get_cfg("common", "iv")
  try:
    cur = con.cursor()
    cur.execute("SELECT convert_from(decrypt_iv(decode(%s, 'base64'), %s, %s, 'aes'), 'utf8')", (cipher, aes_key, iv,))
    row = cur.fetchone()
    cur.close()
    return row[0]
  except Exception as e:
    print(f"e={e}")

def get_age(exam_dt, birth_ymd):
  """나이 반환"""
  try:
    cur = con.cursor()
    sql = """
          SELECT extract(YEAR FROM age(%s, %s))
          """
    cur.execute(sql, (exam_dt, birth_ymd,))
    row = cur.fetchone()
    cur.close()
    return row[0]
  except Exception as e:
    print(f"e={e}")

def sel_med_exam_map(exam_id, map_gb_cd):
  """med_exam_map 반환"""
  try:
    cur = con.cursor()
    cur.execute("SELECT cd_v, cd_k FROM med_exam_map WHERE exam_id = %s AND map_gb_cd = %s", (exam_id, map_gb_cd,))
    rows = cur.fetchall()
    cur.close()
    return rows
  except Exception as e:
    print(f"e={e}")

def sel_med_exam_ref(exam_id, sex):
  """med_exam_ref 반환"""
  try:
    cur = con.cursor()
    cur.execute("SELECT num_yn, T1.val_id , val_unit , ref_min , ref_max , T4.val_nm , T2.remark exam_a_gb , T3.remark exam_b_gb FROM med_exam_ref T1 JOIN med_exam_val T4 ON T1.val_id = T4.val_id JOIN com_cd T2 ON T4.exam_a_gb_cd = T2.com_cd AND T2.com_cd_id = 'M01' JOIN com_cd T3 ON T4.exam_b_gb_cd = T3.com_cd AND T3.com_cd_id = 'M02' WHERE exam_id = %s AND sex = %s", (exam_id, sex,))
    rows = cur.fetchall()
    cur.close()
    return rows
  except Exception as e:
    print(f"e={e}")

def sel_med_exam_ai(usr_id):
  """sel_med_exam_ai 반환"""
  try:
    cur = con.cursor()
    sql = """
    SELECT exam_dt
      , concat_ws(chr(13) || chr(13), usr, vs, rslt, ucd, 'Review the test results.') p
    FROM (
      SELECT usr_id
        , concat_ws(', ', age_sex, bmi, meal_gb, exercise_st, sleep_st, daily_smok, daily_alco, daily_caff, race) usr
      FROM (
        SELECT usr_id
          , extract(YEAR FROM age('20240725', birth_ymd::DATE)) || '-years-old ' || CASE
            WHEN sex = 'M'
              THEN 'male'
            WHEN sex = 'F'
              THEN 'female'
            END age_sex
          , 'BMI ' || trunc(wght::NUMERIC / power(hght::NUMERIC / 100, 2), 2) || ' kg/m2' bmi
          , T9.remark meal_gb
          , T10.remark exercise_st
          , T11.remark sleep_st
          , T5.remark daily_smok
          , T6.remark daily_alco
          , T7.remark daily_caff
          , T8.remark race
        FROM med_exam_usr T1
        JOIN com_cd T5 ON T1.daily_smok_cd = T5.com_cd
          AND T5.com_cd_id = 'M08'
        JOIN com_cd T6 ON T1.daily_alco_cd = T6.com_cd
          AND T6.com_cd_id = 'M09'
        JOIN com_cd T7 ON T1.daily_caff_cd = T7.com_cd
          AND T7.com_cd_id = 'M10'
        JOIN com_cd T8 ON T1.race_cd = T8.com_cd
          AND T8.com_cd_id = 'M11'
        JOIN com_cd T9 ON T1.meal_gb_cd = T9.com_cd
          AND T9.com_cd_id = 'M13'
        JOIN com_cd T10 ON T1.exercise_st_cd = T10.com_cd
          AND T10.com_cd_id = 'M14'
        JOIN com_cd T11 ON T1.sleep_st_cd = T11.com_cd
          AND T11.com_cd_id = 'M15'
        )
      ) T1
    JOIN (
      SELECT usr_id
        , 'Vital Signs ' || chr(13) || array_to_string(array_agg(val || ' (' || to_char(base_tm, 'YYYY-MM-DD') || ')'), ', ') vs
      FROM (
        SELECT usr_id
          , rank() OVER (
            PARTITION BY usr_hist_cd ORDER BY base_tm DESC
            ) rn
          , CASE
            WHEN usr_hist_cd = '022'
              THEN 'Systolic Blood Pressure ' || val || ' mmHg'
            WHEN usr_hist_cd = '023'
              THEN 'Diastolic Blood Pressure ' || val || ' mmHg'
            END val
          , base_tm
        FROM med_exam_ucd
        WHERE usr_hist_cd IN ('022', '023')
        )
      WHERE rn = 1
      GROUP BY usr_id
      ) T2 ON T1.usr_id = T2.usr_id
    JOIN (
      SELECT usr_id
        , exam_dt
        , array_to_string(array_agg(rslt), chr(13) || chr(13)) rslt
      FROM (
        SELECT T1.usr_id
          , to_char(rslt_tm, 'YYYYMMDD') exam_dt
          , T5.remark || CASE
            WHEN T5.com_cd IN ('001', '002', '003')
              THEN ' ' || T6.remark
            ELSE ''
            END || chr(13) || array_to_string(array_agg(rtrim(T4.val_nm || ' ' || T1.val_rslt || ' ' || coalesce(val_unit, '')) ORDER BY T3.ord), ', ') rslt
        FROM med_exam_rslt T1
        JOIN med_exam_usr T2 ON T1.usr_id = T2.usr_id
        JOIN med_exam_ref T3 ON T1.exam_id = T3.exam_id
          AND T2.sex = T3.sex
          AND T1.val_id = T3.val_id
        JOIN med_exam_val T4 ON T1.val_id = T4.val_id
        JOIN com_cd T5 ON T4.exam_a_gb_cd = T5.com_cd
          AND T5.com_cd_id = 'M01'
        JOIN com_cd T6 ON T4.exam_b_gb_cd = T6.com_cd
          AND T6.com_cd_id = 'M02'
        GROUP BY T1.usr_id
          , rslt_tm
          , exam_a_gb_cd
          , T5.remark
          , T6.remark
          , T5.com_cd
        ORDER BY exam_a_gb_cd
          , rslt_tm
        )
      GROUP BY usr_id
        , exam_dt
      ) T3 ON T1.usr_id = T3.usr_id
    JOIN (
      SELECT usr_id
        , 'History' || chr(13) || array_to_string(array_agg(val), chr(13)) ucd
      FROM (
        SELECT usr_id
          , CASE
            WHEN usr_hist_cd = '003'
              THEN 'Medications: ' || array_to_string(array_agg(remark || ' (' || to_char(base_tm, 'YYYY-MM-DD') || ')' ORDER BY base_tm DESC), ', ')
            WHEN usr_hist_cd = '004'
              THEN 'Illness or infectious disease: ' || array_to_string(array_agg(remark ORDER BY base_tm DESC), ', ')
            WHEN usr_hist_cd = '005'
              THEN 'Allergies: ' || array_to_string(array_agg(remark ORDER BY base_tm DESC), ', ')
            WHEN usr_hist_cd = '006'
              THEN 'Family medical history: ' || array_to_string(array_agg(remark ORDER BY base_tm DESC), ', ')
            WHEN usr_hist_cd = '007'
              THEN 'Miscellaneous: ' || array_to_string(array_agg(remark || ' (' || to_char(base_tm, 'YYYY-MM-DD') || ')' ORDER BY base_tm DESC), ', ')
            END val
        FROM med_exam_ucd
        WHERE usr_hist_cd IN ('003', '004', '005', '006', '007')
        GROUP BY usr_id
          , usr_hist_cd
        ORDER BY usr_hist_cd
        )
      GROUP BY usr_id
      ) T4 ON T1.usr_id = T4.usr_id
    where T1.usr_id = %s
    ORDER BY exam_dt
    """
    cur.execute(sql, (usr_id,))
    rows = cur.fetchall()
    cur.close()
    return rows
  except Exception as e:
    print(f"e={e}")

def get_row(k, rows):
  """k:v 컬럼 매핑"""
  for row in rows:
    if(k == row[1]):
      return row

def delete_usr_data(jumin_id):
  """사용자 데이터 삭제"""
  if not is_valid_jumin_id(jumin_id):
    print(f"invalid jumin_id={jumin_id}")
    sys.exit(1)
  usr_id = encrypt_plain(jumin_id)
  print(f"jumin_id={jumin_id}, usr_id={usr_id}")
  try:
    cur = con.cursor()
    cur.execute("DELETE FROM med_exam_usr WHERE usr_id = %s", (usr_id,))
    print(f"delete_med_exam_usr={cur.rowcount}")
    cur.execute("DELETE FROM med_exam_ucd WHERE usr_id = %s", (usr_id,))
    print(f"delete_med_exam_ucd={cur.rowcount}")
    cur.execute("DELETE FROM med_exam_reg WHERE usr_id = %s", (usr_id,))
    print(f"delete_med_exam_reg={cur.rowcount}")
    cur.execute("DELETE FROM med_exam_hist WHERE usr_id = %s", (usr_id,))
    print(f"delete_med_exam_hist={cur.rowcount}")
    cur.execute("DELETE FROM med_exam_rslt WHERE usr_id = %s", (usr_id,))
    print(f"delete_med_exam_rslt={cur.rowcount}")
    cur.execute("DELETE FROM med_exam_ai WHERE usr_id = %s", (usr_id,))
    print(f"delete_med_exam_ai={cur.rowcount}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def to_snake_case(exam_id):
  """snake_case 변환"""
  return exam_id.replace("-", "_").lower()

def get_html_files(exam_id, work_path):
  """데이터 html 파일 반환"""
  files = os.listdir(work_path)
  html_files = [file for file in files if file.endswith(".html")]
  if(len(html_files) <= 0):
    print(f"invalid html_files={len(html_files)}")
    sys.exit(1)
  return html_files

def get_sex_cd(sex):
  """성별코드 반환"""
  if(sex == "남"):
    return "M"
  elif(sex == "여"):
    return "F"

def get_sex_nm(sex):
  """성별 반환"""
  if(sex == "M"):
    return "male"
  elif(sex == "F"):
    return "female"

def get_jumin_sex_cd(sex, yyyymmdd):
  """jumin_id 성별코드 get"""
  cd = ""
  yyyymmdd = int(yyyymmdd)
  if(sex == "M" and yyyymmdd >= 19000101 and yyyymmdd <= 19991231):
    cd = "1"
  elif(sex == "F" and yyyymmdd >= 19000101 and yyyymmdd <= 19991231):
    cd = "2"
  if(sex == "M" and yyyymmdd >= 20000101 and yyyymmdd <= 20991231):
    cd = "3"
  elif(sex == "F" and yyyymmdd >= 20000101 and yyyymmdd <= 20991231):
    cd = "4"
  return cd

def set_null(row):
  """row 컬럼값 null 처리"""
  for i, v in enumerate(row): #"" to null
    if row[i] == "":
      row[i] = None
  return row

def to_int(src):
  """int 형변환 시 ""값 none 처리"""
  if(src == ""):
    return None
  else:
    return int(src)

def remove_null(src):
  """"null"값 "" 처리"""
  if(src == "null"):
    return ""
  else:
    return src
  
def remove_dup(rows):
  """rows 중복 제거"""
  return [list(x) for x in list(set(map(tuple, rows)))]  

def insert_ai_data(jumin_id):
  """ai 데이터 삽입"""
  if not is_valid_jumin_id(jumin_id):
    print(f"invalid jumin_id={jumin_id}")
    sys.exit(1)
  usr_id = encrypt_plain(jumin_id)
  print(f"jumin_id={jumin_id}, usr_id={usr_id}")
  #테이블 med_exam_ai
  ai_rows = []
  ai_rows += job1_med_exam_ai(usr_id, "groq", "llama-3.2-90b-text-preview", 8192, 0.1, 11)
  ai_rows += job1_med_exam_ai(usr_id, "groq", "llama-3.1-70b-versatile", 8000, 0.1, 12)
  ai_rows += job1_med_exam_ai(usr_id, "groq", "llama3-70b-8192", 8192, 0.1, 13)
  ai_rows += job1_med_exam_ai(usr_id, "groq", "llama3-groq-70b-8192-tool-use-preview", 8192, 0.1, 14)
  ai_rows += job1_med_exam_ai(usr_id, "g4f", "gpt-4o-mini", 8192, 0.1, 31)
  ai_rows += job1_med_exam_ai(usr_id, "g4f", "gpt-3.5-turbo", 8000, 0.1, 32)
  ai_rows += job1_med_exam_ai(usr_id, "gemini", "gemini-1.5-flash", 8192, 0.1, 41)
  ai_rows += job1_med_exam_ai(usr_id, "groq", "gemma2-9b-it", 8192, 0.1, 42)
  ai_rows += job1_med_exam_ai(usr_id, "groq", "mixtral-8x7b-32768", 32768, 0.1, 51)
  #ai_rows += job1_med_exam_ai(usr_id, "pawan", "cosmosrp", 16384, 0.1, 81)
  #ai_rows += job1_med_exam_ai(usr_id, "pawan", "cosmosrp-it", 16384, 0.1, 82)
  #job2_write_csv(ai_rows, "med_exam_ai.csv")
  #job2_med_exam_ai("google", "med_exam_ai.csv") #google 번역
  #job2_med_exam_ai("deepl", "med_exam_ai.csv") #deepl 번역
  job3_db_med_exam_ai(ai_rows, usr_id)

def insert_usr_data(exam_id):
  """사용자 데이터 삽입"""
  if(exam_id == "RT51KR-PK01"):
    #------------------+-----------------
    #파일명 예         | 병원 표기 검사명
    #------------------+-----------------
    #cbc_20240725.html | 임상약리학과 일반혈액
    #cbc_20240808.html | 임상약리학과 일반혈액
    #cbc_20240822.html | 임상약리학과 일반혈액
    #cbc_20240903.html | 임상약리학과 일반혈액
    #chm_20240725.html | 임상약리학과 일반화학
    #chm_20240808.html | 임상약리학과 일반화학
    #chm_20240822.html | 임상약리학과 일반화학
    #chm_20240903.html | 임상약리학과 일반화학
    #chm_20240909.html | 임상약리학과 일반화학
    #hpt_20240725.html | 임상약리학과 바이러스성 간염 표지자
    #urn_20240725.html | 임상약리학과 뇨 검사
    #urn_20240808.html | 임상약리학과 뇨 검사
    #urn_20240822.html | 임상약리학과 뇨 검사
    #urn_20240903.html | 임상약리학과 뇨 검사
    #------------------+-----------------
    #테이블 med_exam_usr
    usr_rows = job1_med_exam_usr_rt51kr_pk01(exam_id)
    usr_id = usr_rows[0][0]
    sex = usr_rows[0][3]
    job3_db_med_exam_usr(usr_rows, usr_id)
    #테이블 med_exam_ucd
    ucd_rows = job1_med_exam_ucd_rt51kr_pk01(usr_id)
    job3_db_med_exam_ucd(ucd_rows, usr_id)
    #테이블 med_exam_reg
    reg_rows = job1_med_exam_reg_rt51kr_pk01(exam_id)
    job3_db_med_exam_reg(reg_rows, usr_id, exam_id)
    #테이블 med_exam_desc
    desc_rows = job1_med_exam_desc_rt51kr_pk01(exam_id)
    job3_db_med_exam_desc(desc_rows, exam_id)
    #테이블 med_exam_schd
    schd_rows = job1_med_exam_schd_rt51kr_pk01(exam_id)
    job3_db_med_exam_schd(schd_rows, exam_id)
    #테이블 med_exam_hist
    hist_rows = job1_med_exam_hist_rt51kr_pk01(usr_id, exam_id)
    job3_db_med_exam_hist(hist_rows, usr_id, exam_id)
    #테이블 med_exam_map
    rslt_map_rows = job1_med_exam_map_rt51kr_pk01(exam_id, "001")
    job3_db_med_exam_map(rslt_map_rows, exam_id, "001")
    #테이블 med_exam_val
    rslt_val_rows = job1_med_exam_val_rt51kr_pk01(exam_id)
    job3_db_med_exam_val(rslt_val_rows)
    #테이블 med_exam_ref
    ref_rows = job1_med_exam_ref_rt51kr_pk01(exam_id, sex)
    job3_db_med_exam_ref(ref_rows, exam_id, sex)
    #테이블 med_exam_rslt
    rslt_rows = job1_med_exam_rslt_rt51kr_pk01(usr_id, exam_id, sex)
    rslt_rows = job1_set_grdng_cd_rt51kr_pk01(exam_id, sex, rslt_rows)
    job3_db_med_exam_rslt(rslt_rows, usr_id, exam_id)
  else:
    print(f"invalid exam_id={exam_id}")
    sys.exit(1)

def job1_med_exam_usr_rt51kr_pk01(exam_id):
  """job1 데이터 추출"""
  work_path = f"/opt/python/data/{to_snake_case(exam_id)}/"
  html_files = get_html_files(exam_id, work_path)
  soup = BeautifulSoup(open(f"{work_path}{html_files[0]}"), "lxml")
  patient_info = soup.select_one("#cms-content > div > div.table.table-row > table > tbody > tr:nth-child(1) > td").get_text()
  sex = get_sex_cd(re.findall(r"남|여", patient_info)[0])
  birth_ymd = re.findall(r".*(\d{4}.\d{2}.\d{2}).*", patient_info)[0].replace(".", "")
  jumin_id = f"{birth_ymd[2:8]}{get_jumin_sex_cd(sex, birth_ymd)}000000"
  if not is_valid_jumin_id(jumin_id):
    print(f"invalid jumin_id={jumin_id}")
    sys.exit(1)
  usr_id = encrypt_plain(jumin_id)
  usr_nm = encrypt_plain(re.findall(r"^(.*) \(", patient_info)[0])
  hght       = int(get_cfg("med_exam_usr", "hght"))
  wght       = int(get_cfg("med_exam_usr", "wght"))
  meal_gb_cd     = get_cfg("med_exam_usr", "meal_gb_cd")
  exercise_st_cd = get_cfg("med_exam_usr", "exercise_st_cd")
  sleep_st_cd    = get_cfg("med_exam_usr", "sleep_st_cd")
  daily_smok_cd  = get_cfg("med_exam_usr", "daily_smok_cd")
  daily_alco_cd  = get_cfg("med_exam_usr", "daily_alco_cd")
  daily_caff_cd  = get_cfg("med_exam_usr", "daily_caff_cd")
  race_cd        = get_cfg("med_exam_usr", "race_cd")
  remark = ""
  return [[usr_id, usr_nm, birth_ymd, sex, hght, wght, meal_gb_cd, exercise_st_cd, sleep_st_cd, daily_smok_cd, daily_alco_cd, daily_caff_cd, race_cd, remark]]

def job1_med_exam_ucd_rt51kr_pk01(usr_id):
  """job1 데이터 추출"""
  cfg_cnt = int(get_cfg("med_exam_ucd", "row_cnt")) + 1
  rows = []
  for i in range(1, cfg_cnt):
    usr_hist_cd = get_cfg("med_exam_ucd", f"row_{str(i).zfill(2)}").split(";")[0]
    base_tm     = get_cfg("med_exam_ucd", f"row_{str(i).zfill(2)}").split(";")[1]
    val         = get_cfg("med_exam_ucd", f"row_{str(i).zfill(2)}").split(";")[2]
    remark      = get_cfg("med_exam_ucd", f"row_{str(i).zfill(2)}").split(";")[3]
    rows.append([usr_id, usr_hist_cd, base_tm, val, remark])
  return rows

def job1_med_exam_reg_rt51kr_pk01(exam_id):
  """job1 데이터 추출"""
  work_path = f"/opt/python/data/{to_snake_case(exam_id)}/"
  html_files = get_html_files(exam_id, work_path)
  soup = BeautifulSoup(open(f"{work_path}{html_files[0]}"), "lxml")
  patient_info = soup.select_one("#cms-content > div > div.table.table-row > table > tbody > tr:nth-child(1) > td").get_text()
  org_reg_id = soup.select_one("#patientId").get_text()
  sex = get_sex_cd(re.findall(r"남|여", patient_info)[0])
  birth_ymd = re.findall(r".*(\d{4}.\d{2}.\d{2}).*", patient_info)[0].replace(".", "")
  jumin_id = f"{birth_ymd[2:8]}{get_jumin_sex_cd(sex, birth_ymd)}000000"
  if not is_valid_jumin_id(jumin_id):
    print(f"invalid jumin_id={jumin_id}")
    sys.exit(1)
  usr_id = encrypt_plain(jumin_id)
  exam_reg_id   = get_cfg("med_exam_reg_" + to_snake_case(exam_id), "exam_reg_id")
  wait_tm_by_sq = get_cfg("med_exam_reg_" + to_snake_case(exam_id), "wait_tm_by_sq")
  remark        = ""
  return [[usr_id, exam_id, org_reg_id, exam_reg_id, wait_tm_by_sq, remark]]

def job1_med_exam_desc_rt51kr_pk01(exam_id):
  """job1 데이터 추출"""
  exam_type_cd = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "exam_type_cd")
  phase        = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "phase")
  trgt_dss     = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "trgt_dss")
  exam_desc    = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "exam_desc")
  client       = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "client")
  prod_id      = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "prod_id")
  prod_nm      = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "prod_nm")
  dosage       = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "dosage")
  org_nm       = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "org_nm")
  org_dep      = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "org_dep")
  schd_stt_ymd = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "schd_stt_ymd")
  schd_end_ymd = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "schd_end_ymd")
  prtcp_cnt    = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "prtcp_cnt")
  fee          = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "fee")
  exam_link    = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "exam_link")
  prod_link    = get_cfg("med_exam_desc_" + to_snake_case(exam_id), "prod_link")
  remark       = ""
  return [[exam_id, exam_type_cd, phase, trgt_dss, exam_desc, client, prod_id, prod_nm, dosage, org_nm, org_dep, schd_stt_ymd, schd_end_ymd, prtcp_cnt, fee, exam_link, prod_link, remark]]

def job1_med_exam_schd_rt51kr_pk01(exam_id):
  """job1 데이터 추출"""
  prd_1_stt_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_1_stt_mmdd"))
  prd_1_end_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_1_end_mmdd"))
  prd_2_stt_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_2_stt_mmdd"))
  prd_2_end_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_2_end_mmdd"))
  cfg_cnt        = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "row_cnt")) + 1
  rows = []
  for i in range(1, cfg_cnt):
    exam_tm           = get_cfg("med_exam_schd_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[0]
    drg_adm_tm        = get_cfg("med_exam_schd_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[1]
    alwd_tm_blod_clct = to_int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[2])
    exam_mmdd = int(exam_tm[5:7] + exam_tm[8:10])
    schd_prd = None
    if(exam_mmdd >= prd_1_stt_mmdd and exam_mmdd <= prd_1_end_mmdd):
      schd_prd = 1
    elif(exam_mmdd >= prd_2_stt_mmdd and exam_mmdd <= prd_2_end_mmdd):
      schd_prd = 2
    remark             = get_cfg("med_exam_schd_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[3]
    rows.append([exam_id, exam_tm, drg_adm_tm, alwd_tm_blod_clct, schd_prd, remark])
  return rows

def job1_med_exam_hist_rt51kr_pk01(usr_id, exam_id):
  """job1 데이터 추출"""
  exam_reg_id    = get_cfg("med_exam_reg_"  + to_snake_case(exam_id), "exam_reg_id")
  prd_1_stt_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_1_stt_mmdd"))
  prd_1_end_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_1_end_mmdd"))
  prd_2_stt_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_2_stt_mmdd"))
  prd_2_end_mmdd = int(get_cfg("med_exam_schd_" + to_snake_case(exam_id), "prd_2_end_mmdd"))
  cfg_cnt        = int(get_cfg("med_exam_hist_" + to_snake_case(exam_id), "row_cnt")) + 1
  rows = []
  for i in range(1, cfg_cnt):
    exam_b_gb_cd   = get_cfg("med_exam_hist_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[0]
    exam_tm        = get_cfg("med_exam_hist_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[1]
    exam_sch_gb_cd = get_cfg("med_exam_hist_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[2]
    exam_mmdd = int(exam_tm[5:7] + exam_tm[8:10])
    drg_adm_cls_cd = ""
    if(exam_reg_id[0:1] == "A" and exam_mmdd >= prd_1_stt_mmdd and exam_mmdd <= prd_1_end_mmdd):
      drg_adm_cls_cd = "003"
    elif(exam_reg_id[0:1] == "B" and exam_mmdd >= prd_1_stt_mmdd and exam_mmdd <= prd_1_end_mmdd):
      drg_adm_cls_cd = "001"
    elif(exam_reg_id[0:1] == "A" and exam_mmdd >= prd_2_stt_mmdd and exam_mmdd <= prd_2_end_mmdd):
      drg_adm_cls_cd = "001"
    elif(exam_reg_id[0:1] == "B" and exam_mmdd >= prd_2_stt_mmdd and exam_mmdd <= prd_2_end_mmdd):
      drg_adm_cls_cd = "003"
    tm_err         = to_int(get_cfg("med_exam_hist_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[3])
    remark         = get_cfg("med_exam_hist_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[4]
    rows.append([usr_id, exam_id, exam_b_gb_cd, exam_tm, exam_sch_gb_cd, drg_adm_cls_cd, tm_err, remark])
  return rows

def job1_med_exam_map_rt51kr_pk01(exam_id, map_gb_cd):
  """job1 데이터 추출"""
  work_path = f"/opt/python/data/{to_snake_case(exam_id)}/"
  html_files = get_html_files(exam_id, work_path)
  cfg_cnt = int(get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_cnt")) + 1
  total_rows = []
  for html_file in html_files:
    soup = BeautifulSoup(open(f"{work_path}{html_file}"), "lxml")
    rows = []
    #cd_k
    uls = soup.select("div > div.checkup-result-tit > span.pull-left")
    for elem in uls:
      cd_k = elem.string
      cd_v = ""
      link = ""
      for i in range(1, cfg_cnt):
        if(cd_k == get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[0]):
          cd_v = get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[1]
      remark = ""
      rows.append([exam_id, map_gb_cd, cd_k, cd_v, remark])
    total_rows += rows
  return remove_dup(total_rows)

def job1_med_exam_val_rt51kr_pk01(exam_id):
  """job1 데이터 추출"""
  cfg_cnt        = int(get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_cnt")) + 1
  rows = []
  for i in range(1, cfg_cnt):
    val_id = get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[1]
    val_nm = get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[2]
    val_id_type = val_id[0:3]
    exam_a_gb_cd = ""
    if(val_id_type == "CBC"):
      exam_a_gb_cd = "001"
    elif(val_id_type == "CHM"):
      exam_a_gb_cd = "002"
    elif(val_id_type == "HPT"):
      exam_a_gb_cd = "003"
    elif(val_id_type == "URN"):
      exam_a_gb_cd = "011"
    exam_b_gb_cd = ""
    if(val_id_type == "CBC" or val_id_type == "CHM" or val_id_type == "HPT" ):
      exam_b_gb_cd = "001"
    elif(val_id_type == "URN"):
      exam_b_gb_cd = "004"
    min_val_yn = "Y"
    if(val_id == "CHM_AST" or val_id == "CHM_ALT" or val_id == "CHM_GGT"):
      min_val_yn = "N"
    link = get_cfg("med_exam_map_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[3]
    remark = ""
    rows.append([val_id, val_nm, exam_a_gb_cd, exam_b_gb_cd, min_val_yn, link, remark])
  return rows

def job1_med_exam_ref_rt51kr_pk01(exam_id, sex):
  """job1 데이터 추출"""
  work_path = f"/opt/python/data/{to_snake_case(exam_id)}/"
  html_files = get_html_files(exam_id, work_path)
  rslt_map_rows = sel_med_exam_map(exam_id, "001")
  total_rows = []
  for html_file in html_files:
    soup = BeautifulSoup(open(f"{work_path}{html_file}"), "lxml")
    rows = []
    ord = 0
    #val_id, ord
    uls = soup.select("div > div.checkup-result-tit > span.pull-left")
    for elem in uls:
      val_id = get_row(elem.string, rslt_map_rows)[0]
      val_unit = ""
      ref_min = ""
      ref_max = ""
      num_yn = ""
      ord += 1
      if(val_id == "CHM_AMYLASE"): #일반화학 추가 검체 CHM_AMYLASE, CHM_LIPASE 순번 변경
        ord += 20
      remark = ""
      rows.append([exam_id, sex, val_id, val_unit, ref_min, ref_max, num_yn, ord, remark])
    #val_unit
    uls = soup.select("div > div.checkup-result-tit > span.float-right")
    i = 0
    for elem in uls:
      rows[i][3] = remove_null(re.findall(r".*:\s+(.*)", elem.string)[0])
      i += 1
    #ref_min, ref_max
    uls = soup.select("div > div.checkup-result-desc > ul > li:nth-child(2) > span")
    i = 0
    for elem in uls:
      rows[i][4] = remove_null(elem.string).split("~")[0]
      if "~" in elem.string:
        rows[i][5] = remove_null(elem.string).split("~")[1]
      i += 1
    #num_yn
    uls = soup.select("div > div.checkup-result-desc > ul > li:nth-child(1) > span")
    i = 0
    for elem in uls:
      if (is_number(remove_null(elem.string))):
        rows[i][6] = "Y"
      else:
        rows[i][6] = "N"
      i += 1
    total_rows += rows
  return remove_dup(total_rows)

def job1_med_exam_rslt_rt51kr_pk01(usr_id, exam_id, sex):
  """job1 데이터 추출"""
  work_path = f"/opt/python/data/{to_snake_case(exam_id)}/"
  html_files = get_html_files(exam_id, work_path)
  rslt_map_rows = sel_med_exam_map(exam_id, "001")
  cfg_cnt = int(get_cfg("med_exam_rslt_" + to_snake_case(exam_id), "row_cnt")) + 1
  total_rows = []
  for html_file in html_files:
    soup = BeautifulSoup(open(f"{work_path}{html_file}"), "lxml")
    rows = []
    exam_dt = soup.select_one("#examDt").get_text()[0:10]
    #val_id
    uls = soup.select("div > div.checkup-result-tit > span.pull-left")
    for elem in uls:
      val_id = get_row(elem.string, rslt_map_rows)[0]
      rslt_tm = ""
      for i in range(1, cfg_cnt):
        exam_type = get_cfg("med_exam_rslt_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[0]
        cfg_tm    = get_cfg("med_exam_rslt_" + to_snake_case(exam_id), "row_" + str(i).zfill(2)).split(";")[1]
        if(exam_type == val_id[0:3] and exam_dt == cfg_tm[0:10]):
          rslt_tm = cfg_tm
      val_rslt = ""
      grdng_cd = ""
      remark = ""
      rows.append([usr_id, exam_id, val_id, rslt_tm, val_rslt, grdng_cd, remark])
    #val_rslt
    uls = soup.select("div > div.checkup-result-desc > ul > li:nth-child(1) > span")
    i = 0
    for elem in uls:
      rows[i][4] = remove_null(elem.string)
      i += 1
    total_rows += rows
  return remove_dup(total_rows)

def job1_set_grdng_cd_rt51kr_pk01(exam_id, sex, rows):
  """job1 데이터 가공"""
  #M06 | 001 | 정상
  #M06 | 002 | 참고치 미만
  #M06 | 003 | 참고치 초과
  #M06 | 004 | 참고치 불일치
  work_path = f"/opt/python/data/{to_snake_case(exam_id)}/"
  html_files = get_html_files(exam_id, work_path)
  soup = BeautifulSoup(open(f"{work_path}{html_files[0]}"), "lxml")
  patient_info = soup.select_one("#cms-content > div > div.table.table-row > table > tbody > tr:nth-child(1) > td").get_text()
  birth_ymd = re.findall(r".*(\d{4}.\d{2}.\d{2}).*", patient_info)[0].replace(".", "")
  age = get_age("20240725", birth_ymd)
  for row in rows:
    ref_rows = sel_med_exam_ref(exam_id, sex)
    val_rslt  = row[4]
    ref_row   = get_row(row[2], ref_rows)
    num_yn    = ref_row[0]
    val_unit  = ref_row[2]
    ref_min   = ref_row[3]
    ref_max   = ref_row[4]
    val_nm    = ref_row[5]
    exam_a_gb = ref_row[6]
    exam_b_gb = ref_row[7]
    if(num_yn == "Y"):
      if(float(ref_min) > float(val_rslt)):
        row[5] = "002"
        row[6] = f"{val_nm} {val_rslt} {val_unit}. Minimum normal range {ref_min}{val_unit}, Less than {percentage(val_rslt, ref_min, 2)} % of normal range."
      elif(float(ref_max) < float(val_rslt)):
        row[5] = "003"
        row[6] = f"{val_nm} {val_rslt} {val_unit}. Maximum normal range {ref_min}{val_unit}, More than {percentage(val_rslt, ref_max, 2)} % of normal range."
      else:
        row[5] = "001"
    elif(num_yn == "N"):
      if(ref_min == val_rslt):
        row[5] = "001"
      else:
        if(row[2] == "URN_RBC" and val_rslt == "0~2"):
          row[5] = "001"
        elif(row[2] == "URN_COLOR" and val_rslt.lower() == "yellow"):
          row[5] = "001"
        elif(row[2] == "HPT_HB_SAG" and re.compile("^Neg.*").match(val_rslt)):
          row[5] = "001"
        elif(row[2] == "HPT_ANTI_HCV" and re.compile("^Neg.*").match(val_rslt)):
          row[5] = "001"
        else:
          row[5] = "004"
          row[6] = f"{val_nm} {val_rslt} {val_unit}. {ref_min}{val_unit} Inconsistent with normal range"
  return rows

def job1_med_exam_ai(usr_id, provider, model, p_tokens, p_temp, ord):
  """job1 데이터 추출"""
  ai_rows = []
  rows = sel_med_exam_ai(usr_id)
  for row in rows:
    exam_ymd = row[0]
    req = row[1]
    res = ""
    if(provider == "g4f"):
      res = req_g4f(req, model, p_tokens, p_temp)
      for i in range(10):
        if(re.compile(r"^$|.*{\"code\":[0-9]{3}.*|.*message exceeds.*").match(res)): #빈값, raw값, 메시지 1000자 초과 재시도
          print(f"retrying ({i + 1}/10)")
          res = req_g4f(req, model, p_tokens, p_temp)
        else:
          continue
    elif(provider == "pawan"):
      res = req_pawan(req, model, p_tokens, p_temp)
    elif(provider == "groq"):
      res = req_groq(req, model, p_tokens, p_temp)
    elif(provider == "gemini"):
      res = req_gemini(req, model, p_tokens, p_temp)
    res_ko = ""
    remark = ""
    ai_rows.append([usr_id, model, exam_ymd, req, res, res_ko, p_tokens, p_temp, ord, remark])
    time.sleep(3)
    print(f"provider={provider}, model={model}, p_tokens={p_tokens}, p_temp={p_temp}")
  return ai_rows

def job3_db_med_exam_usr(rows, usr_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_usr_01.sql", "r").read(), (usr_id,))
    print(f"delete_med_exam_usr={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_usr_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_usr={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_ucd(rows, usr_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_ucd_01.sql", "r").read(), (usr_id,))
    print(f"delete_med_exam_ucd={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_ucd_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_ucd={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_reg(rows, usr_id, exam_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_reg_01.sql", "r").read(), (usr_id, exam_id,))
    print(f"delete_med_exam_reg={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_reg_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_reg={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_desc(rows, exam_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_desc_01.sql", "r").read(), (exam_id,))
    print(f"delete_med_exam_desc={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_desc_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_desc={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_schd(rows, exam_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_schd_01.sql", "r").read(), (exam_id,))
    print(f"delete_med_exam_schd={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_schd_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_schd={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_hist(rows, usr_id, exam_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_hist_01.sql", "r").read(), (usr_id, exam_id,))
    print(f"delete_med_exam_hist={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_hist_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_hist={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_map(rows, exam_id, map_gb_cd):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_map_01.sql", "r").read(), (exam_id, map_gb_cd,))
    print(f"delete_med_exam_map={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_map_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_map={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_val(rows):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_val_01.sql", "r").read())
    print(f"delete_med_exam_val={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_val_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_val={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_ref(rows, exam_id, sex):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_ref_01.sql", "r").read(), (exam_id, sex,))
    print(f"delete_med_exam_ref={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_ref_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_ref={total_cnt}")
    cur.execute(open("/opt/python/sql/upd_med_exam_ref_01.sql", "r").read())
    print(f"update_med_exam_ref={cur.rowcount}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_rslt(rows, usr_id, exam_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_rslt_01.sql", "r").read(), (usr_id, exam_id,))
    print(f"delete_med_exam_rslt={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_rslt_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_rslt={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def job3_db_med_exam_ai(rows, usr_id):
  """job3 db 삽입"""
  try:
    cur = con.cursor()
    cur.execute(open("/opt/python/sql/del_med_exam_ai_01.sql", "r").read(), (usr_id,))
    print(f"delete_med_exam_ai={cur.rowcount}")
    total_cnt = 0
    for row in rows:
      cur.execute(open("/opt/python/sql/ins_med_exam_ai_01.sql", "r").read(), set_null(row))
      total_cnt += cur.rowcount
    print(f"insert_med_exam_ai={total_cnt}")
    con.commit()
    cur.close()
  except Exception as e:
    print(f"e={e}")
    con.rollback()

def main():
  """med_exam.py 신체검사 기초 데이터 생성"""
  parser = argparse.ArgumentParser()
  parser.add_argument("-i", "--insert_usr_data", type = str, metavar = "<exam_id>", help = "insert user data")
  parser.add_argument("-d", "--delete_usr_data", type = str, metavar = "<jumin_id>", help = "delete user data")
  parser.add_argument("-a", "--insert_ai_data", type = str, metavar = "<jumin_id>", help = "insert ai data")
  parser.add_argument("-u", "--encrypt_jumin_id", type = str, metavar = "<jumin_id>", help = "encrypt <jumin_id> to <usr_id>")
  parser.add_argument("-j", "--decrypt_usr_id", type = str, metavar = "<usr_id>", help = "decrypt <usr_id> to <jumin_id>")
  parser.add_argument("-k", "--renew_encrypt_key", help = "renew <usr_id> encryption key in config file", action ="store_true")
  parser.add_argument("-e", "--print_env", help = "print os enviornments", action ="store_true")
  args = parser.parse_args()
  if args.insert_usr_data:
    insert_usr_data(args.insert_usr_data)
  elif args.delete_usr_data:
    delete_usr_data(args.delete_usr_data)
  elif args.insert_ai_data:
    insert_ai_data(args.insert_ai_data)
  elif args.encrypt_jumin_id:
    jumin_id = args.encrypt_jumin_id
    if not is_valid_jumin_id(jumin_id):
      print(f"invalid jumin_id={jumin_id}")
      sys.exit(1)
    print(f"enc_jumin_id={encrypt_plain(jumin_id)}")
  elif args.decrypt_usr_id:
    usr_id = args.decrypt_usr_id
    if not is_valid_usr_id(usr_id):
      print(f"invalid usr_id={usr_id}")
      sys.exit(1)
    print(f"dec_usr_id={decrypt_cipher(usr_id)}")
  elif args.renew_encrypt_key:
    init_aes_key()
  elif args.print_env:
    envs = ["PGSQL_HOST", "PGSQL_DB", "PGSQL_USER", "PGSQL_PASSWORD", "PGSQL_PORT", "PAWAN_API_KEY", "GROQ_API_KEY", "GEMINI_API_KEY", "DEEPL_API_KEY", "PROXY_HOST", "PROXY_PORT"]
    [print(f"{env}={os.environ.get(env)}") for env in envs]

if __name__ == "__main__":
	main()