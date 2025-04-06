output "vm_name"{
  value = [for vm in vsphere_virtual_machine.multi_vm_deploy : vm.name]
}

output "vm_host_names"{
  value = [for id, service in var.host_names : "map's key: ${id} map's value: ${service}"]
}