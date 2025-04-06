## VM을 생성하며 초기 환경 구성하기
resource "vsphere_virtual_machine" "configed_vm" {
  name = "default-vm-name"
  datacenter_id        = data.vsphere_datacenter.dc.id
  datastore_id         = data.vsphere_datastore.ds.id
  host_system_id    = data.vsphere_host.host.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
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
    client_device = true
  }

  vapp {
    properties = {
      "hostname"    = "nginx-test-vm"
      "instance-id" = "test-1"
      "public-keys" = file("${path.module}/ssh-key/id_ed25519.pub")
      "password"    = "ubuntu"
      "user-data"   = base64encode(file("${path.module}/user-data/vapp-config.sh"))
      }
  }
}


