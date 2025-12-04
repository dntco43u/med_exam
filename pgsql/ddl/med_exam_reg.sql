-- dev.med_exam_reg definition

-- Drop table

-- DROP TABLE dev.med_exam_reg;

CREATE TABLE dev.med_exam_reg (
	usr_id varchar NOT NULL, -- 대상자 ID
	exam_id varchar NOT NULL, -- 검사 ID
	org_reg_id varchar NULL, -- 실시기관 등록 ID
	exam_reg_id varchar NULL, -- 시험 군 등록 ID
	wait_tm_by_sq int2 NULL, -- 순번 대기시간 (+분)
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_reg_pk PRIMARY KEY (usr_id, exam_id)
);
COMMENT ON TABLE dev.med_exam_reg IS '신체검사 실시기관 등록정보';

-- Column comments

COMMENT ON COLUMN dev.med_exam_reg.usr_id IS '대상자 ID';
COMMENT ON COLUMN dev.med_exam_reg.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_reg.org_reg_id IS '실시기관 등록 ID';
COMMENT ON COLUMN dev.med_exam_reg.exam_reg_id IS '시험 군 등록 ID';
COMMENT ON COLUMN dev.med_exam_reg.wait_tm_by_sq IS '순번 대기시간 (+분)';
COMMENT ON COLUMN dev.med_exam_reg.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_reg.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_reg.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_reg.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_reg.mod_tm IS '최종 수정 시간';