-- dev.med_exam_usr definition

-- Drop table

-- DROP TABLE dev.med_exam_usr;

CREATE TABLE dev.med_exam_usr (
	usr_id varchar NOT NULL, -- 대상자 ID
	usr_nm varchar NULL, -- 대상자 명
	birth_ymd bpchar(8) NULL, -- 생일
	sex bpchar(1) NULL, -- 성별 (M/F)
	hght int2 NULL, -- 신장 (cm)
	wght int2 NULL, -- 체중 (kg)
	meal_gb_cd bpchar(3) NULL, -- 식사 구분 코드
	exercise_st_cd bpchar(3) NULL, -- 운동 상태 코드
	sleep_st_cd bpchar(3) NULL, -- 수면 상태 코드
	daily_smok_cd bpchar(3) NULL, -- 일일 흡연량 코드
	daily_alco_cd bpchar(3) NULL, -- 일일 음주량 코드
	daily_caff_cd bpchar(3) NULL, -- 일일 카페인 섭취량 코드
	race_cd bpchar(3) NULL, -- 인종 코드
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_usr_pk PRIMARY KEY (usr_id)
);
CREATE INDEX med_exam_usr_sex_idx ON dev.med_exam_usr USING btree (sex);
COMMENT ON TABLE dev.med_exam_usr IS '신체검사 대상자';

-- Column comments

COMMENT ON COLUMN dev.med_exam_usr.usr_id IS '대상자 ID';
COMMENT ON COLUMN dev.med_exam_usr.usr_nm IS '대상자 명';
COMMENT ON COLUMN dev.med_exam_usr.birth_ymd IS '생일';
COMMENT ON COLUMN dev.med_exam_usr.sex IS '성별 (M/F)';
COMMENT ON COLUMN dev.med_exam_usr.hght IS '신장 (cm)';
COMMENT ON COLUMN dev.med_exam_usr.wght IS '체중 (kg)';
COMMENT ON COLUMN dev.med_exam_usr.meal_gb_cd IS '식사 구분 코드';
COMMENT ON COLUMN dev.med_exam_usr.exercise_st_cd IS '운동 상태 코드';
COMMENT ON COLUMN dev.med_exam_usr.sleep_st_cd IS '수면 상태 코드';
COMMENT ON COLUMN dev.med_exam_usr.daily_smok_cd IS '일일 흡연량 코드';
COMMENT ON COLUMN dev.med_exam_usr.daily_alco_cd IS '일일 음주량 코드';
COMMENT ON COLUMN dev.med_exam_usr.daily_caff_cd IS '일일 카페인 섭취량 코드';
COMMENT ON COLUMN dev.med_exam_usr.race_cd IS '인종 코드';
COMMENT ON COLUMN dev.med_exam_usr.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_usr.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_usr.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_usr.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_usr.mod_tm IS '최종 수정 시간';