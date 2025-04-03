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