variable "ami" {
    default = "ami-0aaa5410833273cfe"
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