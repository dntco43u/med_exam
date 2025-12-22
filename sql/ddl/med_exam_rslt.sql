-- dev.med_exam_rslt definition

-- Drop table

-- DROP TABLE dev.med_exam_rslt;

CREATE TABLE dev.med_exam_rslt (
	usr_id varchar NOT NULL, -- 대상자 ID
	exam_id varchar NOT NULL, -- 검사 ID
	val_id varchar NOT NULL, -- 검사 값 ID
	rslt_tm timestamptz NOT NULL, -- 검사 시간
	val_rslt varchar NULL, -- 검사 결과
	grdng_cd bpchar(3) NULL, -- 검사 값 채점 코드
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_rslt_pk PRIMARY KEY (usr_id, exam_id, val_id, rslt_tm)
);
CREATE INDEX med_exam_rslt_grdng_cd_idx ON dev.med_exam_rslt USING btree (grdng_cd);
COMMENT ON TABLE dev.med_exam_rslt IS '신체검사 실시기관 결과';

-- Column comments

COMMENT ON COLUMN dev.med_exam_rslt.usr_id IS '대상자 ID';
COMMENT ON COLUMN dev.med_exam_rslt.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_rslt.val_id IS '검사 값 ID';
COMMENT ON COLUMN dev.med_exam_rslt.rslt_tm IS '검사 시간';
COMMENT ON COLUMN dev.med_exam_rslt.val_rslt IS '검사 결과';
COMMENT ON COLUMN dev.med_exam_rslt.grdng_cd IS '검사 값 채점 코드';
COMMENT ON COLUMN dev.med_exam_rslt.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_rslt.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_rslt.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_rslt.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_rslt.mod_tm IS '최종 수정 시간';