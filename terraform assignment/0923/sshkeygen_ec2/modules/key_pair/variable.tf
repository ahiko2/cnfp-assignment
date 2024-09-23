variable "deployment_name" {
  description = "The name of the deployment"
  type        = string

}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "ec2_ssh_keypair_name" {
  type        = string
  description = "Name of EC2 SSH key pair."
  default     = "ec2-keypair"
}


