variable "asg_id" {
  default = "K8-asg"
} 

variable "lc_instancetype" {
  default = "t3.medium"
} 

variable "asg_subnet" {}  

variable "asg_subnet2" {} 

variable "launch_config_ami" {
  default = "launch_config_ami"
} 

variable "ami_source_instance" {} 

variable "asg_policy" {
  default = "K8-asg-policy"
} 

variable "sg_name" {} 

variable "keypair" {} 

variable "lb_tg_arn" {} 

variable "asg_policy_targetvalue" {
  default = 60.0
}