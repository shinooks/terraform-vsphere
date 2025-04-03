
data "vsphere_datacenter" "dc" {
  name = "datacenter1"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "Resource"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_datastore" "ds" {
  name          = "datastore1"  # ESXi 서버의 데이터스토어 이름
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "nw" {
  datacenter_id = data.vsphere_datacenter.dc.id
  name          = "VM Network" # ESXi 서버에 구성된 네트워크 이름
}


data "vsphere_host" "host" {
  datacenter_id = data.vsphere_datacenter.dc.id
}

