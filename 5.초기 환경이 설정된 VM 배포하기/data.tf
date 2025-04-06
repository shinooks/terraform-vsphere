
data "vsphere_datacenter" "dc" {
  name = "datacenter1"
}


data "vsphere_compute_cluster" "cluster" {
  name          = "cluster1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = "192.168.0.5" # vSphere에 연결된 ESXi 서버의 호스트명 또는 IP
  datacenter_id = data.vsphere_datacenter.dc.id
}

## cluster 없이 host만 사용 시 리소스 풀을 별도로 구성, Cluster 구성 시 리소스는 따로 구성 X
# data "vsphere_resource_pool" "pool" {
#   name          = "resource-pool-01" # 호스트에 구성한 리소스풀 이름
#   datacenter_id = data.vsphere_datacenter.dc.id
# }


data "vsphere_datastore" "ds" {
  name          = "datastore1"  # vsphere에 구성한 데이터스토어 이름 (기본값 datastore1)
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "nw" {
  datacenter_id = data.vsphere_datacenter.dc.id
  name          = "VM Network" # vsphere에 구성된 네트워크 이름 (기본 값: VM Network)
}
