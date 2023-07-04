variable "Region" {
  type = string
  default = "us-east-1"
}
variable "Access_Key" {
  type = string
}
variable "Secret_Key" {
  type = string
}
variable "VPC_cidr" {
  type = string
  default = "20.15.0.0/16"
}
variable "Subnet_cidr" {
  type = string
  default = "20.15.5.0/24"
}
variable "Availability_Zone" {
  type = string
  default = "us-east-1a"
}