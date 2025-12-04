-- dev.med_exam_ucd definition

-- Drop table

-- DROP TABLE dev.med_exam_ucd;

CREATE TABLE dev.med_exam_ucd (
	sq int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL, -- 순번
	usr_id varchar NOT NULL, -- 대상자 ID
	usr_hist_cd bpchar(3) NOT NULL, -- 대상자 이력 값 코드
	base_tm timestamptz NULL, -- 기준 시간
	val varchar NULL, -- 코드 값
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_ucd_pk PRIMARY KEY (sq, usr_id, usr_hist_cd)
);
CREATE INDEX med_exam_ucd_base_tm_idx ON dev.med_exam_ucd USING btree (base_tm);
COMMENT ON TABLE dev.med_exam_ucd IS '신체검사 대상자 이력 값 코드';

-- Column comments

COMMENT ON COLUMN dev.med_exam_ucd.sq IS '순번';
COMMENT ON COLUMN dev.med_exam_ucd.usr_id IS '대상자 ID';
COMMENT ON COLUMN dev.med_exam_ucd.usr_hist_cd IS '대상자 이력 값 코드';
COMMENT ON COLUMN dev.med_exam_ucd.base_tm IS '기준 시간';
COMMENT ON COLUMN dev.med_exam_ucd.val IS '코드 값';
COMMENT ON COLUMN dev.med_exam_ucd.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_ucd.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_ucd.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_ucd.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_ucd.mod_tm IS '최종 수정 시간';