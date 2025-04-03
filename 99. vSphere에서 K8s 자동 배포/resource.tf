# ## Deployment of VM from Remote OVF
# resource "vsphere_virtual_machine" "vmFromRemoteOvf" {
#   name                 = "wooks-vm"
#   datacenter_id        = data.vsphere_datacenter.dc.id
#   datastore_id         = data.vsphere_datastore.ds.id
#   host_system_id       = data.vsphere_host.host.id
#   resource_pool_id     = data.vsphere_resource_pool.pool.id

#   num_cpus         = 2
#   memory           = 2048

#   wait_for_guest_net_timeout = 0
#   wait_for_guest_ip_timeout  = 0

#   ovf_deploy {
#     allow_unverified_ssl_cert = false
#     remote_ovf_url            = "http://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova"
#     disk_provisioning         = "thin"
#     ip_protocol               = "IPV4"
#     ip_allocation_policy      = "STATIC_MANUAL"
#     ovf_network_map = {
#       "Network 1" = data.vsphere_network.nw.id
#       "Network 2" = data.vsphere_network.nw.id
#     }
#   }
#   vapp {
#     properties = {
#       "hostname"     = "ubuntu"
#       "password"     = "VMware1!"
#       "user-data"   = "I2Nsb3VkLWNvbmZpZwp1c2VyczoKICAtIG5hbWU6IHVzZXIKICAgIHN1ZG86IEFMTD0oQUxMKSBOT1BBU1NXRDpBTEwKICAgIHNoZWxsOiAvYmluL2Jhc2gKICAgIHNzaF9hdXRob3JpemVkX2tleXM6CiAgICAgIC0gc3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBQkl3QUFBR0VBM0ZTeVF3Qkk2WituQ1NqVVVrOEVFQW5ua2hYbHVrS29VUE5EL1JSQ2xXejJzNVRDeklrZDNPdTUrQ3l6NzFYMFhtYXpNM2w1V2dlRXJ2dEl3UU15VDFLak5vTWhvSk1ySm5XcVFQT3Q1UTh6V2Q5cUc3UEJsOStlaUg1cVY3TloKY2hwYXNzd2Q6CiAgbGlzdDogfAogICAgdXNlcjp1c2VyCiAgZXhwaXJlOiBmYWxzZQpzc2hfcHdhdXRoOiB0cnVl"
#      }
#   }
#   scsi_type             = "lsilogic"
#   scsi_controller_count = 1
#   firmware              = "bios"
#   boot_delay            = 5000
#   boot_retry_delay      = 10000
# }

# output "user-data" {
#     value=base64encode(file("${path.module}/user-data.yaml"))
# }

data "vsphere_ovf_vm_template" "ovfRemote" {
  name              = "ubuntu-server-cloud-image-01"
  disk_provisioning = "thin"
  resource_pool_id  = data.vsphere_resource_pool.pool.id
  datastore_id      = data.vsphere_datastore.ds.id
  host_system_id    = data.vsphere_host.host.id
  remote_ovf_url    = "http://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova"
  ovf_network_map = {
    "VM Network" : data.vsphere_network.nw.id
  }
}

## Deployment of VM from Remote OVF
resource "vsphere_virtual_machine" "vmFromRemoteOvf" {
  name                 = "ubuntu-server-cloud-image-01"
  datacenter_id        = data.vsphere_datacenter.dc.id
  datastore_id         = data.vsphere_datastore.ds.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = data.vsphere_resource_pool.pool.id
  num_cpus             = data.vsphere_ovf_vm_template.ovfRemote.num_cpus
  num_cores_per_socket = data.vsphere_ovf_vm_template.ovfRemote.num_cores_per_socket
  memory               = data.vsphere_ovf_vm_template.ovfRemote.memory
  guest_id             = data.vsphere_ovf_vm_template.ovfRemote.guest_id
  firmware             = data.vsphere_ovf_vm_template.ovfRemote.firmware
  scsi_type            = data.vsphere_ovf_vm_template.ovfRemote.scsi_type

  dynamic "network_interface" {
    for_each = data.vsphere_ovf_vm_template.ovfRemote.ovf_network_map
    content {
      network_id = network_interface.value
    }
  }

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    remote_ovf_url            = data.vsphere_ovf_vm_template.ovfRemote.remote_ovf_url
    disk_provisioning         = data.vsphere_ovf_vm_template.ovfRemote.disk_provisioning
    ovf_network_map           = data.vsphere_ovf_vm_template.ovfRemote.ovf_network_map
  }

  cdrom {
    client_device = true
  }

  vapp {
    properties = {
      "hostname"    = "test"
      "password"    = "root"
      "user-data"   = base64encode(file("${path.module}/user-data.yaml"))
    }
  }

  lifecycle {
    ignore_changes = [
      vapp[0].properties,
    ]
  }
}