-- dev.med_exam_map definition

-- Drop table

-- DROP TABLE dev.med_exam_map;

CREATE TABLE dev.med_exam_map (
	exam_id varchar NOT NULL, -- 검사 ID
	map_gb_cd bpchar(3) NOT NULL, -- 매핑 구분 코드
	cd_k varchar NOT NULL, -- 코드 키
	cd_v varchar NULL, -- 코드 값
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_map_pk PRIMARY KEY (exam_id, map_gb_cd, cd_k)
);
COMMENT ON TABLE dev.med_exam_map IS '신체검사 매핑 공통';

-- Column comments

COMMENT ON COLUMN dev.med_exam_map.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_map.map_gb_cd IS '매핑 구분 코드';
COMMENT ON COLUMN dev.med_exam_map.cd_k IS '코드 키';
COMMENT ON COLUMN dev.med_exam_map.cd_v IS '코드 값';
COMMENT ON COLUMN dev.med_exam_map.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_map.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_map.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_map.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_map.mod_tm IS '최종 수정 시간';