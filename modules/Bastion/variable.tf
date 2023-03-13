variable "ami" {
    default = "ami-0735c191cf914754d"
}

variable "inst-type" {
    default = "t3.medium"
}

variable "pubsubnet" {
    default = "privatesubnet"
}

variable "key_name" {
    default = "K8-kp"
}

variable "bastion-sg" {
    default = "sgid787888"
  
}

variable "bastion-host" {
    default = "Bastion"
  
}