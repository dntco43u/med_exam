# med_exam

## 개요
건강검진 및 생동성, 임상시험 피실험자에게 공개된 검사 데이터를 가공 후 시각화하고 AI 소견을 받을 수 있도록.

## 개발 환경
- PostgreSQL 16.4
- Python 3.9.18
- Grafana 11.2.1

## 목표
- 모집 공고, 병원 홈페이지에서 제공하는 검진 결과를 파싱, 동일 병원 방문 시 재사용할 수 있도록.
- 코드로 처리될 수 있는 값들은 업무/공통 코드 테이블에 입력.
- 피실험자 이름, 주민등록번호 AES256 암호화 처리, 암/복호화 key는 갱신될 수 있도록.
- 화면에서 출력하는 개인 정보는 마스킹 처리.
- 피실험자 key로 일괄 삽입, 삭제 처리.
- 정상 범위 min-max 값을 벗어나는 경우 ×표시와 경고 색상 처리, 정상은 ✓로 표시.

## 기초 데이터 수집
![image](https://github.com/dntco43u/med_exam/blob/main/img/base_data.webp? "피실험자에게 공개된 기초 데이터 html")
![image](https://github.com/dntco43u/med_exam/blob/main/img/test_rslt.webp? "피실험자에게 공개된 검사 결과 html")

## 설계
모델 설계
![image](https://github.com/dntco43u/med_exam/blob/main/pgsql/erd/med_exam.webp?)

## 구현
- [데모 페이지 1](https://gr.gvp6nx1a.duckdns.org/d/fdyt7rjk3owzkd/med-exam?orgId=1)[^1]
- [데모 페이지 2](https://agknwpt3.grafana.net/d/fdyt7rjk3owzkd/med-exam?orgId=1&from=2024-07-23T15:00:00.000Z&to=2024-09-09T14:59:59.000Z&timezone=Asia%2FSeoul&var-usr_id=9VFsW2u8mIqFXMlG7f6irg%3D%3D&var-exam_type_cd=002&var-exam_id=RT51KR-PK01&var-rslt_ymd=$__all&var-exam_a_gb_cd=$__all&var-grdng_cd=$__all&var-exam_b_gb_cd=$__all&var-ai_model=$__all)[^2]

![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page1.webp?)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page2.webp?)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page3.webp?)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page4.webp?)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page5.webp?)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page6.webp?)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page7.webp?)

[^1]: grafana 계정 불필요. 무료 dns라 불안정함. 여러 차례 시도해야 할 수 있음. ([데모 페이지 상태 확인](https://up.gvp6nx1a.duckdns.org/status/grafana))
[^2]: grafana 계정 필요.
