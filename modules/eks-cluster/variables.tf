variable "cluster_name" {
   type = string 
}
variable "cluster_version" {
   type = string  default = "1.30" 
}
variable "vpc_id" {
   type = string 
}
variable "private_subnets" {
   type = list(string) 
}
variable "public_subnets" {
   type = list(string) 
}
variable "tags" {
   type = map(string) default = {
  } 
}

variable "system_instance_types" {
   type = list(string) default = ["t3.medium"] 
}
variable "work_instance_types"   {
   type = list(string) default = ["m6a.large", "m6i.large", "c6a.large"] 
}
variable "min_size_system" {
   type = number default = 1 
}
variable "max_size_system" {
   type = number default = 2 
}
variable "desired_size_system" {
   type = number default = 1 
}
variable "min_size_work" {
   type = number default = 0 
}
variable "max_size_work" {
   type = number default = 6 
}
variable "desired_size_work" {
   type = number default = 1 
}
variable "enable_spot_work" {
   type = bool default = true 
}
