-- dev.com_cd definition

-- Drop table

-- DROP TABLE dev.com_cd;

CREATE TABLE dev.com_cd (
	com_cd_id bpchar(3) NOT NULL, -- 공통 코드 ID
	com_cd bpchar(3) NOT NULL, -- 상위 공통 코드
	com_cd_nm varchar NULL, -- 공통 코드 명
	use_yn bpchar(1) DEFAULT 'Y'::bpchar NULL, -- 사용 여부 (Y/N)
	ord int2 NULL, -- 정렬 순서
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT com_cd_pk PRIMARY KEY (com_cd_id, com_cd)
);
COMMENT ON TABLE dev.com_cd IS '공통 코드';

-- Column comments

COMMENT ON COLUMN dev.com_cd.com_cd_id IS '공통 코드 ID';
COMMENT ON COLUMN dev.com_cd.com_cd IS '상위 공통 코드';
COMMENT ON COLUMN dev.com_cd.com_cd_nm IS '공통 코드 명';
COMMENT ON COLUMN dev.com_cd.use_yn IS '사용 여부 (Y/N)';
COMMENT ON COLUMN dev.com_cd.ord IS '정렬 순서';
COMMENT ON COLUMN dev.com_cd.remark IS '비고';
COMMENT ON COLUMN dev.com_cd.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.com_cd.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.com_cd.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.com_cd.mod_tm IS '최종 수정 시간';