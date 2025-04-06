# Terraform - vSphere에서 vApp을 통한 서로 다른 환경의 VM 구성
## 참고 링크
- [테라폼 활용 VMware 자동화 - (5)](https://tinted-tapir-06c.notion.site/VMware-5-1cd07373030f80ffb742e5442f91de58?pvs=74)

## 실행 방법
1. `terraform.tfvars.sample`에서 .sample을 지우고 vSphere 서버 정보를 입력
2. `terraform init` : 프로바이더 구성 -> 오류 시 vsphere provider 버전 확인
3. `terraform plan` : vSphere 서버와 연결 구성 -> 오류 시 vSphere 서버 정보 재확인 + 에러 확인
4. `terraform apply --auto-approve`
## 출력 결과
* hostname과 초기 패스워드, 원격 SSH 접근 키 설정된 VM 생성

* sudo 설정이 된 테스트 계정과 nginx가 설치된 VM 생성성

## 결과 분석
- 클라우드 환경과 마찬가지로 user-data(쉘 스크립트)를 주입해 초기 환경이 구성되도록 테라폼 구성
- VM마다 서로 다른 user-data를 주입하는 방식을 통해 다양한 환경을 구성할 수 있을 것으로 판단 
