output "vm_id" {
  value = resource.vsphere_virtual_machine.vm.id
}

output "vm_default_ip_address" {
  value = resource.vsphere_virtual_machine.vm.default_ip_address
}

output "vm_guest_ip_address" {
  value = resource.vsphere_virtual_machine.vm.guest_ip_addresses
}