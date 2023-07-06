# provider vars
variable "proxmox_api_url"{
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
}

# resource vars
variable "proxmox_host" {
  type = string
  default = "pve"
}
variable "template_name" {
  type = string
  default = "ubuntu-cloud-15gb"
}
variable "ansible_user"{
  default = "dheerajpotluri"
  type = string
}

variable "private_key_path"{
  type = string
}

variable "public_key_path"{
  type = string
}

variable "ssh_key" {
  type = string
}
