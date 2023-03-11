variable "jenkins-lb-name" {
    default = "Jenkins-elb"
}

variable "subnet_id1" {
  default     = "subnetid"
}

variable "subnet_id2" {
  default     = "subnetid"
}

variable "securitygroup_id" {
   default= "securityid"
}

variable "lb_instance_port" {
    default = 8080
    description = "Jenkins loadbalance listen port"
}

variable "instance-lb_protocol" {
   default = "http"
   description = "Instance and lb protocol"
}

variable "lb_port" {
    default = 80
    description = "lb listening port"
}

variable "healthy_threshold" {
    default = 2
}

variable "unhealthy_threshold" {
    default = 2
}

variable "timeout" {
    default = 3
}

variable "interval" {
    default = 30
}

variable "idle_timeout" {
    default = 400
}

variable "connection_draining_timeout" {
    default = 400
}

variable "instance_id" {
    default = "instanceid"
}

