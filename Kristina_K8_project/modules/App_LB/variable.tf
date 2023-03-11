variable "lb_name" {
    default = "K8-lb"
} 

variable "lb_sg" {} 

variable "lb_subnet2" {} 

variable "lb_subnet1" {} 

variable "lb-tg" {
  default = "K8-lb-tg"
} 

variable "vpc" {} 

variable "lb-tg_port" {
  default = 30220
}

variable "lb_tg_targettype" {
  default = "instance"
}  

variable "lb_listener_port" {
  default = 80
} 

variable "protocol" {
  default = "HTTP"
} 

variable "lb_instance" {}