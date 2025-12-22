-- dev.med_exam_schd definition

-- Drop table

-- DROP TABLE dev.med_exam_schd;

CREATE TABLE dev.med_exam_schd (
	exam_id varchar NOT NULL, -- 검사 ID
	exam_tm timestamptz NOT NULL, -- 검사 시간
	drg_adm_tm timestamptz NULL, -- 투약 시간
	alwd_tm_blod_clct int2 NULL, -- 채혈 허용 시간 (±분)
	schd_prd int2 NULL, -- 기수
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_schd_pk PRIMARY KEY (exam_id, exam_tm)
);
COMMENT ON TABLE dev.med_exam_schd IS '신체검사 채혈 일정 공통';

-- Column comments

COMMENT ON COLUMN dev.med_exam_schd.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_schd.exam_tm IS '검사 시간';
COMMENT ON COLUMN dev.med_exam_schd.drg_adm_tm IS '투약 시간';
COMMENT ON COLUMN dev.med_exam_schd.alwd_tm_blod_clct IS '채혈 허용 시간 (±분)';
COMMENT ON COLUMN dev.med_exam_schd.schd_prd IS '기수';
COMMENT ON COLUMN dev.med_exam_schd.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_schd.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_schd.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_schd.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_schd.mod_tm IS '최종 수정 시간';