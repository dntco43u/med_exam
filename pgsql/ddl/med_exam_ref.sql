-- dev.med_exam_ref definition

-- Drop table

-- DROP TABLE dev.med_exam_ref;

CREATE TABLE dev.med_exam_ref (
	exam_id varchar NOT NULL, -- 검사 ID
	sex bpchar(1) NOT NULL, -- 성별 (M/F)
	val_id varchar NOT NULL, -- 검사 값 ID
	val_unit varchar NULL, -- 검사 값 단위
	ref_min varchar NULL, -- 참고치 최소
	ref_max varchar NULL, -- 참고치 최대
	num_yn bpchar(1) NULL, -- 수치 여부 (Y/N)
	ord int2 NULL, -- 정렬 순서
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_ref_pk PRIMARY KEY (exam_id, sex, val_id)
);
COMMENT ON TABLE dev.med_exam_ref IS '신체검사 결과 참고치 공통';

-- Column comments

COMMENT ON COLUMN dev.med_exam_ref.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_ref.sex IS '성별 (M/F)';
COMMENT ON COLUMN dev.med_exam_ref.val_id IS '검사 값 ID';
COMMENT ON COLUMN dev.med_exam_ref.val_unit IS '검사 값 단위';
COMMENT ON COLUMN dev.med_exam_ref.ref_min IS '참고치 최소';
COMMENT ON COLUMN dev.med_exam_ref.ref_max IS '참고치 최대';
COMMENT ON COLUMN dev.med_exam_ref.num_yn IS '수치 여부 (Y/N)';
COMMENT ON COLUMN dev.med_exam_ref.ord IS '정렬 순서';
COMMENT ON COLUMN dev.med_exam_ref.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_ref.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_ref.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_ref.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_ref.mod_tm IS '최종 수정 시간';