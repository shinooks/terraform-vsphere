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
  ![image](https://github.com/user-attachments/assets/b71b95be-5bc7-4a42-9d69-1ed588e146ea)


## 결과 분석
- ESXi 서버는 OVF Property를 설정하더라도 데이터를 보관할 수 없어 가상머신 생성 시 OVF 런타임 환경에 주입할 수 없음
- 단일 ESXi 서버에서 가장 적합한 방법은 cdrom을 활용해 user-data와 meta-data를 가상머신 생성 시 함께 주입하는 방식
- 이 방법을 사용해 모든 VM에 sudo 권한을 가진 동일한 사용자 계정을 구성할 수 있었다.
- 단, 이 방식으로 VM마다 다른 환경을 구성하기에는 어려움이 있을 것으로 생각된다.
