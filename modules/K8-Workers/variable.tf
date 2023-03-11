variable "ami" {
    default = "ami-0aaa5410833273cfe" 
}

variable "inst-type" {
    default = "t3.medium"
}

variable "prvsubnet" {
    default = "privatesubnetID"
}

variable "kp" {
    default = "k8_kp"
}

variable "K8-sg" {
    default = "sgid787888"
}

variable "WN-host" {
    default = "Worker_Node"
}

variable "instance_count" {
    default = 2
}

