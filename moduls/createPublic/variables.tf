variable "subnetCIDRS" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
  description = "Ip adresses to public subnets. Depending on the number of ip, the number of subnets is created"
}

variable "vnetCIDRS" {
    type        = string
    default     = "10.0.0.0/16"
    description = "Ip adresses to virtual network"
}

variable "subnetPrivateCIDRS" {
    type        = string
    default     = "10.0.20.0/24"
    description = "Ip adresses to private subnets"
}

variable "resource_prefix" {
    type        = string
    default     = "BootcampTerraform1"
    description = "Service prefix to use for naming of resources."
}

# Define Azure region for resource placement.
variable "location" {
    type        = string
    default     = "westus"
    description = "Azure region for deployment of resources."
}

variable "resource_group_name" {
    type        = string
    default     = "bootcamp"
    description = "Resource group name where the network created"
}

# Define the common tags for all resources.
variable "tags" {
    description = "A map of the tags to use for the resources"
    type = map

    default = {
        name    = "BootcampTerraform"
        owner   = "Alex Merkushyn"
        mail    = "amerkushin@gmail.com"
    }
}
variable "password" {
    type        = string
    default     = "Password1234!"
    description = "Password from ubuntu"
}

variable "passwordDb" {
    type        = string
    default     = "p@ssw0rd42"
    description = "Password from postgresql"
}

variable "usernameDb" {
    type        = string
    default     = "postgres"
    description = "User from Postgresql"
}

variable "username" {
    type        = string
    default     = "alex"
    description = "User from ubuntu"
}

variable "port22IP" {
  type = string
  default = "176.12.157.175"
}
