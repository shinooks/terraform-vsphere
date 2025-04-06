## Deployment of VM from Remote OVF
resource "vsphere_virtual_machine" "vmFromRemoteOvf" {
  name                 = "wooks-vm3"
  datacenter_id        = data.vsphere_datacenter.dc.id
  datastore_id         = data.vsphere_datastore.ds.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = data.vsphere_host.host.resource_pool_id
  num_cpus         = 2
  memory           = 2048
  network_interface {
    network_id = data.vsphere_network.nw.id
  }

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    # CD-rom 방식 부팅 시 아래 경로 사용
    remote_ovf_url            = "http://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova"
    # 원격 ova 리포지터리를 사용하려면 아래 경로 사용
    # remote_ovf_url            = "https://swhwang-cloud-ova.s3.ap-northeast-2.amazonaws.com/ubuntu-noble-24.04-cloudimg-test.ova"
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