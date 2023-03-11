variable "name" {
  description = "Name to be associated with all resources for this Project"
  type        = string
  default     = "K8"
}

variable "k8-vpc" {
  default = "vpc-09e65c2c07a323881"
}

#Various Ports
variable "http_port" {
  default     = 80
  description = "this port allows http access"
}

variable "proxy_port1" {
  default     = 8080
  description = "this port allows proxy access"
}

variable "ssh_port" {
  default     = 22
  description = "this port allows ssh access"
}

variable "all_access" {
  default = "0.0.0.0/0"
}
