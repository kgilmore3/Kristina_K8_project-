variable "ami" {
    default = "ami-0735c191cf914754d"
}

variable "inst-type" {
    default = "t3.medium"
}

variable "prvsubnet" {
    default = "privatesubnet"
}

variable "kp" {
    default = "K8_kp"
}

variable "ansible-sg" {
    default = "sgid787888"
}

variable "bashion_public_ip" {
    default = "13.23.43.33"
}

variable "mn_priv_ip1" {
    default = "13.23.43.33"
}

variable "mn_priv_ip2" {
    default = "13.23.43.33"
}

variable "mn_priv_ip3" {
    default = "13.23.43.33"
}

variable "wn_priv_ip1" {
    default = "13.23.43.33"
}

variable "wn_priv_ip2" {
    default = "13.23.43.33"
}

variable "iam-profile" {
    default = "iamprofile"
}

variable "HA_priv_ip"{
    default = "13.23.43.33"
}

