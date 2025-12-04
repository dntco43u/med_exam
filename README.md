# med_exam

## 목표
생동성 임상시험 피실험자에게 공개된 검사 데이터를 가공 후 시각화하고 AI 소견을 받을 수 있도록 함.

## 기초 데이터
![피실험자에게 공개된 기초 데이터](https://github.com/dntco43u/med_exam/blob/main/img/base_data.webp?raw=true)

피실험자에게 공개된 검사 결과 html
![image](https://github.com/dntco43u/med_exam/blob/main/img/test_rslt.webp?raw=true)

## 개발 도구
- PostgreSQL 16.4
- Python 3.9.18
- Grafana 11.2.1

## 설계
모델 설계
![image](https://github.com/dntco43u/med_exam/blob/main/pgsql/erd/med_exam.webp?raw=true)

## 구현
[데모 페이지 상태 확인, dns가 불안정하여 자주 내려감](https://up.gvp6nx1a.duckdns.org/status/grafana)
[데모 페이지](https://gr.gvp6nx1a.duckdns.org/d/fdyt7rjk3owzkd/med-exam?orgId=1)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page1.webp?raw=true)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page2.webp?raw=true)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page3.webp?raw=true)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page4.webp?raw=true)
