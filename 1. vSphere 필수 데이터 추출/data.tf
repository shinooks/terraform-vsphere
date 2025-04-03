
data "vsphere_datacenter" "dc" {
  # name = "ha-datacenter"
}

data "vsphere_resource_pool" "pool" {
  # name          = "ha-root-pool"
  # datacenter_id = data.vsphere_datacenter.dc.id
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


output "datacenter_id" {
  value = data.vsphere_datacenter.dc.id
}

output "host_id" {
  value = data.vsphere_host.host.id
}
output "host_resource_pool" {
  value = data.vsphere_host.host.resource_pool_id
}

output "resource_pool_id" {
  value = data.vsphere_resource_pool.pool.id
}

output "datastore_id" {
  value = data.vsphere_datastore.ds.id
}

output "datastore_stats" {
  value = data.vsphere_datastore.ds.stats
}

output "network_id" {
  value = data.vsphere_network.nw.id
}

output "network_type" {
  value = data.vsphere_network.nw.type
}