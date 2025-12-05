# med_exam

## 목표
건강검진 및 생동성, 임상시험 피실험자에게 공개된 검사 데이터를 가공 후 시각화하고 AI 소견을 받을 수 있도록 함.

## 개발 도구
- PostgreSQL 16.4
- Python 3.9.18
- Grafana 11.2.1

## 기초 데이터 수집
모집 공고와 이메일 등으로 제공되는 검진 결과를 BeautifulSoup으로 구문분석함.
![image](https://github.com/dntco43u/med_exam/blob/main/img/base_data.webp?raw=true "피실험자에게 공개된 기초 데이터 html")
![image](https://github.com/dntco43u/med_exam/blob/main/img/test_rslt.webp?raw=true "피실험자에게 공개된 공개된 검사 결과 html")

## 설계
모델 설계
![image](https://github.com/dntco43u/med_exam/blob/main/pgsql/erd/med_exam.webp?raw=true)

## 구현
- [데모 페이지](https://gr.gvp6nx1a.duckdns.org/d/fdyt7rjk3owzkd/med-exam?orgId=1)[^1]

![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page1.webp?raw=true)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page2.webp?raw=true)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page3.webp?raw=true)
![image](https://github.com/dntco43u/med_exam/blob/main/img/demo_page4.webp?raw=true)

[^1]: [데모 페이지 상태 확인](https://up.gvp6nx1a.duckdns.org/status/grafana) (무료 dns라 불안정함. 여러 차례 시도해야할 수 있음)
