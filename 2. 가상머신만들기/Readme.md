# Terraform - 가상 머신 만들기
## 참고 링크
- [테라폼 활용 VMware 자동화 - (2)](https://tinted-tapir-06c.notion.site/VMware-2-1ca07373030f80ac9fa6e25d64570b39?pvs=74)
## 사전 구성
1. ubuntu_server_22.04.iso 이미지 설치
2. esxi 서버 내 탐색기 → 관리 → 서비스 → 이름이 TSM-SSH인 서비스 활성화 (SFTP 용도)
   ![image](https://github.com/user-attachments/assets/d74e0194-3776-4ba2-b0e5-8279507c4c71)

4. FileZilla 등 SFTP 기능이 지원되는 클라이언트로 iso 파일을 데이터 스토어로 전달
  - 저장 경로: `/vmfs/volumes/datastore1/`
## 실행 방법
1. `terraform.tfvars.sample`에서 .sample을 지우고 ESXi 서버 정보를 입력
2. `terraform init` : 프로바이더 구성 -> 오류 시 vsphere provider 버전 확인
3. `terraform plan` : vSphere 서버와 연결 구성 -> 오류 시 vSphere 서버 정보 재확인 + 에러 확인
4. `terraform apply --auto-approve`
## 출력 결과
```
Outputs:

vm_default_ip_address = "192.168.0.11"
vm_guest_ip_address = tolist([
  "192.168.0.11",
  "fe80::20c:29ff:fe18:c571",
])
vm_id = "564d341c-6a4f-090c-3485-c710de18c571"
```
![image](https://github.com/user-attachments/assets/b1f84898-4848-43bc-abbd-93c163d0f2fe)

## 결과 분석

- 일반 iso 파일을 이용할 경우 VM이 생성된 후에 수동으로 인스톨 해야 하는 문제가 발생했다.
- VM이 자동으로 구성된다면 좋을 것 같다.
- 이미지가 바뀔 때마다 데이터 스토어에 파일을 넣어야 하는 번거로움 존재

## 트러블 슈팅
`Error: timeout waiting for an available IP address`
- 이 메시지는 VM 생성 과정에서 **부팅 디스크도 없고, 네트워크에서도 부팅 이미지를 찾지 못해 발생**
- 콘솔을 확인하면 PXE 부팅을 시도하다 부팅 이미지를 찾지 못해 타임 아웃
  - PXE 부팅 (Preboot eXecution Environment)은 네트워크를 통해 부팅 이미지를 받는 방식
  - ![image](https://github.com/user-attachments/assets/1999e040-172b-4229-8ddd-ebd8df1ff823)
