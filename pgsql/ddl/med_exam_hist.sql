-- dev.med_exam_hist definition

-- Drop table

-- DROP TABLE dev.med_exam_hist;

CREATE TABLE dev.med_exam_hist (
	usr_id varchar NOT NULL, -- 대상자 ID
	exam_id varchar NOT NULL, -- 검사 ID
	exam_b_gb_cd bpchar(3) NOT NULL, -- 검사 B 구분 코드
	exam_tm timestamptz NOT NULL, -- 검사 시간
	exam_sch_gb_cd bpchar(3) NULL, -- 시험 일정 구분 코드
	drg_adm_cls_cd bpchar(3) NULL, -- 약물 복용 구분 코드
	tm_err int2 NULL, -- 검사시간 오차 (±분)
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_hist_pk PRIMARY KEY (usr_id, exam_id, exam_b_gb_cd, exam_tm)
);
COMMENT ON TABLE dev.med_exam_hist IS '신체검사 검사 이력';

-- Column comments

COMMENT ON COLUMN dev.med_exam_hist.usr_id IS '대상자 ID';
COMMENT ON COLUMN dev.med_exam_hist.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_hist.exam_b_gb_cd IS '검사 B 구분 코드';
COMMENT ON COLUMN dev.med_exam_hist.exam_tm IS '검사 시간';
COMMENT ON COLUMN dev.med_exam_hist.exam_sch_gb_cd IS '시험 일정 구분 코드';
COMMENT ON COLUMN dev.med_exam_hist.drg_adm_cls_cd IS '약물 복용 구분 코드';
COMMENT ON COLUMN dev.med_exam_hist.tm_err IS '검사시간 오차 (±분)';
COMMENT ON COLUMN dev.med_exam_hist.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_hist.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_hist.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_hist.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_hist.mod_tm IS '최종 수정 시간';