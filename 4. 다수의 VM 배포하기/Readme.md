# Terraform - 다수의 VM 배포하기
## 참고 링크
- [테라폼 활용 VMware 자동화 - (4)](https://tinted-tapir-06c.notion.site/VMware-4-1cb07373030f80d0a5e5c05fb656cd5c?pvs=74)

## 실행 방법
1. `terraform.tfvars.sample`에서 .sample을 지우고 vSphere 서버 정보를 입력
2. `terraform init` : 프로바이더 구성 -> 오류 시 vsphere provider 버전 확인
3. `terraform plan` : vSphere 서버와 연결 구성 -> 오류 시 vSphere 서버 정보 재확인 + 에러 확인
4. `terraform apply --auto-approve`
## 출력 결과
* 서로 다른 이름을 가진 VM 생성
    * count를 사용한 VM 생성
      
      ![image](https://github.com/user-attachments/assets/fe71d671-21ff-4cd3-ab40-33e58266f49f)
    * for_each를 사용한 VM 생성
      
      ![image](https://github.com/user-attachments/assets/e88f2f0a-fd3a-47ae-9d06-6b6f79b0849c)

## 결과 분석
- count를 이용할 경우 동일한 환경을 가진 다수의 VM을 빠르게 구성할 수 있었다. 
    VM 마다 복잡한 환경 설정이 요구되지 않고 동일한 환경을 구축한다면 count가 적절할 것으로 판단된다.
- for_each를 이용할 경우 특정 값을 주입하며 다수의 VM을 빠르게 구성할 수 있었다.
    VM 마다 다른 값을 넣어줘야 하는 경우 (ex. hostname 등) 유용하게 사용할 수 있을 것으로 판단된다.
- 다만, for_each 문으로 복잡한 구성을 하면 할 수록 코드가 길고 가독성이 떨어져 다른 방법이 있어야 할 것 같다. 
