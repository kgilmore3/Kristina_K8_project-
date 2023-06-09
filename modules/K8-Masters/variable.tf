variable "ami" {
    default = "ami-0735c191cf914754d"
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

variable "MN-host" {
    default = "Master_Node-"
}

variable "instance_count" {
    default = 3
}
