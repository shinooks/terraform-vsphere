## 다수의 VM 배포하기
resource "vsphere_virtual_machine" "multi_vm_deploy" {
  # count를 이용해 VM 반복 구성
  # count = 4
  # name                 = "wooks-vm-${count.index}"

  # # for_each와 list 이용해 VM 반복 구성
  # for_each = toset(var.host_names)
  # name = "wooks-vm-${each.value}"

  # for_each와 map을을 이용해 VM 반복 구성
  for_each = var.host_names
  name = "wooks-${each.key}-${each.value}"

  datacenter_id        = data.vsphere_datacenter.dc.id
  datastore_id         = data.vsphere_datastore.ds.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = data.vsphere_host.host.resource_pool_id
  num_cpus         = 1
  memory           = 1024
  network_interface {
    network_id = data.vsphere_network.nw.id
  }

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    remote_ovf_url            = "http://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.nw.id
      "Network 2" = data.vsphere_network.nw.id
    }
  }
 
  cdrom {
    client_device = false # Datastore나 가상 디스크에 있는 파일을 읽을 때는 false
    datastore_id  = data.vsphere_datastore.ds.id
    path          = "ubuntu-cloud-init-data.iso"
  }
}



