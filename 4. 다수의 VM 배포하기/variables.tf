variable vsphere_server {}
variable vsphere_user{}
variable vsphere_password{}

# # 리스트 형태의 variable
# variable "host_names" {
#   description = "3 Tier VM's Hostname List"
#   type        = list(string)
#   default     = ["web", "was", "db"]
# }

# map 형태의 variable
variable "host_names" {
  description = "3 Tier VM's instance-id:hostname"
  type        = map(string)
  default     = {
     "instance1" = "web"
     "instance2" = "was"
     "instance3" = "db"
  }
}