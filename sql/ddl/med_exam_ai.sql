-- dev.med_exam_ai definition

-- Drop table

-- DROP TABLE dev.med_exam_ai;

CREATE TABLE dev.med_exam_ai (
	usr_id varchar NOT NULL, -- 대상자 ID
	model varchar NOT NULL, -- AI 모델명
	exam_ymd bpchar(8) NOT NULL, -- 검사 일자
	req varchar NULL, -- 요청 값
	res varchar NULL, -- 응답 값
	res_ko varchar NULL, -- 요청 한글 값
	p_tokens varchar NULL, -- 요청 파라미터 tokens
	p_temp varchar NULL, -- 요청 파라미터 temperature
	ord int2 NULL, -- 정렬 순서
	remark varchar NULL, -- 비고
	reg_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최초 등록 사용자
	reg_tm timestamptz DEFAULT now() NULL, -- 최초 등록 시간
	mod_usr varchar(8) DEFAULT NULL::character varying NULL, -- 최종 수정 사용자
	mod_tm timestamptz NULL, -- 최종 수정 시간
	CONSTRAINT med_exam_ai_pk PRIMARY KEY (usr_id, model, exam_ymd)
);
COMMENT ON TABLE dev.med_exam_ai IS '신체검사 AI 소견';

-- Column comments

COMMENT ON COLUMN dev.med_exam_ai.usr_id IS '대상자 ID';
COMMENT ON COLUMN dev.med_exam_ai.model IS 'AI 모델명';
COMMENT ON COLUMN dev.med_exam_ai.exam_ymd IS '검사 일자';
COMMENT ON COLUMN dev.med_exam_ai.req IS '요청 값';
COMMENT ON COLUMN dev.med_exam_ai.res IS '응답 값';
COMMENT ON COLUMN dev.med_exam_ai.res_ko IS '요청 한글 값';
COMMENT ON COLUMN dev.med_exam_ai.p_tokens IS '요청 파라미터 tokens';
COMMENT ON COLUMN dev.med_exam_ai.p_temp IS '요청 파라미터 temperature';
COMMENT ON COLUMN dev.med_exam_ai.ord IS '정렬 순서';
COMMENT ON COLUMN dev.med_exam_ai.remark IS '비고';
COMMENT ON COLUMN dev.med_exam_ai.reg_usr IS '최초 등록 사용자';
COMMENT ON COLUMN dev.med_exam_ai.reg_tm IS '최초 등록 시간';
COMMENT ON COLUMN dev.med_exam_ai.mod_usr IS '최종 수정 사용자';
COMMENT ON COLUMN dev.med_exam_ai.mod_tm IS '최종 수정 시간';