output "vm_id" {
    value = resource.vsphere_virtual_machine.configed_vm.id
}

output "vm_guest_id" {
    value = resource.vsphere_virtual_machine.configed_vm.guest_id
}

output "vm_default_ip_address" {
    value = resource.vsphere_virtual_machine.configed_vm.default_ip_address
}
