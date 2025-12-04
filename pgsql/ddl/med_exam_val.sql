-- dev.med_exam_val definition

-- Drop table

-- DROP TABLE dev.med_exam_val;

CREATE TABLE dev.med_exam_val (
	val_id varchar NOT NULL, -- 검사 값 ID
	val_nm varchar NULL, -- 검사 값 명
	exam_a_gb_cd bpchar(3) NULL, -- 검사 A 구분 코드
	exam_b_gb_cd bpchar(3) NULL, -- 검사 B 구분 코드
	min_val_yn bpchar(1) NULL, -- 최솟값 적용 여부 (Y/N)
	link varchar NULL, -- 웹 링크
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_val_pk PRIMARY KEY (val_id)
);
COMMENT ON TABLE dev.med_exam_val IS '신체검사 검사 값 공통';

-- Column comments

COMMENT ON COLUMN dev.med_exam_val.val_id IS '검사 값 ID';
COMMENT ON COLUMN dev.med_exam_val.val_nm IS '검사 값 명';
COMMENT ON COLUMN dev.med_exam_val.exam_a_gb_cd IS '검사 A 구분 코드';
COMMENT ON COLUMN dev.med_exam_val.exam_b_gb_cd IS '검사 B 구분 코드';
COMMENT ON COLUMN dev.med_exam_val.min_val_yn IS '최솟값 적용 여부 (Y/N)';
COMMENT ON COLUMN dev.med_exam_val.link IS '웹 링크';
COMMENT ON COLUMN dev.med_exam_val.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_val.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_val.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_val.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_val.mod_tm IS '최종 수정 시간';