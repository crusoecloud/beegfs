terraform {
  required_providers {
    crusoe = {
      source = "registry.terraform.io/crusoecloud/crusoe"
    }
  }
}

provider "crusoe" {
  # Your authentication settings or configuration file details here
}

variable "public_ssh_key" {
  description = "Public SSH key for instance access"
  type        = string
  default     = "todo"
}

variable "location" {
    type        = string
    default = "us-southcentral1-a"
}

variable "project_id" {
    type        = string
    default = "todo" 
}

variable "image" {
    type        = string
    default = "ubuntu22.04" 
}

variable "connauthkey" {
  type = string
  # can be any value, but should be used by all nodes in the deployment
  default = "12345"
}

resource "crusoe_compute_instance" "storage" {
  count = 2
  
  name        = "tf-storage-${count.index}"
  type = "s1a.80x"
  ssh_key       = var.public_ssh_key
  project_id = var.project_id
  location = var.location
  image = var.image

  startup_script = "${file("startup_scripts/general_setup.sh")}\n${templatefile("startup_scripts/storage_setup.sh.tpl", { location = var.location, connauthkey = var.connauthkey})}"
}

resource "crusoe_compute_instance" "client" {

  name        = "beegfs-client"
  type = "c1a.4x"
  ssh_key       = var.public_ssh_key
  project_id = var.project_id
  location = var.location
  image = var.image

  startup_script = "${file("startup_scripts/general_setup.sh")}\n${templatefile("startup_scripts/client_setup.sh.tpl", { location = var.location, connauthkey = var.connauthkey })}"
}

resource "crusoe_compute_instance" "metadata" {
  name          = "metadata"
  type = "c1a.4x"
  ssh_key       = var.public_ssh_key
  project_id = var.project_id
  location = var.location
  image = var.image
  startup_script = "${file("startup_scripts/general_setup.sh")}\n${templatefile("startup_scripts/metadata_setup.sh.tpl", { location = var.location, connauthkey = var.connauthkey })}"
}

resource "crusoe_compute_instance" "management" {
  name          = "management"
  type = "c1a.4x"
  ssh_key       = var.public_ssh_key
  project_id = var.project_id
  location = var.location
  image = var.image
  startup_script = "${file("startup_scripts/general_setup.sh")}\n${templatefile("startup_scripts/management_setup.sh.tpl", { location = var.location, connauthkey = var.connauthkey })}"
}

# Output the IPs of the created instances (if applicable)
output "storage_ips" {
  value = crusoe_compute_instance.storage[*].network_interfaces[0].public_ipv4
}

output "metadata_ip" {
  value = crusoe_compute_instance.metadata.network_interfaces[0].public_ipv4
}

output "management_ip" {
  value = crusoe_compute_instance.management.network_interfaces[0].public_ipv4
}

output "client_ip" {
  value = crusoe_compute_instance.client.network_interfaces[0].public_ipv4
}
