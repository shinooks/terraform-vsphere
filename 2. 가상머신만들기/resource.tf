resource "vsphere_virtual_machine" "vm" {
  name             = "wooks-vm"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.nw.id
  }
  disk {
    label = "Hard Disk 1"
    size  = 20
  }
  # 부팅을 위한 CD/DVD 드라이브 마운트
  cdrom {
  client_device = false
  datastore_id  = data.vsphere_datastore.ds.id
  path          = "ubuntu-22.04.5-live-server-amd64.iso" # datastore를 기준으로 하는 경로
  }
}