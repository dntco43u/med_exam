-- dev.med_exam_desc definition

-- Drop table

-- DROP TABLE dev.med_exam_desc;

CREATE TABLE dev.med_exam_desc (
	exam_id varchar NOT NULL, -- 검사 ID
	exam_type_cd bpchar(3) NULL, -- 시험 종류 코드
	phase varchar NULL, -- 시험 단계
	trgt_dss varchar NULL, -- 대상 질환
	exam_desc varchar NULL, -- 검사 설명
	client varchar NULL, -- 검사 의뢰자
	prod_id varchar NULL, -- 제품 ID
	prod_nm varchar NULL, -- 제품명
	dosage int2 NULL, -- 투여량 (mg)
	org_nm varchar NULL, -- 실시기관
	org_dep varchar NULL, -- 실시기관 부서
	schd_stt_ymd bpchar(8) NULL, -- 일정 시작 일자
	schd_end_ymd bpchar(8) NULL, -- 일정 종료 일자
	prtcp_cnt int2 NULL, -- 참여 인원
	fee int4 NULL, -- 사례비 (KRW)
	exam_link varchar NULL, -- 검사 웹 링크
	prod_link varchar NULL, -- 상품 웹 링크
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_desc_pk PRIMARY KEY (exam_id)
);
COMMENT ON TABLE dev.med_exam_desc IS '신체검사 검사 상세';

-- Column comments

COMMENT ON COLUMN dev.med_exam_desc.exam_id IS '검사 ID';
COMMENT ON COLUMN dev.med_exam_desc.exam_type_cd IS '시험 종류 코드';
COMMENT ON COLUMN dev.med_exam_desc.phase IS '시험 단계';
COMMENT ON COLUMN dev.med_exam_desc.trgt_dss IS '대상 질환';
COMMENT ON COLUMN dev.med_exam_desc.exam_desc IS '검사 설명';
COMMENT ON COLUMN dev.med_exam_desc.client IS '검사 의뢰자';
COMMENT ON COLUMN dev.med_exam_desc.prod_id IS '제품 ID';
COMMENT ON COLUMN dev.med_exam_desc.prod_nm IS '제품명';
COMMENT ON COLUMN dev.med_exam_desc.dosage IS '투여량 (mg)';
COMMENT ON COLUMN dev.med_exam_desc.org_nm IS '실시기관';
COMMENT ON COLUMN dev.med_exam_desc.org_dep IS '실시기관 부서';
COMMENT ON COLUMN dev.med_exam_desc.schd_stt_ymd IS '일정 시작 일자';
COMMENT ON COLUMN dev.med_exam_desc.schd_end_ymd IS '일정 종료 일자';
COMMENT ON COLUMN dev.med_exam_desc.prtcp_cnt IS '참여 인원';
COMMENT ON COLUMN dev.med_exam_desc.fee IS '사례비 (KRW)';
COMMENT ON COLUMN dev.med_exam_desc.exam_link IS '검사 웹 링크';
COMMENT ON COLUMN dev.med_exam_desc.prod_link IS '상품 웹 링크';
COMMENT ON COLUMN dev.med_exam_desc.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_desc.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_desc.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_desc.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_desc.mod_tm IS '최종 수정 시간';