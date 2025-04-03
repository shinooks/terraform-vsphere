# Terraform - OS 환경이 구성된 VM 생성하기
## 참고 링크
- [테라폼 활용 VMware 자동화 - (3)](https://tinted-tapir-06c.notion.site/VMware-3-1ca07373030f80b592cee2e178b26f56?pvs=74)

## 실행 방법
1. `terraform.tfvars.sample`에서 .sample을 지우고 vSphere 서버 정보를 입력
2. `terraform init` : 프로바이더 구성 -> 오류 시 vsphere provider 버전 확인
3. `terraform plan` : vSphere 서버와 연결 구성 -> 오류 시 vSphere 서버 정보 재확인 + 에러 확인
4. `terraform apply --auto-approve`
## 출력 결과
* 만들어진 VM에 ubuntu/ubuntu로 로그인 가능

## 결과 분석
- 현재 구성에서 가장 적합한 방법은 Cloud-init.iso 파일을 우분투 설치 시 함께 부팅 시키는 방식
- 이 방법을 사용하면 모든 VM에 sudo 권한을 가진 동일한 사용자 계정을 구성할 수 있었다.
- 이 방식으로 생성된 VM이 모두 같은 환경(동일 IP) 또는 무작위 환경(DHCP)로 구성된다면 서버 간 통신을 구성할 때 어려움이 있을 것으로 생각된다다
