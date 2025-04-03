# Terraform - vSphere 필수 데이터 추출
## 참고 링크
- vSphere 최신 버전: https://registry.terraform.io/providers/hashicorp/vsphere/latest
- vsphere Docs 링크: https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs
- [테라폼 활용 VMware 자동화 - (1)](https://tinted-tapir-06c.notion.site/VMware-1-1bb07373030f80e5b584f112b41a466c?pvs=74)
## 실행 방법
1. `terraform.tfvars.sample`에서 .sample을 지우고 vSphere 서버 정보를 입력
2. `terraform init` : 프로바이더 구성 -> 오류 시 vsphere provider 버전 확인
3. `terraform plan` : vSphere 서버와 연결 구성 -> 오류 시 vSphere 서버 정보 재확인 + 에러 확인
4. `terraform apply --auto-approve`: 프로비저닝 할 리소스가 없어 오류 X -> Output 결과물 확인
## 출력 결과
```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

datacenter_id = "ha-datacenter"
datastore_id = "67dba1a8-fe6e713f-e11a-000c290dd921"
datastore_stats = tomap({
  "capacity" = "14763950080"
  "free" = "13255049216"
})
host_id = "ha-host"
host_resource_pool = "ha-root-pool"
network_id = "HaNetwork-VM Network"
network_type = "Network"
resource_pool_id = "ha-root-pool"
```
